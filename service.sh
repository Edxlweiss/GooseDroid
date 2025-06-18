#!/system/bin/sh
#
# GooseDroid - Chaos Engine
# Copyright (c) 2025 edxlweiss
#
# This software is intended for **educational and entertainment purposes only**.
# You are permitted to use, copy, modify, and distribute this software
# **for personal and non-commercial use**.
# Commercial use, resale, or monetization of this software or its derivatives
# is **strictly prohibited**.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

DEBUG=0

MODDIR=${0%/*}
MSGFILE="$MODDIR/messages.txt"
LOGFILE="$MODDIR/goose.log"

# Logger (respects DEBUG flag)
log() {
  [ "$DEBUG" -eq 1 ] && echo "[`date`] $1" >> "$LOGFILE"
}

# Wait for boot
until [ "$(getprop sys.boot_completed)" = "1" ]; do
  sleep 1
done

# Init messages.txt if missing
[ ! -f "$MSGFILE" ] && cat > "$MSGFILE" <<EOF
I bit your launcher. No regrets.
You dropped 3 FPS because I sneezed.
The goose is loose.
EOF

# 🔊 Volume via keyevent
adjust_volume_with_keyevent() {
  VOL_STEPS=$((RANDOM % 6 + 1))
  KEY=$((RANDOM % 2))
  if [ "$KEY" -eq 0 ]; then
    log "Decreasing volume $VOL_STEPS step(s)"
    for i in $(seq 1 "$VOL_STEPS"); do
      input keyevent 25
      sleep 0.1
    done
  else
    log "Increasing volume $VOL_STEPS step(s)"
    for i in $(seq 1 "$VOL_STEPS"); do
      input keyevent 24
      sleep 0.1
    done
  fi
}

# 🔔 Message
send_random_message() {
  MSG=$(shuf -n 1 "$MSGFILE")
  log "Sending message: $MSG"
  su -lp 2000 -c "cmd notification post -S bigtext -t '🦆 GooseDroid' goosedroid '$MSG'" >/dev/null &
}

# 🔒 Lock screen
lock_screen() {
  log "Triggering screen lock"
  input keyevent 26
}

# 💡 Flashlight Flicker
flicker_flashlight() {
  log "Flickering flashlight"
  cmd flashlight on
  sleep 0.3
  cmd flashlight off
  if cmd flashlight --help 2>/dev/null | grep -q "front"; then
    log "Flickering front flashlight"
    cmd flashlight front-on
    sleep 0.3
    cmd flashlight front-off
  fi
}

# 🏠 Simulate Home Button
simulate_home() {
  log "Simulating HOME key"
  input keyevent 3
}

# ↩️ Simulate Back Button
simulate_back() {
  log "Simulating BACK key"
  input keyevent 4
}

# 🔁 Main loop  
while true; do  
  sleep $((60 + RANDOM % 61)) # 60–120s  

  ROLL=$((RANDOM % 13))  
  log "Chaos roll: $ROLL"  
  case "$ROLL" in  
    0|1|2|3|4|5)  
      send_random_message ;;         # ~46%  
    6|7|8)  
      adjust_volume_with_keyevent ;; # ~23%  
    9)  
      flicker_flashlight ;;          # ~7.7%  
    10)  
      simulate_home ;;               # ~7.7%  
    11)  
      simulate_back ;;               # ~7.7%  
    12)  
      lock_screen ;;                 # ~7.7%  
  esac  

  sleep $((1 + RANDOM % 3)) # chaos cooldown  
done