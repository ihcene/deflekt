#!/usr/bin/env ruby
# frozen_string_literal: true

# Selenium script to take landing page screenshots with domain-swapped content.
# Replaces all accounting/invoicing references with e-commerce/marketplace terminology
# and blurs any remaining sensitive text.
#
# Usage: ruby landing/take_screenshots.rb
#
# Prerequisites:
#   - Triage web server running at localhost:4567
#   - Chrome installed
#   - bundle install (selenium-webdriver gem)

require "selenium-webdriver"
require "fileutils"

BASE_URL = "http://localhost:4567"
OUTPUT_DIR = File.expand_path("screenshots", __dir__)

# Text replacements: accounting domain -> e-commerce domain
# Order matters: longer/more-specific patterns first to avoid partial matches
TEXT_REPLACEMENTS = [
  # Diff-specific: commercial document -> shipping label
  ["create_commercial_document", "create_shipping_label"],
  ["to_unsaved_commercial_document", "to_unsaved_shipping_label"],
  ["commercial_document_email", "shipping_label_email"],
  ["commercial_document_emails", "shipping_label_emails"],
  ["commercial_document_template", "shipping_label_template"],
  ["commercial_document", "shipping_label"],
  ["CommercialDocument", "ShippingLabel"],
  ["created_document", "created_label"],

  # Diff-specific: recurrent schedule -> recurring shipment
  ["ProcessRecurrentSchedulesJob", "ProcessRecurringShipmentsJob"],
  ["process_recurrent_schedules_job", "process_recurring_shipments_job"],
  ["RecurrentSchedule", "RecurringShipment"],
  ["recurrent_schedule", "recurring_shipment"],

  # Diff-specific: paths
  ["zen/app/models/", "platform/app/models/"],
  ["zen/", "platform/"],
  ["OpsNotifier", "ShipmentNotifier"],

  # Compound domain words (must be before individual word replacements)
  ["ComaxPeppolWebhookMessage", "AcmeStripeWebhookMessage"],
  ["ComaxPeppol", "AcmeStripe"],
  ["ConaxPeppolWebhookMessage", "AcmeStripeWebhookMessage"],
  ["ConaxPeppol", "AcmeStripe"],
  ["CoaxPeppol", "AcmeStripe"],
  ["comax_registration", "acme_registration"],
  ["review_comax", "review_acme"],
  ["Comax", "Acme"],
  ["comax", "acme"],
  ["conax_registration", "acme_registration"],
  ["review_conax", "review_acme"],

  # Multi-word phrases first (most specific)
  ["Factuur niet zichtbaar", "Bestelling niet zichtbaar"],
  ["factuur niet", "bestelling niet"],
  ["accounting firm", "merchant store"],
  ["Accounting firm", "Merchant store"],
  ["accounting_firm", "merchant_store"],
  ["AccountingFirm", "MerchantStore"],
  ["set_company_and_accounting_firm", "set_merchant_and_store"],
  [":iaccounting_firm", ":imerchant_store"],
  ["thumbnail race condition", "image sync race condition"],
  ["misrouted invoice", "misrouted order"],
  ["missing invoices", "missing orders"],
  ["invoice visibility filter", "order status filter"],
  ["app/models/admin_models/", "app/models/merchant/"],
  ["Stripe Connect", "Stripe Connect"],  # preserve if already replaced
  ["VAT declaration", "shipping label"],
  ["VAT deadline", "shipping deadline"],
  ["special VAT", "special shipping"],

  # Dutch accounting -> e-commerce
  ["Autokosten", "Verzendkosten"],
  ["autokosten", "verzendkosten"],
  ["facturatie", "orderverwerking"],
  ["Facturatie", "Orderverwerking"],
  ["facturen", "bestellingen"],
  ["Facturen", "Bestellingen"],
  ["factuur", "bestelling"],
  ["Factuur", "Bestelling"],
  ["boekhouding", "webshop"],
  ["Boekhouding", "Webshop"],
  ["boekhoudkantoor", "webshop"],
  ["aangifte", "verzending"],
  ["Aangifte", "Verzending"],
  ["vermelding", "productvermelding"],
  ["Gegevens", "Productgegevens"],

  # French accounting -> e-commerce
  ["factures", "commandes"],
  ["Factures", "Commandes"],
  ["facture", "commande"],
  ["Facture", "Commande"],
  ["comptabilit\u00e9", "plateforme e-commerce"],

  # English accounting -> e-commerce
  ["invoices", "orders"],
  ["Invoices", "Orders"],
  ["invoice", "order"],
  ["Invoice", "Order"],
  ["accounting", "e-commerce"],
  ["Accounting", "E-commerce"],

  # Domain-specific replacements
  ["Peppol", "Stripe Connect"],
  ["peppol", "stripe_connect"],
  ["PEPPOL", "STRIPE CONNECT"],
  ["P&L migration", "checkout migration"],
  ["P&L", "Checkout"],
  ["BTW schema", "shipping schema"],
  ["BTW", "shipping"],
  ["btw", "shipping"],
  ["KBO schema", "SKU catalog"],
  ["KBO", "SKU"],
  ["kbo", "sku"],
  ["VAT", "Shipping"],
  ["vat_submission", "shipping_label"],
  ["VatSubmission", "ShippingLabel"],
  ["DraftPurchases", "PendingOrders"],
  ["DraftPurchase", "PendingOrder"],
  ["draft_purchase", "pending_order"],

  # Product names
  ["Cashaca", "ShopFlow"],
  ["cashaca", "shopflow"],
  ["CASHACA", "SHOPFLOW"],

  # Model/code references
  ["contact_message", "support_ticket"],
  ["ContactMessage", "SupportTicket"],
  ["imported_payment", "imported_shipment"],
  ["ImportedPayment", "ImportedShipment"],
  ["outgoing_email", "notification_email"],

  # Ticket subjects
  ["Koppeling", "Integratie"],
  ["Dokter", "Verkoper"],
  ["Niet actief", "Niet verbonden"],

  # Company references
  ["Cowboy", "ShopFlow"],
  ["pia.be", "shopflow.io"],
  ["Ingram", "Acme"],

  # VZW (non-profit) -> marketplace seller type
  ["VZW", "B2B"],

  # Code variable names in briefing/analysis
  ["reallocation_of_vat", "reallocation_of_shipping"],
  ["delivered_outside_belgium", "shipped_internationally"],
  ["book_eu_sales_as_ic", "book_cross_border_order"],
  ["eu_sales_as_ic", "cross_border_order"],
  ["cost_categories", "product_categories"],
  ["CostCategories", "ProductCategories"],
  ["CostCategory", "ProductCategory"],
  ["cost_category", "product_category"],
  ["WithCostCategories", "WithProductCategories"],
  ["default_cost_categories", "default_product_categories"],
  ["setup_cost_categories_from_default", "setup_product_categories_from_default"],
  ["cost_type_id", "product_type_id"],

  # Ticket content replacements
  ["car cost deduction wizard", "shipping rate calculator"],
  ["deduction wizard", "rate calculator"],
  ["aftrekpercentage", "verzendtarief"],
  ["verzendkostenwizard", "verzendcalculator"],
  ["Autokosten", "Verzendkosten"],
  ["autokosten", "verzendkosten"],
  ["autokost", "verzendkost"],
  ["Autokost", "Verzendkost"],

  # Company/people names to generic
  ["Fidizaz", "FastMerch"],
  ["Fiduciaire", "Marketplace"],
  ["fiduciaire", "marketplace"],
  ["Dossier", "Account"],
  ["dossier", "account"],

  # More code paths
  ["purchase_items", "order_items"],
  ["PurchaseItem", "OrderItem"],
  ["purchase_item", "order_item"],

  # Belgian/tax specifics
  ["Belgian DD/MM/YYYY", "European DD/MM/YYYY"],
  ["Aankopen van grondstoffen", "Aankopen van producten"],
  ["Achats de mati\u00e8res premi\u00e8res", "Achats de produits"],
  ["I18n translations", "locale translations"],
  ["i18n", "locale"],
  ["I18n", "Locale"],
  ["I18N", "LOCALE"],

  # Webhook/registration
  ["CoaxStripe Connect", "StripeConnect"],
  ["Conax", "Acme"],
  ["conax", "acme"],
  ["Fidiaz", "FastMerch"],
  ["fidiaz", "fastmerch"],
  ["Fidizaz", "FastMerch"],
  ["fidizaz", "fastmerch"],
  ["conax_registration", "acme_registration"],
  ["review_conax", "review_acme"],
  ["ConaxPeppol", "AcmeStripeConnect"],
  ["CoaxPeppol", "AcmeStripeConnect"],
  ["ConaxStripe ConnectWebhookMessage", "AcmeStripeConnectWebhookMessage"],
  ["ConaxStripe Connect", "AcmeStripeConnect"],
  ["CoaxStripe Connect", "AcmeStripeConnect"],
  ["ConaxStripe", "AcmeStripe"],
  ["review_conax", "review_acme"]
]

