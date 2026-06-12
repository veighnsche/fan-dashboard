# System Dashboard

Tiny local web dashboard for checking system telemetry before a machine gets loud enough to bother people nearby.

It shows:

- CPU usage and load average
- RAM usage
- NVIDIA GPU fan percentage, temperature, power draw, and utilization via `nvidia-smi`
- NVIDIA VRAM usage via `nvidia-smi`
- Motherboard fan RPMs exposed by Linux under `/sys/class/hwmon`
- Storage usage for real mounted filesystems
- A JSON endpoint at `/json`

The server binds to `127.0.0.1` by default, so the recommended remote access pattern is an SSH tunnel:

```bash
ssh -L 8765:127.0.0.1:8765 user@your-host
```

Then open:

```text
http://127.0.0.1:8765
```

## Install

```bash
./install.sh
systemctl --user status fan-dashboard.service
```

The dashboard will be available at:

```text
http://127.0.0.1:8765
```

## Motherboard Fan Sensors

GPU telemetry works when `nvidia-smi` is installed and the NVIDIA driver exposes fan data.

Motherboard fans require the kernel to expose fan RPM files under `/sys/class/hwmon`. On Fedora, Rocky, RHEL, and related distributions, install and configure lm-sensors:

```bash
sudo dnf install lm_sensors
sudo sensors-detect
systemctl --user restart fan-dashboard.service
```

Some motherboards need a specific kernel module or BIOS setting before fan RPMs appear.

For example, an MSI X99A RAIDER exposes its Nuvoton `nct6792` monitoring chip through the `nct6775` kernel module:

```bash
sudo modprobe nct6775
printf 'nct6775\n' | sudo tee /etc/modules-load.d/fan-dashboard.conf
```

After loading the module, restart the dashboard or wait for the next browser refresh.

## Manual Run

```bash
./bin/fan-dashboard --host 127.0.0.1 --port 8765
```

## JSON

```bash
curl http://127.0.0.1:8765/json
```
