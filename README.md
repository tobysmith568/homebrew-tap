# homebrew-tap

Toby's personal [Homebrew](https://brew.sh) tap.

## Install

```sh
brew install tobysmith568/tap/<formula>
```

or

```sh
brew tap tobysmith568/tap
brew install <formula>
```

## Formulae

| Formula                           | Source                                                            |
| --------------------------------- | ----------------------------------------------------------------- |
| [`gramdown`](Formula/gramdown.rb) | [tobysmith568/gramdown](https://github.com/tobysmith568/gramdown) |

## How this stays up to date

Each formula is bumped automatically by its own project's release pipeline, via [`bump-formula.yml`](.github/workflows/bump-formula.yml) — a reusable workflow parameterized by formula name, version, and source repo. It regenerates the formula, validates it (`brew audit`/`style`/`install`/`test`, via the shared [`test-formula`](.github/actions/test-formula/action.yml) action), and only then opens a PR with auto-merge armed. [`integration.yml`](.github/workflows/integration.yml) re-runs that same check on the PR, and `main`'s branch protection requires it to pass before the merge actually lands.

A manual edit to a formula goes through the same `integration.yml` check like any other PR.