# JS to walk all text nodes and replace content
REPLACE_TEXT_JS = <<~JS
  function replaceTextInPage(replacements) {
    // Walk all text nodes
    const walker = document.createTreeWalker(
      document.body,
      NodeFilter.SHOW_TEXT,
      null,
      false
    );
    const nodes = [];
    while (walker.nextNode()) nodes.push(walker.currentNode);

    nodes.forEach(node => {
      let text = node.textContent;
      let changed = false;
      for (const [from, to] of replacements) {
        if (text.includes(from)) {
          text = text.split(from).join(to);
          changed = true;
        }
      }
      if (changed) node.textContent = text;
    });

    // Replace in rendered HTML (for markdown content already in innerHTML)
    document.querySelectorAll('.markdown-body, article, .executive-brief, blockquote').forEach(el => {
      let html = el.innerHTML;
      let changed = false;
      for (const [from, to] of replacements) {
        if (html.includes(from)) {
          html = html.split(from).join(to);
          changed = true;
        }
      }
      if (changed) el.innerHTML = html;
    });

    // Replace inside code elements (often missed by tree walker)
    document.querySelectorAll('code, pre, .highlight').forEach(el => {
      let html = el.innerHTML;
      let changed = false;
      for (const [from, to] of replacements) {
        if (html.includes(from)) {
          html = html.split(from).join(to);
          changed = true;
        }
      }
      if (changed) el.innerHTML = html;
    });

    // Replace in input values and placeholders
    document.querySelectorAll('input, textarea').forEach(el => {
      for (const [from, to] of replacements) {
        if (el.value && el.value.includes(from)) el.value = el.value.split(from).join(to);
        if (el.placeholder && el.placeholder.includes(from)) el.placeholder = el.placeholder.split(from).join(to);
      }
    });
  }
