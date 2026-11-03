# CLAUDE.md

Global preferences.
These apply to every project unless a repo's own `CLAUDE.md` overrides them.

## Writing

These rules cover every piece of prose I read: docstrings, comments, error messages, config comments, documentation, commit messages, issues and chat.

### Plain language

ISO 24495-1 sets the standard.
It requires four things of every piece of prose: the reader gets what they need, finds it fast, understands it on one pass, and can act on it.

In practice, that means:

- Write one idea per sentence.
  A sentence that needs two commas to join its clauses should be two sentences.
- Use active voice and the present tense.
  Name the thing that acts, and name it first.
- Use common words.
  Write `because`, not `on the grounds that`.
  Write `so`, not `which is what makes`.
- Avoid cleft constructions.
  Write `Sharing it stops two checks disagreeing`, not `sharing it is what stops two checks from disagreeing`.
- Put the point first.
  The first sentence gives the answer.
  The rest gives the reason.
- Keep the domain word.
  Simplify the grammar, not the vocabulary: `idempotent`, `serialize` and `schema` stay.

### Say what happens, without figures of speech

Do not use metaphors, analogies or personification.
Code does not refuse, decide, know, learn, ask, answer or promise: it raises, sets, reads, receives, returns and guarantees.
Data does not land, arrive, ride or survive: the code writes, passes, copies and keeps it.

Give every sentence a verb, including a heading's description or a caption.
"The loader, and the check that rejects bad rows" becomes "`load` reads the file, and `validate` raises on a row that does not match the schema".

Use the word an upstream library or API already uses, in the meaning it has there.
Do not swap in a synonym, even a plainer one.
If the upstream term is `job`, write `job`, not `task`.
Coin a term only for something the code names, such as a function, a class or a setting.
Where the repo keeps a glossary, define the term there and list the words it replaces beside it.

### Never use em dashes

Do not write `—`, or a `--` that stands in for one.
This applies everywhere: code, comments, docstrings, commit messages, issues, PR descriptions, and prose written for me to read.

Use a colon, a semicolon, a comma, or a second sentence.
An em dash almost always brackets an aside that reads better as its own sentence.

### Voice

Write in Hadley Wickham's voice: short declarative sentences, plain words, active voice, concrete over abstract.

Weight the content differently than he does, though.
His readers are end users who will never open the source, so his docs cover "how do I use this".
My reader is a future engineer, usually me, so prefer implementation rationale: why this library or base class was chosen over the alternative, why a name deviates from convention, why a check runs at this layer.
Keep "how to use this" for genuinely public surface.

State what a reader cannot infer from the code, in as few plain sentences as it needs.
A reader can reconstruct usage.
They cannot reconstruct rationale.

### Never write down the obvious

My reader is an engineer.
Anything they can determine by looking at the thing in front of them does not need saying.
Saying it makes the sentence that does need saying harder to find.

This matters most in prose addressed to me: PR bodies, issue comments, release notes, chat.
Before writing a justification, ask whether it is reconstructable from `git log`, the repo's own docs, or a config or workflow file I wrote.
If it is, delete it.
A release PR body is one line naming what the bump changes, not an argument for why the version is what I already told you it is.

Write what was measured, what surprised you, and what I could not have known.
Write nothing else.

### Keep prose short

Across a source tree, docstrings and comments stay under 40% of the characters.
Measure it when a rewrite is the point.
These limits keep it there:

- A private function's docstring is its summary line.
  Add a sentence only for a reason that the name, the annotation and the body do not show.
- A module docstring is at most three sentences: what the module holds, how it relates to the modules beside it, and the one constraint a maintainer must know.
- A comment is one line, and only for a reason the code does not show.
  It records no history and does not restate the code.
- A test's docstring is one sentence naming the behaviour under test.
- A measurement or a declined design goes in the repo's own record, and the docstring links to it in one sentence.

In a guide page, a sentence introduces every list, and a page has at most three callouts.

## Python

### Load `python-style` before touching Python

Load the `ozanozbeker-skills:python-style` skill before writing, reviewing or designing Python, choosing a dependency, or setting up a repo's tooling.
This holds inside another skill too: `/implement`, `/tdd`, `/code-review`, `/diagnosing-bugs` and the rest load it before their first Python edit or review.
Its rules are the standard the review axes and the hooks enforce.

### New packages follow Epistole's release standard

`~/Dev/epistole` is the reference repo for my packages, and its `CONTRIBUTING.md` holds the standard.
A new package copies the files that its "Adopting the standard" section lists, replaces `epistole` in each, and applies its "Repository settings" with my release App as the GitHub App and me as the `pypi` reviewer.
The package's `CLAUDE.md` imports `@~/Dev/epistole/CONTRIBUTING.md`, and its own `CONTRIBUTING.md` records the Epistole commit it copied and lists where it departs.
A change to a standard file merges in Epistole first, then in each package that follows it.

### Prefer typed code

Type as much as possible, so the editor and the type checker catch a mistake before the code runs.
For a set of allowed strings, use a `Literal` annotation, not an enum or sentinel constants: the pyrefly and pyright language servers complete `Literal` values inside the quotes, and a `StrEnum` fails a `Literal` field in both checkers (measured 2026-09-28).
When choosing a library, weigh annotation-driven typing above install size, and put a heavy library behind an extra rather than dropping it.
Wait for a tool's release rather than pinning it to its git `main`.

