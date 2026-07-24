# dotfiles

This repo is the seed for my Linux system.

## Intended workflow on a new machine

### Easiest path: download the bootstrap script

```sh
curl -fsSL https://raw.githubusercontent.com/kruyerl/Dotfiles/Main/scripts/bootstrap.sh -o /tmp/dotfiles-bootstrap.sh
bash /tmp/dotfiles-bootstrap.sh
```

That script:

1. updates/upgrades the system
2. installs git/curl/openssh-client
3. prompts for git identity
4. optionally creates an SSH key
5. creates `~/repos`
6. clones this repository into `~/repos/dotfiles`
7. optionally runs the full repo setup

### Manual path after cloning

From the repo root:

```sh
./scripts/install.sh
./scripts/setup.sh
```

Or run both in one go:

```sh
./scripts/systemInit.sh
```

Legacy wrappers still exist:

- `./scripts/seedInstall.sh` -> `./scripts/install.sh`
- `./scripts/seedSetup.sh` -> `./scripts/setup.sh`

## What the scripts do

- `scripts/bootstrap.sh`
  - machine kickoff script that can be downloaded before the repo is cloned
  - prepares git/SSH, creates `~/repos`, clones the repo, and can start setup
- `scripts/install.sh`
  - installs package managers, runtimes, and tools
  - installs `fnm`, then installs Node.js + npm through `fnm`
  - installs Pi globally via the npm helper
- `scripts/setup.sh`
  - symlinks repo-managed configs into your home directory
  - optionally sets up the Pi config from `configs/pi`
- `scripts/systemInit.sh`
  - convenience wrapper for running install + setup from inside the repo
- `scripts/seedInstall.sh` / `scripts/seedSetup.sh`
  - compatibility wrappers for the older names

## Agent context

- Repo-wide agent guidance lives in `./AGENTS.md`
- More specific agent instructions may exist in nested `AGENTS.md` files for subdirectories such as `configs/pi/`

## Notes

- This repo is symlink-first; configs stay in the repo and are linked into `~` / `~/.config`
- `scripts/install/link-configs.sh --dry-run` will show what would be linked
- Node is managed through `fnm`; the install flow installs `fnm` and then installs a Node runtime before npm-based steps run
- Pi local state like auth/session files should stay untracked