JS

# JS to blur elements matching selectors or containing specific text
BLUR_SENSITIVE_JS = <<~JS
  function blurSensitive() {
    // Blur email addresses in text nodes
    const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, null, false);
    const nodes = [];
    while (walker.nextNode()) nodes.push(walker.currentNode);
    nodes.forEach(node => {
      if (node.textContent.match(/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}/)) {
        const span = document.createElement('span');
        span.textContent = node.textContent;
        span.style.filter = 'blur(4px)';
        span.style.userSelect = 'none';
        node.parentNode.replaceChild(span, node);
      }
    });

    // Blur Freshdesk/Sentry links in ticket meta
    document.querySelectorAll('.ticket-meta a[href*="freshdesk"], .ticket-meta a[href*="sentry"]').forEach(el => {
      el.style.filter = 'blur(4px)';
      el.style.userSelect = 'none';
    });

    // Blur internal tool URLs
    document.querySelectorAll('a[href*="craftzing"], a[href*="cashaca"], a[href*="pia.be"]').forEach(el => {
      el.style.filter = 'blur(4px)';
    });

    // Blur session resume commands
    document.querySelectorAll('code').forEach(el => {
      if (el.textContent.match(/claude.*--resume|cashaca|pia\\.be|craftzing|ihcene/i)) {
        el.style.filter = 'blur(4px)';
      }
    });

    // Blur customer names - look for patterns like "Firstname Lastname" in ticket subjects
    // and names that appear in "From:" or "Dossier" fields
    const namePatterns = [
      /Witvrouwen/i, /Jasmien/i, /Watteeyne/i, /Watteyne/i,
      /Hallo \w+,/,  // Blur greetings with names
      /Bonjour \w+,/
    ];
    const walker2 = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, null, false);
    const nodes2 = [];
    while (walker2.nextNode()) nodes2.push(walker2.currentNode);
    nodes2.forEach(node => {
      for (const pattern of namePatterns) {
        if (node.textContent.match(pattern)) {
          const span = document.createElement('span');
          span.textContent = node.textContent;
          span.style.filter = 'blur(3px)';
          span.style.userSelect = 'none';
          if (node.parentNode) node.parentNode.replaceChild(span, node);
          break;
        }
      }
    });
  }
JS

