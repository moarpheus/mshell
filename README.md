<p align="center">
  <h1 align="center">⚡ mshell</h1>
  <p align="center">
    <strong>A modern, AI-powered zsh environment for macOS and iTerm2</strong>
  </p>
  <p align="center">
    Fast startup · smart navigation · AI assistance · auto-updating
  </p>
</p>

---

## Features

| | Feature | Description |
|---|---------|-------------|
| 🤖 | AI integration | Chat, command suggestions, and commit messages via a local LLM |
| 🚀 | Starship prompt | Fast prompt showing directory, git branch, git status, and command duration |
| 📁 | Smart navigation | Zoxide learns your habits and jumps anywhere instantly |
| 🔍 | Fuzzy everything | fzf-powered file search, git branches, history, and diffs |
| 🎯 | Project detection | Configures PATH and shows make targets when you `cd` into a project |
| 🔄 | Auto-updater | Weekly update checks with one-key confirmation |
| 🧩 | Plugin management | Lightweight manifest-based zsh plugins, no framework needed |
| 🎨 | Modern CLI tools | eza, bat, dust, delta, and prettyping replace legacy tools |

---

## Installation

```bash
git clone https://github.com/moarpheus/mshell ~/.mshell && ~/.mshell/install
```

That's it. The install script handles everything:

