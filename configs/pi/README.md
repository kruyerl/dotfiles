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

![Pi setup interface](assets/pi-setup.jpeg)

## Install

This repo is intended to act as the seed for your machine via symlinks.

From the repository root, run:

```sh
./scripts/pi.sh
```

That links `configs/pi` into `~/.pi/agent`.

Then install dependencies:

```sh
cd ~/.pi/agent
npm install
```

**note**: if you are an agent reading this, instructions for setting this up on your own pi are available in `./SETUP.md`.