def setup_driver
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless=new")
  options.add_argument("--window-size=1400,1200")
  options.add_argument("--force-device-scale-factor=2")
  options.add_argument("--disable-gpu")
  options.add_argument("--no-sandbox")

  Selenium::WebDriver.for(:chrome, options: options)
end

def inject_replacements(driver)
  replacements_json = TEXT_REPLACEMENTS.to_json
  driver.execute_script(REPLACE_TEXT_JS + "\nreplaceTextInPage(#{replacements_json});")
end

def inject_blur(driver)
  driver.execute_script(BLUR_SENSITIVE_JS + "\nblurSensitive();")
end

def inject_all(driver)
  sleep 0.5
  inject_replacements(driver)
  # Second pass: brute-force innerHTML on body for stubborn elements
  replacements_json = TEXT_REPLACEMENTS.to_json
  driver.execute_script(<<~JS)
    (function(replacements) {
      let html = document.body.innerHTML;
      for (const [from, to] of replacements) {
        if (html.includes(from)) {
          html = html.split(from).join(to);
        }
      }
      document.body.innerHTML = html;
    })(#{replacements_json});
  JS
  sleep 0.3
  inject_blur(driver)
  sleep 0.3
end

def take_screenshot(driver, name)
  path = File.join(OUTPUT_DIR, "#{name}.png")
  driver.save_screenshot(path)
  puts "  -> Saved #{path}"
end

def screenshot_dashboard(driver)
  puts "Taking dashboard screenshot..."
  driver.get("#{BASE_URL}/")
  inject_all(driver)
  take_screenshot(driver, "dashboard_full")
end

def screenshot_ticket(driver)
  puts "Taking ticket analysis screenshot..."
  driver.get("#{BASE_URL}/")
  sleep 0.5

  # Get a ticket with high confidence (interesting analysis)
  links = driver.find_elements(:css, "table tbody tr td a")
  if links.any?
    # Try to find a bug ticket with confidence score
    href = nil
    driver.find_elements(:css, "table tbody tr").each do |row|
      cells = row.find_elements(:css, "td")
      confidence_cell = cells.find { |c| c.text.match?(/\d+%/) }
      if confidence_cell
        link = row.find_element(:css, "a") rescue nil
        if link
          href = link.attribute("href")
          break
        end
      end
    end
    href ||= links.first.attribute("href")

    driver.get(href)
    inject_all(driver)

    # Scroll down to show the analysis content
    driver.execute_script("window.scrollTo(0, 200);")
    sleep 0.3
    take_screenshot(driver, "ticket_analysis")
  else
    puts "  ! No tickets found, skipping ticket screenshot"
  end
end

def screenshot_briefing(driver)
  puts "Taking briefing screenshot..."
  driver.get("#{BASE_URL}/briefing")
  inject_all(driver)
  take_screenshot(driver, "briefing")
end

def screenshot_diff(driver)
  puts "Taking diff view screenshot..."

  # Try known tickets with autofix
  diff_urls = [
    "#{BASE_URL}/tickets/freshdesk/58888/diff",
    "#{BASE_URL}/tickets/freshdesk/58784/diff",
    "#{BASE_URL}/tickets/freshdesk/59576/diff"
  ]

  diff_urls.each do |url|
    puts "  Trying #{url}..."
    driver.get(url)
    sleep 1

    page_text = driver.find_element(:tag_name, "body").text
    next if page_text.include?("Ticket not found") || page_text.include?("not found") || page_text.strip.empty?

    # Found a valid diff page
    inject_all(driver)
    # Scroll to show the diff content
    driver.execute_script("window.scrollTo(0, 300);")
    sleep 0.3
    take_screenshot(driver, "diff_view")
    puts "  -> Diff screenshot taken"
    return
  end

  puts "  ! No diff view found, skipping"
end

# Main execution
puts "Deflekt Landing Page Screenshot Generator"
puts "=" * 45
puts "Domain swap: Accounting -> E-commerce"
puts "Output: #{OUTPUT_DIR}"
puts

FileUtils.mkdir_p(OUTPUT_DIR)

driver = setup_driver

begin
  screenshot_dashboard(driver)
  screenshot_ticket(driver)
  screenshot_briefing(driver)
  screenshot_diff(driver)

  puts
  puts "Done! #{Dir.glob(File.join(OUTPUT_DIR, '*.png')).size} screenshots in #{OUTPUT_DIR}"
ensure
  driver.quit
end
