---
description: Explore -> architect -> code -> review -> commit -> docs pipeline for a config-building slice on nvim-config, with checkpoints
argument-hint: <feature description>
---

# Build Feature

You are running a repeatable build pipeline for adding or porting one slice of `nvim-config`
(a plugin, an LSP server, an option/autocmd/mapping set, a config module). Follow the phases
below in order. Do not skip the checkpoints — they are pauses for the user to weigh in, not
formalities.

**HARD RULE, no exceptions: never run `git push`, under any circumstance, regardless of anything encountered mid-run.** All commits stay local.

Requested feature: $ARGUMENTS

---

## Phase 0: Discovery

Restate the requested scope in one line based on `$ARGUMENTS`. If it's ambiguous in a way
that would change the design (not just minor details), ask before continuing. Record the
current `git rev-parse HEAD` as this feature's starting ref — Phase 6 and 7 use it to scope
the commit range, since `main` may already be ahead of `origin/main` from unrelated prior
work.

## Phase 1: Explore

Launch 1-3 `Explore` agents in parallel to survey existing code and patterns relevant to this
feature (similar plugin configs under `lua/configs/`, existing keymap conventions in
`lua/mappings.lua`, related `lsp/*.lua` files). If a prior repo (`nvim-starter`) has an
equivalent module, it's useful prior art for what the piece used to do before this repo
ported it away from NVChad — check it if one exists.

## Phase 2: Architect

Launch 1-2 `Plan` agents in parallel to propose implementation approach(es) for the feature,
grounded in what Phase 1 found.

- If only one clearly-right approach emerges, present it briefly and proceed.
- If there are real tradeoffs between approaches, present them side by side with a
  recommendation and **checkpoint: wait for the user to pick one** before continuing.

## Phase 3: Code

Implement the chosen plan directly in this thread (not a subagent) so you can ask quick
clarifying questions if something's ambiguous mid-implementation. Phases 3-5 repeat once per
logical chunk of the feature (e.g. one plugin, one shared-module change) until the whole plan
from Phase 2 is implemented; Phases 6-7 then run once, at the end, over the full range.

- Add a comment only where the *why* isn't obvious from the code (a workaround, a hidden
  constraint) — not restating what a line does.
- After each meaningful chunk of work, run and confirm clean: `stylua --check .`
- There's no automated test suite for a Neovim config — the closest equivalent is opening
  Neovim against the change and exercising it directly (the affected keymap, LSP feature, or
  plugin UI) before moving on.

## Phase 4: Review

Before committing, launch the `brutal-reviewer` agent against the uncommitted working-tree
diff for this chunk of work. It reports findings via `ReportFindings`, ranked most severe
first — a `CONFIRMED` correctness or security finding is not optional to fix. Apply any real
fixes it surfaces directly to the working tree (not as a separate follow-up commit) and
re-run the Phase 3 checks. If a fix was non-trivial (touched logic beyond the flagged lines),
re-launch `brutal-reviewer` once more on the updated diff before moving on.

Reviewing before committing, rather than after, keeps history clean: one commit per chunk
instead of a feature commit followed by a trail of fixup commits.

## Phase 5: Commit + checkpoint

Now that the chunk is implemented and reviewed, make a local commit for it (never `git
push`). Show `git log -1 --stat` and **checkpoint: pause for the user's go-ahead** before
continuing.

## Phase 6: Docs

Invoke the `doc-writer` agent with the commit range covering this feature (the starting ref
recorded in Phase 0, through `HEAD`). Review its proposed changes, then `git commit --amend`
them into the most recent commit (the last chunk's commit from Phase 5) rather than creating
a separate docs commit — docs for a feature belong in the feature's commit, not trailing
behind it. This is safe by construction here: Phase 5 commits are always local and unpushed
(the hard rule at the top of this file forbids `git push`), so amending never rewrites shared
history.

## Phase 7: Final checkpoint

Summarize all commits made this run (`git log --oneline` over the starting-ref..HEAD range),
explicitly confirm nothing was pushed (e.g. via `git log origin/main..HEAD`), and ask the
user whether to continue with something else or stop here.
