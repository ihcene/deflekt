# Narration with Kokoro (local neural TTS): writes video/vo/NN.wav, which build.mjs picks up instead of macOS `say`.
# Usage: ~/.cache/deflekt-tts/bin/python video/tts.py [voice] [speed]   e.g. af_heart 1.0
import json
import sys
from pathlib import Path

import soundfile as sf
from kokoro_onnx import Kokoro

here = Path(__file__).parent
models = Path.home() / ".cache/deflekt-tts/models"
voice = sys.argv[1] if len(sys.argv) > 1 else "af_heart"
speed = float(sys.argv[2]) if len(sys.argv) > 2 else 1.0

# Spoken forms where the written caption would be read awkwardly.
spoken = {"8:42": "eight forty two"}

kokoro = Kokoro(str(models / "kokoro-v1.0.onnx"), str(models / "voices-v1.0.bin"))
out = here / "vo"
out.mkdir(exist_ok=True)
for i, line in enumerate(json.loads((here / "script.json").read_text())):
    for written, said in spoken.items():
        line = line.replace(written, said)
    samples, rate = kokoro.create(line, voice=voice, speed=speed, lang="en-us" if voice[0] == "a" else "en-gb")
    sf.write(out / f"{i:02d}.wav", samples, rate)
    print(f"{i:02d}.wav  {len(samples) / rate:.1f}s  {line}")