### Dev tools have no bound and stay at the latest release

Each tool in the `dev` dependency group is a bare name, with no floor and no cap.
`uv.lock` holds it at its latest release, with no cooldown.
Dev tools never reach users, and the lock already pins the version that runs, so a bound gains nothing.
Runtime floors keep their own rule: the oldest version the `lowest` job passes.
A test library that pins a runtime dependency keeps a floor, because its latest release would raise that dependency above the runtime floor.
Upgrade the tools in a `chore:` commit with `uv lock --upgrade-package <name>`.

### Docstrings follow numpydoc

[The numpydoc style guide](https://numpydoc.readthedocs.io/en/latest/format.html), enforced by ruff's `convention = "numpy"`.

Each section heading carries a dashed underline of the same length.
Sections appear in this order: `Parameters`, `Returns`, `Yields`, `Raises`, `See Also`, `Notes`, `Examples`.

**Omit the type.**
The annotation already carries it, and a hand-written copy drifts out of sync.
Write the parameter name alone, then an indented description.
A `Returns` block is a `:` line, then the indented description. griffe and Sphinx's napoleon read a bare description line as the return type, and the `:` line leaves the type to the annotation:

```python
def carrier(schema: type[dy.Schema]) -> ObjectMetadataValue:
    """Wrap a schema as the metadata value an asset's definition carries.

    Parameters
    ----------
    schema
        The schema being attached to the asset.

    Returns
    -------
    :
        The value to file under `SCHEMA_CARRIER_KEY`.
    """
```

A blank line follows the summary line.

**Every public object is documented in full, as pkgdown documents an exported R function.**
A reference page stands alone, so a reader never has to open the guide to call the function.

- Every parameter the object owns has a `Parameters` entry.
  The entry says what the name and the annotation cannot, and it names the default.
  A parameter forwarded unchanged to another library is covered by one sentence, "every other keyword parameter is `@dg.asset`'s, passed to it unchanged", and the `def` line takes `# numpydoc ignore=PR01` with a comment saying why.
- Every function that returns a value has a `Returns` block, and every exception it raises has a `Raises` entry.
- Every public object has one `Examples` block that runs.
  One call that shows the return value is enough.
  The guide owns the narrative.
- Constructor parameters go on the class docstring, not on `__init__`.
  Public attributes go in an `Attributes` section on the class docstring, not only in a pydantic `Field(description=...)`.
- A private object's docstring is its summary line.

numpydoc's validator enforces this as a prek hook on `src/`, with `[tool.numpydoc_validation]` in `pyproject.toml`.
ES01, SA01 and PR04 are off, because an extended summary and a See Also are optional and the annotation carries the type. ruff's `select = ["ALL"]` does not turn on D417 under `convention = "numpy"`, and PR01 covers the same case (measured 2026-10-20).

One rule neither tool can hold for you: **summary lines are imperative.**
D401 and SS05 read the first word only.
Write `Wrap`, not `Wraps`.
Class docstrings are exempt: they describe what the instance represents.

A method decorated with `@override` needs no docstring at all unless its behaviour materially differs from the base, and then only the difference.

Comments explain why.
Never restate what the code does.

### Docstring examples use markdown fences

Code in an `Examples` section goes in a fenced block tagged `python`.
Write no output comment: the docs build runs the block and prints the real value.

Not `>>>` prompts.
Not reST `.. code-block:: python`, which nothing renders unless the project has Sphinx.
Not plain indented code either: ruff cannot see it, so it drifts out of format silently.

Ruff's `docstring-code-format` reformats a plain fence and skips a braced `{python}` one (measured 2026-10-20).
Quarto runs only the braced one, so the package's build adds the braces to its copy of each docstring, and the source keeps the plain fence.

Keep the example runnable for any user who has the package installed.
Import example data the package ships, as dplyr's examples use `starwars`, or define what the snippet references.
Never import a demo or test module.

## Git

### Load `github-style` before anything after `git push`

Load the `ozanozbeker-skills:github-style` skill before opening or merging a pull request, editing CI, GitHub Actions, Dependabot or repository settings, releasing a version, publishing to PyPI, or deploying docs.
This holds inside another skill too: `/pr`, `/implement`, `/implement-spec` and the rest load it before their first pull request or workflow edit.

Never credit Claude, Anthropic, or any AI tool in code, comments, commit messages, or PR descriptions.

Run `git sync` once a pull request merges, and before starting a new branch.
The alias in my global git config switches to `main`, pulls, and deletes each local branch whose remote branch is gone, so the local repo matches the remote.
Use it in place of a repo's `git switch main && git pull`.

Leave an issue open until the pull request that resolves it merges.
Put `Closes #N` in the PR body, and let the merge close the issue.
A skill's resolve step, such as wayfinder's, can post its resolution comment when the PR opens, but it does not close the issue.
An issue closed before the merge reports work as done that is only on a branch.

## Config files

Changes to `pyproject.toml`, linter and type-checker configs, CI workflows, and similar need my confirmation first.
Recommend the change with evidence, then wait.