- installs [Homebrew](https://brew.sh) if missing
- installs all CLI tools via `brew bundle`
- clones zsh plugins
- symlinks configs (starship, aichat, gitconfig, gitignore)
- appends the source line to `~/.zshrc` (idempotent, safe to re-run)

---

## Keyboard shortcuts

### Shell navigation

| Shortcut | Action |
|----------|--------|
| `Ctrl+B` | Backward word |
| `Ctrl+F` | Forward word |
| `↑` | History substring search up |
| `↓` | History substring search down |

History search is contextual: type part of a command, then use the arrows to find matching history entries.

### fzf (fuzzy finder)

fzf is active in file search, git operations, and anywhere you see the `∼` prompt. These shortcuts work inside an fzf session, for example after `Ctrl+T`, `Ctrl+R`, or any fzf-powered command:

| Shortcut | Action |
|----------|--------|
| `?` | Toggle preview panel |
| `Shift+Down` | Scroll preview down |
| `Shift+Up` | Scroll preview up |
| `PgDn` | Preview page down |
| `PgUp` | Preview page up |
| `Ctrl+A` | Select all results |
| `Ctrl+Y` | Copy selection to clipboard |
| `Ctrl+E` | Open selection in the editor |

These keys are fzf-internal bindings. They work only inside an fzf picker, not at the regular shell prompt.

---

## AI integration

All AI features use [aichat](https://github.com/sigoden/aichat) connected to a local LLM server (LM Studio or mlx-lm-server at `localhost:1234`).

| Command | Description | Example |
|---------|-------------|---------|
| `ai` | Chat with your local LLM | `ai "explain this error message"` |
| `how` | Get a shell command suggestion, with optional execution | `how "find files larger than 100MB"` |
| `gai` | Generate a commit message from staged changes | `git add -A && gai` |
| `hsearch` | Search shell history by description | `hsearch "docker compose restart"` |

### How gai works

```
$ git add -A
$ gai
Suggested commit message:
  feat: add user authentication middleware

Use this message? [y/n] y
[main abc1234] feat: add user authentication middleware
```

### How how works

```
$ how "list all listening ports"
> lsof -iTCP -sTCP:LISTEN -n -P
Execute? [y/n]
```

AI functions need a local LLM server running. Start LM Studio or mlx-lm-server before use.

---

## Smart features

### Project detection

When you `cd` into a project directory, mshell automatically:

| Marker file | Action |
|-------------|--------|
| `package.json` | Prepends `node_modules/.bin` to PATH |
| `Makefile` | Displays up to 20 available make targets, once per session |

PATH is cleaned up when you leave the directory, so there are no stale entries.

### Auto-updater

Every 7 days, mshell checks for upstream updates on shell startup:

1. Fetches from origin with a 2-second timeout, so it never blocks your shell.
2. Prompts `y/n` to update if new commits exist.
3. Updates via `git pull --rebase` on confirmation.
4. Skips silently on decline or network failure.

---

## Git aliases

### Shell aliases

| Alias | Expands to |
|-------|-----------|
| `g` | `git` |
| `lg` | `lazygit` (git TUI) |
| `ga` | `git add` |
| `gc` | `git commit` |
| `gc-m` | `git commit -m` |
| `gl` | `git log` (pretty graph) |
| `gai` | AI-generated commit message |
| `cdr` | `cd` to the git repository root |

### Git subcommands (`g <alias>`)

| Alias | Action |
|-------|--------|
| `g a` | add |
| `g c` | commit |
| `g co` | checkout |
| `g n <name>` | create a new branch |
| `g l` | pretty log graph |
| `g s` | status (short, with branch) |
| `g yolo` | commit with `--no-verify` |

### lazygit

[lazygit](https://github.com/jesseduffield/lazygit) is a full-screen terminal UI for git. Run `lg` inside any repository to stage, commit, branch, rebase, and stash without typing individual git commands.

| Key | Action |
|-----|--------|
| `?` | Show all keybindings for the current panel |
| `Tab` | Cycle between panels |
| `Space` | Stage or unstage the selected file, or pop a stash |
| `a` | Stage or unstage everything |
| `c` | Commit staged changes |
| `P` | Push |
| `p` | Pull |
| `q` | Quit |

For line-by-line staging, press `Enter` on a file in the Files panel, then `Space` on individual lines. Press `?` any time to see the full key list for the panel you are in.

---

## Tool replacements

| Legacy tool | Modern replacement | Why |
|------------|-------------------|-----|
| `ls` | [eza](https://github.com/eza-community/eza) | Colours, icons, git status, tree view |
| `cat` | [bat](https://github.com/sharkdp/bat) | Syntax highlighting, line numbers, git diff |
| `cd` | [zoxide](https://github.com/ajeetdsouza/zoxide) | Frecency-based smart jumping |
| `ncdu` | [dust](https://github.com/bootandy/dust) | Fast, visual disk usage |
| `df` | [duf](https://github.com/muesli/duf) | Clear per-mount disk free output |
| `ping` | [prettyping](https://github.com/denilsonsa/prettyping) | Graphical ping output |
| `diff` (git) | [delta](https://github.com/dandavison/delta) | Syntax-highlighted, side-by-side diffs |
| `top` | [btop](https://github.com/aristocratos/btop) | Resource monitor |
| Pure prompt | [Starship](https://starship.rs) | Fast, customizable, cross-shell prompt |

---

## Other aliases

### Docker

| Alias | Command |
|-------|---------|
| `d` | `docker` |
| `dc` | `docker-compose` |
| `dsh <container>` | Attach a shell to a container |
| `dbr` | Build and run the current Dockerfile |
| `dcrc <service>` | Rebuild and restart a compose service |
| `dcl <service>` | Tail compose logs |

### General

| Alias | Command |
|-------|---------|
| `v` | `nvim` (falls back to `vim`) |
| `cat` | `bat` |
| `df` | `duf` |
| `ping` | `prettyping` |
| `ls` | `eza --color=always --group-directories-first` |
| `cd` | `z` (zoxide) |
| `tf` | `terraform` |
| `mt` | `make test` |

### Config updates

| Alias | Action |
|-------|--------|
| `up-vim` | Pull the latest nvim config |
| `up-shell` | Pull the latest mshell config |
| `up-all` | Update both the vim and shell configs |
| `update_plugins` | Update all zsh plugins from the manifest |

---

## Configuration

### Starship prompt (`starship.toml`)

The prompt shows directory, then git branch, then git status, then command duration.

To customise it, edit `~/.mshell/starship.toml` (symlinked to `~/.config/starship.toml`). See the [Starship docs](https://starship.rs/config/) for all options.

### AI tool (`aichat_config.yaml`)

Configured to connect to a local OpenAI-compatible API:

```yaml
model: local:qwen2.5-coder-7b-instruct-mlx
clients:
  - type: openai-compatible
    name: local
    api_base: http://localhost:1234/v1
```

Models available: `qwen2.5-coder-7b-instruct-mlx`, `google/gemma-4-26b-a4b-qat`, `qwen/qwen3.6-27b`.

Edit `~/.mshell/aichat_config.yaml` to change models or the API endpoint.

### fzf

Default search uses ripgrep for speed, respects `.gitignore`, and shows bat-powered previews. Configuration lives in the `env` file.

---

## Plugin management

Plugins are listed in `plugins.txt`, one git URL per line:

```
https://github.com/zsh-users/zsh-completions.git
https://github.com/zsh-users/zsh-syntax-highlighting.git
https://github.com/zsh-users/zsh-history-substring-search.git
https://github.com/zsh-users/zsh-autosuggestions.git
```

The plugins give you richer completions, red/green syntax highlighting as you type, history search with the arrow keys, and greyed-out autosuggestions from history (accept with the right-arrow).

| Command | Action |
|---------|--------|
| `./install` | Clones any missing plugins |
| `update_plugins` | Pulls the latest for all plugins |

To add a plugin, append its git URL to `plugins.txt` and run `./install`.

---

## Releases

Versioning is automated with [semantic-release](https://semantic-release.gitbook.io/). On every push to `main`, a GitHub Actions workflow reads the commit messages, works out the next version, creates a git tag and GitHub Release, and commits an updated `CHANGELOG.md`.

Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/):

- `fix:` triggers a patch release
- `feat:` triggers a minor release
- `feat!:` or a `BREAKING CHANGE:` footer triggers a major release
- other types such as `chore:`, `docs:`, and `ci:` do not trigger a release

The workflow lives in `.github/workflows/release.yml` and its config in `.releaserc.json`. It authenticates with the `CI_TOKEN` repository secret.

---

## Customization tips

- add your own aliases: create `~/.mshell/local` and source it from `~/.zshrc` after mshell
- change the prompt: edit `starship.toml`, where modules are toggled with `disabled = true` or `false`
- switch the AI model: edit `aichat_config.yaml` and change the `model:` field
- add a plugin: append the git URL to `plugins.txt` and run `./install`
- iTerm2 colours: import any `.itermcolors` file from the `iterm2/` directory

---

## Repository structure

```
~/.mshell/
├── install              # Bootstrap script, run once or re-run safely
├── custom               # Entry point sourced by ~/.zshrc
├── env                  # Environment variables, PATH, fzf config
├── aliases              # Shell aliases
├── functions            # Shell functions (gai, how, hsearch, and more)
├── gitconfig            # Git aliases and configuration
├── starship.toml        # Prompt configuration
├── aichat_config.yaml   # AI tool configuration
├── plugins.txt          # Plugin manifest
├── Brewfile             # Homebrew dependencies
├── zsh/
│   ├── custom           # Zsh setup, keybindings, completions
│   ├── auto_updater.zsh # Weekly update checker
│   ├── project_detector.zsh # chpwd hook for project detection
│   └── plugins/         # Cloned zsh plugins
├── iterm2/              # iTerm2 colour schemes
└── working/             # Runtime state (history, zoxide data, update timestamps)
```

---

<p align="center">
  <sub>Built for macOS, zsh, and iTerm2</sub>
</p>
