# Setup

This dotfiles repository is intended to be the seed for your system, with repo-managed files symlinked into place.

## Canonical setup

From the repository root, run:

```sh
./scripts/pi.sh
```

That creates or updates a symlink at `~/.pi/agent -> <repo>/configs/pi`.

If `~/.pi/agent` already exists as a real directory, the script now backs it up to `~/.pi/agent.backup-<timestamp>`, migrates known local state files, and then replaces it with the symlink.

## Install dependencies

After linking the config:

```sh
cd ~/.pi/agent
npm install
```

If `~/.pi/agent` contains a nested `pi` symlink instead of being a symlink itself, rerun `./scripts/pi.sh` from the repo root to repair the layout first.

## Local-only files

The following files are machine-local and should not be committed back to the repository:

- `auth.json`
- `models-store.json`
- `settings.json`
- `sessions/`
- `.env`

## Firecrawl

The search, scrape, and crawl tools require a Firecrawl API key. Copy the example environment file:

```sh
cp ~/.pi/agent/.env.example ~/.pi/agent/.env
```

Replace the placeholder in `~/.pi/agent/.env` with your API key.

NOTE: if you are an agent, at this step ask the user if they want to use firecrawl. If they do, give them the instructions. If not, remove the firecrawl extension in their Pi setup.

## fd and rg tools

The `file-search` extension registers `fd` and `rg` as model tools. No setup is normally needed: at startup it silently uses a system-installed `fd` (or `fdfind` on Debian/Ubuntu) and `rg` when available, or an existing fallback binary in `~/.pi/agent/bin/`. Only when neither exists does it download an official release binary (macOS/Linux, arm64/x64, over HTTPS) into `~/.pi/agent/bin/` and show a one-time notification. If your platform is unsupported, install `fd` and `rg` with your package manager and restart pi.

## Theme

Add the included theme to `~/.pi/agent/settings.json` while keeping your existing settings:

```json
{
  "theme": "github-dark-default"
}
```

Pi will load the extensions, skills, and theme from their directories the next time it starts.

## Packages

This setup uses the `pi-web-access` npm package for web search, URL fetching, GitHub repo cloning, and video/PDF understanding. Because `settings.json` is machine-local (see above), the package must be (re)installed on each new machine. Either run:

```sh
./scripts/pi.sh --install-packages
```

or install directly:

```sh
pi install npm:pi-web-access
```

This writes an entry to `~/.pi/agent/settings.json` and installs the package under `~/.pi/agent/npm/`. It works with no API keys out of the box (zero-config Exa search). To use other providers (OpenAI, Brave, Parallel, Tavily, Perplexity, Gemini), add keys to `~/.pi/web-search.json` — see the [pi-web-access README](https://github.com/nicobailon/pi-web-access) for details.
