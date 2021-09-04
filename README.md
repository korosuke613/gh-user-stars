# gh-user-stars
This is an extension for the [GitHub CLI](https://github.com/cli/cli) extension
that displays an interactive list of [your github stars](https://github.com/stars),
and allows you to filter it with fuzzy search,
powered by [fzf](https://github.com/junegunn/fzf#readme).
The URL of the selected repository is printed as the output of the command.

![Demo animation](./demo.gif)

## Installation
Besides [gh](https://github.com/cli/cli),
the following commands are required for this extension to work:
- [fzf](https://github.com/junegunn/fzf)
- [jq](https://github.com/stedolan/jq)

Please follow their installation instructions if you don't have them yet.

Then, install this extension by running:
```
gh extension install korosuke613/gh-user-stars
```

## Usage
```
❯ gh user-stars -h

Displays an interactive list of your starred repositories.
The URL of the selected repository is printed as the output of the command.

Dependencies: fzf, jq

Usage
  gh user-stars [NUMBER]

NUMBER: Number of stars to fetch at a time. (default: 50, max: 100)
```
