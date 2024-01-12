## Markdown Lint Template Repository

My personal Markdown linting and formatting setup for a Git repository

You will almost certainly want to change some things here (i.e. use [nvm](https://github.com/nvm-sh/nvm)
instead of [asdf](https://asdf-vm.com/), or use a different flavor of Markdown). This is just how
_I_ do it; hopefully it's easy to tweak the building blocks to your preferences.

### Features

* Uses [GitHub Flavored Markdown](https://github.github.com/gfm/)
* A simple [pre-commit script](bin/pre-commit) that lints / formats all staged Markdown files
* [Makefile](Makefile) that initializes All The Things and gives you some useful targets for CI / CD
  and editing files.
* Node (both the runtime and all dependencies) installed in a non-system-cluttering way

### Non-Features

**No spell checking or grammar checking**

There are a lot of reasons to write Markdown in a repository (blogging, writing a book, code
documentation, personal knowledgebase, etc.). Depending on your use case, you may want extra
checking features, and you may not. This repository has One Single Purpose: Make sure your Markdown
is formatted consistently and correctly, without any "rendering" surprises. Other use cases can be
added on top on a per-repository basis.

### Non-Standard Tools Used

Here are the tools I use (besides core GNU CLI tools) that need to be installed for all this to
work:

* [direnv](https://direnv.net/)
* [asdf](https://asdf-vm.com/) for managing additional tools and their versions
  * [nodejs plugin](https://github.com/asdf-vm/asdf-nodejs) to install Node
  * [direnv plugin](https://github.com/asdf-community/asdf-direnv) to automatically load `asdf`
    tools (node) into your environment, which improves performance

### Usage

Clone the repository and `cd` into it. Then:

```bash
asdf install
cp .envrc.template .envrc
direnv allow
make init
```

This will:

* install the correct version of Node (if necessary)
* set up direnv to get `node`, `npm`, etc. on your `PATH`
* install [remark](https://github.com/remarkjs/remark) with some plugins
* set up your pre-commit hook

Then there are some Makefile targets that get executed more frequently:

* `make format` is most appropriate for cleaning up your mess while writing.
* `make lint` is most appropriate for CI / CD.

There are two important differences between `format` and `lint`:

* `format` will not only do proper linting; it will also make small tweaks to _already correct_
  Markdown. For example, any `[` characters that are just a part of prose will be changed to `\[`
  just to be safe and explicit, ensuring it's rendered as prose and not special Markdown syntax.
* `format` just touches staged and modified `.md` files. `lint` looks at all Markdown files in the
  repository.

### To-Do

* [ ] set up CI and dependabot for this repo
