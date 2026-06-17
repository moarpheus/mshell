<p align="center">
  <h1 align="center">⚡ mshell</h1>
  <p align="center">
    <strong>A modern, AI-powered zsh environment for macOS + iTerm2</strong>
  </p>
  <p align="center">
    Fast startup · Smart navigation · AI assistance · Auto-updating
  </p>
</p>

---

## ✨ Features

| | Feature | Description |
|---|---------|-------------|
| 🤖 | **AI Integration** | Chat, command suggestions, and commit messages via local LLM |
| 🚀 | **Starship Prompt** | Fast, informative prompt with git status and k8s context |
| 📁 | **Smart Navigation** | Zoxide learns your habits, jumps anywhere instantly |
| 🔍 | **Fuzzy Everything** | fzf-powered file search, git branches, history, and diffs |
| 🎯 | **Project Detection** | Auto-configures PATH and shows make targets on `cd` |
| 🔄 | **Auto-Updater** | Weekly update checks with one-key confirmation |
| 🧩 | **Plugin Management** | Lightweight manifest-based zsh plugins, no framework needed |
| 🎨 | **Modern CLI Tools** | eza, bat, dust, delta, prettyping replace legacy tools |

---

## 📦 Installation

```bash
git clone https://github.com/moarpheus/mshell ~/.mshell && ~/.mshell/install
```

That's it. The install script handles everything:

