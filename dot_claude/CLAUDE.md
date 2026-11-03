# CLAUDE.md

## Writing

Load `ozanozbeker-skills:writing-style` before writing or reviewing a docstring, a comment, a README or docs page, an error message, a commit message, a pull request body or an issue.
A `CLAUDE.md`, an `AGENTS.md` or a skill follows `mattpocock-skills:writing-for-agents`.
The core holds in chat too:

- Plain language, ISO 24495-1: one idea per sentence, active voice, present tense, common words, the point first, the domain word kept.
- No metaphor or personification: code raises, reads and returns, it does not refuse, know or promise.
- No em dash, anywhere: a colon, a comma or a second sentence takes its place.
- Rationale, not usage: write what I cannot infer from the thing in front of me, what was measured and what surprised you.

## Python

Load `ozanozbeker-skills:python-style` before writing, reviewing or designing Python, choosing a dependency, or setting up a repo's tooling.
This holds inside another skill too: it loads before that skill's first Python edit or review.
A new repo goes through `/setup-repo`.

## Git

Load `ozanozbeker-skills:github-style` before anything after `git push`: a pull request, CI, Dependabot, repository settings, a release, PyPI, the docs site.
This holds inside another skill too: it loads before that skill's first pull request or workflow edit.

A commit, a comment and a pull request carry my name only, with no credit to Claude, Anthropic or any AI tool.

## Config files

Changes to `pyproject.toml`, linter and type-checker configs, CI workflows, and similar need my confirmation first.
Recommend the change with evidence, then wait.
