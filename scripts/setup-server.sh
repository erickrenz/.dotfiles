#!/usr/bin/env bash
# One-time setup so this laptop keeps running as a server while plugged in
# with the lid closed, reachable over Tailscale. Safe to re-run.
set -euo pipefail

DOTFILES="$HOME/.dotfiles"

echo "==> Battery: charge to 80%, resume charging below 75%"
sudo ln -sf "$DOTFILES/etc/battery-charge-threshold.service" /etc/systemd/system/battery-charge-threshold.service

echo "==> Lid: ignore on AC, suspend on battery"
sudo mkdir -p /etc/systemd/logind.conf.d
sudo ln -sf "$DOTFILES/etc/logind-lid.conf" /etc/systemd/logind.conf.d/10-lid.conf
sudo ln -sf "$DOTFILES/etc/lid-closed-on-battery.service" /etc/systemd/system/lid-closed-on-battery.service
sudo ln -sf "$DOTFILES/etc/ac-unplug.rules" /etc/udev/rules.d/90-ac-unplug.rules

sudo systemctl daemon-reload
sudo systemctl enable battery-charge-threshold.service
sudo systemctl restart battery-charge-threshold.service
sudo udevadm control --reload
# SIGHUP reloads logind's config; restarting it can take the sway session down
sudo systemctl kill -s HUP systemd-logind

echo "==> Tailscale"
sudo pacman -S --needed --noconfirm tailscale
sudo systemctl enable --now tailscaled
if ! tailscale status >/dev/null 2>&1; then
	sudo tailscale up --operator="$USER"
fi

echo "==> Firewall: ssh only over the tailnet"
sudo ufw delete allow ssh || true
sudo ufw delete limit ssh || true
sudo ufw delete limit 22 || true
sudo ufw allow in on tailscale0 to any port 22 proto tcp
sudo ufw allow 41641/udp
sudo ufw reload

echo "==> SSH"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
touch "$HOME/.ssh/authorized_keys"
chmod 600 "$HOME/.ssh/authorized_keys"
sudo systemctl enable --now sshd

echo
echo "Battery thresholds: $(cat /sys/class/power_supply/BAT0/charge_control_start_threshold)-$(cat /sys/class/power_supply/BAT0/charge_control_end_threshold)%"
echo "Tailscale address:  $(tailscale ip -4 2>/dev/null || echo 'not connected')"
sudo ufw status
echo
echo "Next: add your phone's public key to ~/.ssh/authorized_keys, then"
echo "      ssh $USER@$(tailscale ip -4 2>/dev/null || echo '<tailscale-ip>')"
