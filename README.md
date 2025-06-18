# 🦆 GooseDroid - Chaos Engine

**GooseDroid** is a Magisk/KernelSU module that brings random, chaotic, goose-inspired behavior to your Android device for pure entertainment and mischief. Inspired by the spirit of the Desktop Goose, this daemon creates unpredictable disruptions—just because it can.

---

## 📦 Features

- 🧠 Sends random and humorous notifications from `messages.txt`
- 🔊 Randomly increases or decreases your volume
- 🔒 Occasionally locks the screen (screen off)
- 💡 Flickers front/back flashlight(s)
- 🏠 Randomly presses HOME or BACK
- 🔁 Fully autonomous and runs in the background
- 🌑 No frontend app—just pure script-based chaos

---

## 📁 Files

| Path                      | Description                             |
|---------------------------|-----------------------------------------|
| `service.sh`              | The main chaos loop script              |
| `messages.txt`            | List of messages for notifications      |
| `goose.log`               | Optional log file for debugging         |

---

## 🚀 Installation

1. Flash the `.zip` via **Magisk Manager** or **KernelSU Manager**
2. Reboot your device
3. Chaos will start automatically within 1–2 minutes after boot

---

## ⚙️ Enable Debug Logging

By default, **GooseDroid** disables logging in release builds for performance and stealth.

To enable debug logging:

```sh
touch /data/goosedroid/debug