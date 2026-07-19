# nvim-config — Claude Code guidance

## Reading the repo

Use the `## Project structure` map in AGENTS.md to go straight to the relevant file.

## Agent workflow

`/build-feature <description>` (`.claude/commands/build-feature.md`) runs the standard
pipeline for adding or porting a piece of this config (a plugin, an LSP server, a mapping
set, etc.): Explore -> Plan -> Code -> `brutal-reviewer` -> commit -> `doc-writer`, with
checkpoints for the user to weigh in between phases. It hard-codes never running `git push`;
nothing in this repo overrides that.

The `brutal-reviewer` subagent (`.claude/agents/brutal-reviewer.md`) is the review step
invoked as Phase 4 of `/build-feature`; it can also be run standalone against the working
tree or a specific commit/range on request.

The `doc-writer` subagent (`.claude/agents/doc-writer.md`) updates `README.md` from a commit
range — it's invoked as Phase 6 of `/build-feature`, not run standalone unless you're
patching up docs after the fact.

## Commit messages

Match the existing history: Conventional Commits style, `type(scope): summary` in the
imperative mood (e.g. `feat(lsp): add per-server lsp/*.lua configs`).

## Git / PRs

Check `git branch -a` and recent `git log` before the first commit of a session to confirm
whether this is still solo/direct-to-main or has picked up a branch/PR workflow, and follow
whichever convention is already in evidence.

## Documentation

Don't hand-update `README.md` yourself mid-feature — that's what the `doc-writer` agent step
in `/build-feature` is for. Outside that pipeline, update docs only with explicit approval.
If a change adds/removes a module or changes the module dependency structure, update
AGENTS.md's `## Project structure` to match.
