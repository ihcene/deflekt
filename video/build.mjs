// Builds hero.mp4: narration from script.json, frames from reel.html rendered at fixed time steps, muxed with ffmpeg.
// Usage: NODE_PATH=<dir with playwright> node video/build.mjs   (VOICE=Daniel by default; drop vo/NN.wav files to use a real voice instead)
import { execFileSync } from "node:child_process";
import { readFileSync, writeFileSync, mkdirSync, existsSync, rmSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const out = join(here, "..");
const tmp = "/tmp/reel";
const fps = 30, gap = 0.55, lead = 0.8, tail = 3.2;
const voice = process.env.VOICE || "Daniel";
const lines = JSON.parse(readFileSync(join(here, "script.json"), "utf8"));
mkdirSync(join(tmp, "vo"), { recursive: true });

const duration = f => parseFloat(execFileSync("ffprobe", ["-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", f]).toString());
const clips = lines.map((text, i) => {
  const custom = join(here, "vo", `${String(i).padStart(2, "0")}.wav`);
  if (existsSync(custom)) return custom;
  const f = join(tmp, "vo", `${i}.aiff`);
  execFileSync("say", ["-v", voice, "-r", "168", "-o", f, text]);
  return f;
});

let t = lead;
const timeline = { lines: lines.map((text, i) => { const d = duration(clips[i]); const l = { text, start: t, end: t + d }; t += d + gap + (i === 3 || i === 6 ? 0.5 : 0); return l; }) };
timeline.end = timeline.lines.at(-1).end + tail;
writeFileSync(join(tmp, "timeline.json"), JSON.stringify(timeline, null, 2));

execFileSync("ffmpeg", ["-y", "-v", "error",
  ...clips.flatMap(c => ["-i", c]),
  "-filter_complex", clips.map((_, i) => `[${i}]aresample=48000,adelay=${Math.round(timeline.lines[i].start * 1000)}:all=1[a${i}]`).join(";") + ";" + clips.map((_, i) => `[a${i}]`).join("") + `amix=inputs=${clips.length}:normalize=0,apad=whole_dur=${timeline.end},loudnorm=I=-16:TP=-1.5[a]`,
  "-map", "[a]", "-t", String(timeline.end), join(tmp, "vo.wav")]);

const { chromium } = createRequire(import.meta.url)("playwright");
const frames = join(tmp, "frames");
rmSync(frames, { recursive: true, force: true }); mkdirSync(frames);
const browser = await chromium.launch({ channel: "chrome" });
const page = await browser.newPage({ viewport: { width: 1280, height: 720 }, deviceScaleFactor: 1.5 });
await page.addInitScript(tl => { window.TIMELINE = tl; window.CAPTURE = true; }, timeline);
await page.goto("file://" + join(here, "reel.html"));
await page.evaluate(() => document.fonts.ready);
await page.waitForTimeout(800);
const total = Math.ceil(timeline.end * fps);
for (let f = 0; f < total; f++) {
  await page.evaluate(s => window.render(s), f / fps);
  await page.screenshot({ path: join(frames, `${String(f).padStart(5, "0")}.jpg`), type: "jpeg", quality: 92 });
}
await page.evaluate(s => window.render(s), timeline.lines[2].start + 4);
await page.screenshot({ path: join(out, "hero-poster.jpg"), type: "jpeg", quality: 85 });
await browser.close();

execFileSync("ffmpeg", ["-y", "-v", "error", "-framerate", String(fps), "-i", join(frames, "%05d.jpg"), "-i", join(tmp, "vo.wav"),
  "-c:v", "libx264", "-preset", "slow", "-crf", "22", "-pix_fmt", "yuv420p", "-c:a", "aac", "-b:a", "128k", "-shortest", "-movflags", "+faststart", join(out, "hero.mp4")]);
console.log(`hero.mp4 · ${timeline.end.toFixed(1)}s · ${total} frames`);
