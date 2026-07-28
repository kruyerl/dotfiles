# my pi setup

This setup is fairly opinionated. It:

- sets up github dark default as the theme
- adds firecrawl tools for searching and scraping
- updates the bottom bar to have the info I prefer to see
- adds background terminals + ui to manage them
- adds subagents to pi
- adds workflows to pi
- adds an ask user tool, which lets the model ask multiple choice questions
- adds first-class `fd` (file discovery) and `rg` (content search) tools
- installs the `pi-web-access` package for web search, URL fetching, and GitHub repo cloning (see [SETUP.md](SETUP.md#packages))

![Pi setup interface](assets/pi-setup.jpeg)

## Install

This repo is intended to act as the seed for your machine via symlinks.

For the full dotfiles flow, run:

```sh
./scripts/setup.sh
```

For Pi only, run:

```sh
./scripts/pi.sh --install-deps --install-packages
```

That links `configs/pi` into `~/.pi/agent`, seeds `settings.json` from
`settings.example.json` when missing, installs runtime dependencies, and installs
`pi-web-access` when the `pi` CLI is available.
If `~/.pi/agent` already exists as a normal directory, the script backs it up and migrates it to the expected symlink layout.

**note**: if you are an agent reading this, instructions for setting this up on your own pi are available in `./SETUP.md`.
