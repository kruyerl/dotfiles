# Repository Fix Plan

Last updated: 2026-07-24

## Goal

Track the review follow-up work so it can be resumed later without re-discovering context.

## Status

- [x] Create a written fix plan
- [x] Start the highest-priority fixes
- [x] Finish the main scripted setup fixes
- [x] Add a downloadable machine-bootstrap script for first-run setup
- [x] Make the Node/npm bootstrap path work cleanly with fnm
- [x] Rename the main repo entrypoints to clearer `install.sh` / `setup.sh` names
- [x] Re-run verification after dependencies/tooling are in a good state
- [ ] Manually rotate exposed credentials outside the repo

## Priority 0 — Secrets and local state

### Problem

`configs/pi/auth.json` contains live local auth state, and the repo was not ignoring several Pi-generated files:

- `configs/pi/auth.json`
- `configs/pi/models-store.json`
- `configs/pi/settings.json`
- `configs/pi/sessions/`
- local env files under `configs/pi/`

This is both a security problem and an easy accidental-commit trap.

### Fix

- [x] Add ignore rules for Pi local state and secrets
- [x] Remove the currently tracked `configs/pi/auth.json` from the git index
- [ ] Decide whether deeper history cleanup is needed for previously committed secret material
- [ ] Rotate exposed credentials manually
- [ ] Confirm future Pi state stays untracked

### Notes

Credential rotation cannot be completed purely in-repo; it needs the account owner.

## Priority 1 — Pi setup path consistency

### Problem

Pi setup currently points in multiple directions:

- old Pi setup behavior copied repo-local files instead of following the symlink-first model
- `scripts/pi.sh` uses `configs/pi`
- `configs/pi/SETUP.md` described cloning the repo into `~/.pi/agent`, which did not match the actual layout

The repo is also intended to act as the seed for a Linux system via symlinks, so copy-based Pi setup was the wrong default.

### Fix

- [x] Retire the old alternate Pi setup path and keep `scripts/pi.sh` as the canonical flow
- [x] Update Pi setup docs to describe the real symlink-based install flow
- [x] Add the missing `configs/pi/.env.example`
- [x] Align the Pi setup with the repo's symlink-first model

## Priority 2 — Script reliability

### Problem

Several setup scripts are brittle or incorrect:

- `scripts/install/neovim.sh` copied only the `nvim` binary from the archive, not the runtime tree
- the repo still contained older one-off setup scripts that no longer matched the current system setup

### Fix

- [x] Make Neovim archive installs copy the full runtime tree and expose a runnable `nvim`
- [x] Remove the obsolete Kitty setup script
- [x] Rework the top-level setup flow around explicit install/setup phases
- [x] Replace the old interactive `systemInit.sh` behavior with a wrapper around the current install/setup flow
- [x] Add `scripts/bootstrap.sh` as a downloadable kickoff script for new machines
- [x] Reduce overlap by making `pi.sh` focus on Pi itself while the top-level setup script orchestrates full machine setup
- [x] Make `fnm` install a Node runtime before npm-based steps run
- [x] Rename the main entrypoints to `scripts/install.sh` and `scripts/setup.sh`
- [ ] Decide whether any remaining one-off scripts should be retired entirely

## Priority 3 — Test stability

### Problem

`configs/pi/extensions/git-info/process.test.ts` assumed a not-found-style spawn error, but this environment returned `PermissionDenied`, so `npm test` failed despite the production behavior being acceptable.

### Fix

- [x] Relax the assertion so the test accepts equivalent platform-specific spawn failures
- [x] Re-run the full test suite
- [x] Re-run typecheck and format checks
- [x] Keep local-only Pi state out of format checks via `.prettierignore`
- [x] Keep the root TypeScript check focused on the files it owns by excluding nested `*.spec.ts`

## Follow-up ideas discovered during implementation

These were not all part of the original review, but they are now visible enough to track:

- `configs/pi/SETUP.md` referenced `.env.example`, but the file did not exist
- Some remaining one-off scripts may still be worth consolidating or retiring entirely
- If Node version pinning becomes important later, consider adding a repo-level `.node-version`

## Resume checklist

If work pauses here, resume in this order:

1. Decide whether any remaining one-off scripts should be consolidated further or removed
2. If secrets were ever pushed remotely, perform any needed history cleanup and rotate Pi/Copilot credentials
3. Re-run verification after any further script changes:
   - `bash -n scripts/bootstrap.sh scripts/install.sh scripts/setup.sh scripts/seedInstall.sh scripts/seedSetup.sh scripts/systemInit.sh scripts/install/neovim.sh scripts/pi.sh scripts/install/link-configs.sh`
   - `npm --prefix configs/pi test`
   - `npm --prefix configs/pi run check`
   - `npm --prefix configs/pi run format:check`
