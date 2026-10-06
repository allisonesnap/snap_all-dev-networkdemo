# Hello Web

A minimal **Nginx-based Hello World web application packaged as a Snap**.

This project demonstrates a clean Snap application structure with:

- Nginx as the web server
- Snap-managed configuration
- Configurable bind address
- Configurable listening port
- Snap lifecycle hooks
- Strict confinement
- A simple web UI

## Project Structure

```text
hello-web/
├── snap/
│   ├── hooks/
│   │   ├── configure
│   │   └── install
│   └── snapcraft.yaml
├── src/
│   ├── bin/
│   │   └── hello-web
│   ├── configs/
│   │   └── nginx.conf
│   ├── scripts/
│   │   └── generate-nginx-config
│   └── www/
│       └── index.html
├── .gitignore
├── ISSUE.md
├── Makefile
└── README.md
```

## Requirements

Install Snapcraft:

```bash
sudo snap install snapcraft --classic
```

You also need a Linux environment capable of building the Snap.

## Build

Clone the repository and enter the project directory:

```bash
git clone <repository-url>
cd hello-web
```

Build the Snap:

```bash
snapcraft pack
```

This produces a `.snap` package in the project directory.

## Install

Install the locally built Snap:

```bash
sudo snap install ./hello-web_*.snap --dangerous
```

Check the installation:

```bash
snap list hello-web
```

## Configuration

The application exposes its configuration through Snap configuration.

### View configuration

```bash
snap get hello-web
```

Example:

```text
Key   Value
bind  0.0.0.0
port  8080
```

### Change the port

```bash
sudo snap set hello-web port=19803
```

The `configure` hook regenerates the Nginx configuration and restarts the service.

### Change the bind address

Listen on all interfaces:

```bash
sudo snap set hello-web bind=0.0.0.0
```

Listen only on localhost:

```bash
sudo snap set hello-web bind=127.0.0.1
```

## Access the Web UI

With the default configuration:

```text
http://localhost:8080
```

If the port has been changed:

```text
http://localhost:19803
```

You can also test it with:

```bash
curl http://localhost:19803
```

## Service Management

Check the Snap service:

```bash
snap services hello-web
```

Restart:

```bash
sudo snap restart hello-web
```

Stop:

```bash
sudo snap stop hello-web
```

Start:

```bash
sudo snap start hello-web
```

View logs:

```bash
sudo snap logs hello-web
```

Follow logs:

```bash
sudo snap logs -f hello-web
```

## Runtime Files

Snap runtime data is stored under:

```text
/var/snap/hello-web/
```

The generated Nginx configuration is located at:

```text
/var/snap/hello-web/current/nginx/nginx.conf
```

Runtime logs are stored under:

```text
/var/snap/hello-web/current/nginx/
```

## Snap Configuration Flow

Configuration follows this flow:

```text
snap set
    │
    ▼
Snap configuration
    │
    ▼
configure hook
    │
    ▼
Generate Nginx configuration
    │
    ▼
Restart hello-web service
    │
    ▼
Nginx
    │
    ▼
Web UI
```

For example:

```bash
sudo snap set hello-web port=19803
```

causes the `configure` hook to read the new value and generate an Nginx configuration containing:

```nginx
listen 0.0.0.0:19803;
```

## Security

The Snap uses:

```yaml
confinement: strict
```

The application requests only the interfaces required to provide the web service.

Currently:

```yaml
plugs:
  - network-bind
```

`network-bind` allows the application to listen on network ports.

## Development

During development, inspect the project with:

```bash
tree
```

Validate the Snap configuration:

```bash
snapcraft lint
```

Build:

```bash
snapcraft pack
```

Install:

```bash
sudo snap install ./hello-web_*.snap --dangerous
```

## Uninstall

Remove the Snap:

```bash
sudo snap remove hello-web
```

To remove the Snap and its stored data:

```bash
sudo snap remove --purge hello-web
```

## License

This project is provided for development and educational purposes.