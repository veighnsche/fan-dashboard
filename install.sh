#!/usr/bin/env sh
set -eu

mkdir -p "$HOME/bin" "$HOME/.config/systemd/user"
cp ./bin/fan-dashboard "$HOME/bin/fan-dashboard"
cp ./systemd/user/fan-dashboard.service "$HOME/.config/systemd/user/fan-dashboard.service"
chmod +x "$HOME/bin/fan-dashboard"

systemctl --user daemon-reload
systemctl --user enable --now fan-dashboard.service

printf '%s\n' 'Fan dashboard installed at http://127.0.0.1:8765'