- ✅ Installs [Homebrew](https://brew.sh) if missing
- ✅ Installs all CLI tools via `brew bundle`
- ✅ Clones zsh plugins
- ✅ Symlinks configs (starship, aichat, gitconfig, gitignore)
- ✅ Downloads iTerm2 shell integration
- ✅ Appends source to `~/.zshrc` (idempotent — safe to re-run)

---

## ⌨️ Keyboard Shortcuts

### Shell Navigation

| Shortcut | Action |
|----------|--------|
| `Ctrl+B` | Backward word |
| `Ctrl+F` | Forward word |
| `↑` | History substring search up |
| `↓` | History substring search down |

> 💡 History search is contextual — type part of a command, then use arrows to find matching history entries.

### fzf (Fuzzy Finder)

fzf is active in file search, git operations, and anywhere you see the `∼` prompt. These shortcuts work **inside an fzf session** (e.g., after `Ctrl+T`, `Ctrl+R`, or any fzf-powered command like `gd`, `g col`, etc.):

| Shortcut | Action |
|----------|--------|
| `?` | Toggle preview panel |
| `Shift+Down` | Scroll preview down |
| `Shift+Up` | Scroll preview up |
| `PgDn` | Preview page down |
| `PgUp` | Preview page up |
| `Ctrl+A` | Select all results |
| `Ctrl+Y` | Copy selection to clipboard |
| `Ctrl+E` | Open selection in vim |

> 💡 These keys are fzf-internal bindings. They won't work at the regular shell prompt — you need to be inside an fzf picker first.

### Vim Mode

The shell runs in **vi mode** (`bindkey -v`). You get normal/insert modes in the command line:

| Mode | Key | Action |
|------|-----|--------|
| Insert | `Esc` | Enter normal mode |
| Normal | `i` | Enter insert mode |
| Normal | `/` | Search history |
| Normal | `v` | Edit command in `$EDITOR` |

---

## 🤖 AI Integration

All AI features use [aichat](https://github.com/sigoden/aichat) connected to a local LLM server (LM Studio / mlx-lm-server at `localhost:1234`).

| Command | Description | Example |
|---------|-------------|---------|
| `ai` | Chat with your local LLM | `ai "explain this error message"` |
| `how` | Get a shell command suggestion (with optional execution) | `how "find files larger than 100MB"` |
| `gai` | Generate a commit message from staged changes | `git add -A && gai` |
| `hsearch` | Search shell history by description | `hsearch "docker compose restart"` |

### How `gai` works

```
$ git add -A
$ gai
Suggested commit message:
  feat: add user authentication middleware
  
Use this message? [y/n] y
[main abc1234] feat: add user authentication middleware
```

### How `how` works

```
$ how "list all listening ports"
> lsof -iTCP -sTCP:LISTEN -n -P
Execute? [y/n]
```

> ⚠️ AI functions require a local LLM server running. Start LM Studio or mlx-lm-server before use.

---

## 📁 Smart Features

### 🎯 Project Detection

When you `cd` into a project directory, mshell automatically:

| Marker File | Action |
|-------------|--------|
| `package.json` | Prepends `node_modules/.bin` to PATH |
| `Makefile` | Displays up to 20 available make targets (once per session) |
| `.env` | Defers to `direnv` if installed; warns if not |

PATH is cleaned up when you leave the directory — no stale entries.

### 🔄 Auto-Updater

Every 7 days, mshell checks for upstream updates on shell startup:

1. Fetches from origin (2-second timeout — never blocks your shell)
2. If new commits exist, prompts `y/n` to update
3. Updates via `git pull --rebase` on confirmation
4. Skips silently on decline or network failure

---

## 🔀 Git Aliases

### Shell Aliases

| Alias | Expands To |
|-------|-----------|
| `g` | `git` |
| `ga` | `git add` |
| `gaa` | `git add -A` |
| `gc` | `git commit` |
| `gd` | `git diff` (fzf-powered) |
| `gl` | `git log` (pretty graph) |
| `gst` | `git status -bs` |
| `gai` | AI-generated commit message |
| `cdr` | `cd` to git repository root |

### Git Subcommands (`g <alias>`)

| Alias | Action |
|-------|--------|
| `g co` | checkout |
| `g col` | checkout branch via fzf picker |
| `g com` | checkout main/master |
| `g n <name>` | create new branch |
| `g po` | push to origin (set upstream) |
| `g punch` | force push with lease |
| `g l` | pretty log graph |
| `g d` | diff with fzf file picker + delta preview |
| `g dc` | diff cached (staged) with fzf |
| `g sl` | stash list with fzf preview |
| `g standup` | show your commits since yesterday (Friday on Mondays) |
| `g prune-remote` | delete local branches whose remote is gone |
| `g cleanup` | delete merged branches |
| `g rb` | rebase |
| `g rbm` | interactive rebase on origin/master |
| `g ff` | merge fast-forward only |
| `g copr <n>` | fetch and checkout PR #n |
| `g tags` | list tags |
| `g unstage` | reset head |
| `g yolo` | commit with `--no-verify` |

---

## 🛠️ Tool Replacements

| Legacy Tool | Modern Replacement | Why |
|------------|-------------------|-----|
| `ls` | [eza](https://github.com/eza-community/eza) | Colors, icons, git status, tree view |
| `cat` | [bat](https://github.com/sharkdp/bat) | Syntax highlighting, line numbers, git diff |
| `cd` | [zoxide](https://github.com/ajeetdsouza/zoxide) | Frecency-based smart jumping |
| `ncdu` | [dust](https://github.com/bootandy/dust) | Fast, visual disk usage |
| `ping` | [prettyping](https://github.com/denilsonsa/prettyping) | Graphical ping output |
| `diff` (git) | [delta](https://github.com/dandavella/delta) | Syntax-highlighted, side-by-side diffs |
| `top` | [btop](https://github.com/aristocratos/btop) | Beautiful resource monitor |
| Pure prompt | [Starship](https://starship.rs) | Fast, customizable, cross-shell prompt |

---

## 🐚 Other Aliases

### Docker

| Alias | Command |
|-------|---------|
| `d` | `docker` |
| `dc` | `docker-compose` |
| `dsh <container>` | Attach shell to container |
| `dbr` | Build and run current Dockerfile |
| `dcrc <service>` | Rebuild and restart a compose service |
| `dcl <service>` | Tail compose logs |

### Kubernetes

| Alias | Command |
|-------|---------|
| `k` | `kubectl` |
| `mk` | `minikube` |

### General

| Alias | Command |
|-------|---------|
| `v` | `nvim` (falls back to `vim`) |
| `cat` | `bat` |
| `ping` | `prettyping` |
| `ls` | `eza --color=always --group-directories-first` |
| `cd` | `z` (zoxide) |
| `tf` | `terraform` |
| `mt` | `make test` |

### Config Updates

| Alias | Action |
|-------|--------|
| `up-vim` | Pull latest nvim config |
| `up-shell` | Pull latest mshell config |
| `up-all` | Update both vim and shell configs |
| `update_plugins` | Update all zsh plugins from manifest |

---

## ⚙️ Configuration

### Starship Prompt (`starship.toml`)

The prompt shows: **directory** → **git branch** → **git status** → **k8s context** → **command duration**

Customization: edit `~/.mshell/starship.toml` (symlinked to `~/.config/starship.toml`)

See [Starship docs](https://starship.rs/config/) for all options.

### AI Tool (`aichat_config.yaml`)

Configured to connect to a local OpenAI-compatible API:

```yaml
model: local:qwen2.5-coder
clients:
  - type: openai-compatible
    name: local
    api_base: http://localhost:1234/v1
```

Models available: `qwen2.5-coder`, `gemma-4-26b`, `qwen3.6-27b`

Edit `~/.mshell/aichat_config.yaml` to change models or API endpoint.

### fzf

Default search uses `ripgrep` for speed, respects `.gitignore`, and shows bat-powered previews. Configuration lives in the `env` file.

---

## 🧩 Plugin Management

Plugins are listed in `plugins.txt` (one git URL per line):

```
https://github.com/zsh-users/zsh-completions.git
https://github.com/zsh-users/zsh-syntax-highlighting.git
https://github.com/zsh-users/zsh-history-substring-search.git
```

| Command | Action |
|---------|--------|
| `./install` | Clones any missing plugins |
| `update_plugins` | Pulls latest for all plugins |

To add a plugin: append its git URL to `plugins.txt` and run `./install`.

---

## 🎨 Customization Tips

- **Add your own aliases**: Create `~/.mshell/local` and source it from `~/.zshrc` after mshell
- **Change the prompt**: Edit `starship.toml` — modules are toggled with `disabled = true/false`
- **Switch AI model**: Edit `aichat_config.yaml` and change the `model:` field
- **Add a plugin**: Append the git URL to `plugins.txt` and run `./install`
- **iTerm2 colors**: Import any `.itermcolors` file from the `iterm2/` directory

---

## 📂 Repository Structure

```
~/.mshell/
├── install              # Bootstrap script (run once or re-run safely)
├── custom               # Entry point sourced by ~/.zshrc
├── env                  # Environment variables, PATH, fzf config
├── aliases              # Shell aliases
├── functions            # Shell functions (gai, how, hsearch, etc.)
├── gitconfig            # Git aliases and configuration
├── starship.toml        # Prompt configuration
├── aichat_config.yaml   # AI tool configuration
├── plugins.txt          # Plugin manifest
├── Brewfile             # Homebrew dependencies
├── zsh/
│   ├── custom           # Zsh-specific setup, keybindings, completions
│   ├── auto_updater.zsh # Weekly update checker
│   ├── project_detector.zsh # chpwd hook for project detection
│   └── plugins/         # Cloned zsh plugins
├── iterm2/              # iTerm2 color schemes
└── working/             # Runtime state (history, zoxide data, update timestamps)
```

---

<p align="center">
  <sub>Built for macOS · zsh · iTerm2</sub>
</p>
