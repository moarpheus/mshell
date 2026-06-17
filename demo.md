# mshell Demo Script (~15-20 minutes)

A progressive walkthrough from basic shell features to AI-powered workflows.

---

## 1. Basic Navigation & Modern Replacements (3 min)

### ls → eza

```bash
# Basic listing with colors and icons
ls

# Tree view (2 levels deep)
ls --tree --level=2

# Show git status alongside files
ls --long --git
```

**Explain:** eza replaces ls with colors, icons, git-awareness, and tree view built in.

### cat → bat

```bash
# Syntax-highlighted file viewing
cat ~/.mshell/aliases

# Show specific line range
bat --line-range 1:20 ~/.mshell/functions
```

**Explain:** bat adds syntax highlighting, line numbers, and git diff markers to file viewing.

### ping → prettyping

```bash
# Graphical ping output
ping google.com
# (Ctrl+C after a few pings)
```

**Explain:** prettyping wraps ping with a visual graph — easier to spot packet loss at a glance.

---

## 2. Smart Navigation with Zoxide (2 min)

```bash
# cd is aliased to zoxide's z command
# Jump to a frequently visited directory with partial match
cd mshell

# Jump to something you've visited before
cd personal

# Show the frecency database
zoxide query --list | head -20
```

**Explain:** Zoxide learns from your cd habits. It ranks directories by frequency + recency (frecency). Type partial names and it jumps to the best match.

---

## 3. Fuzzy Finding with fzf (3 min)

### History search

```bash
# Fuzzy search through shell history
# Press Ctrl+R, then type partial command
```

### File search

```bash
# Press Ctrl+T to fuzzy-find files in current directory
# Uses ripgrep under the hood — respects .gitignore
```

### Git branch checkout via fzf

```bash
# Interactive branch picker with preview
g col
```

### Git diff with fzf

```bash
# Pick files to diff interactively with delta preview
gd
```

**Explain:** fzf is the glue that makes everything interactive. Ctrl+R for history, Ctrl+T for files, and it's wired into git workflows too. The `?` key toggles preview inside any fzf picker.

---

## 4. Git Workflow Aliases (3 min)

### Quick status and log

```bash
# Short status
gst

# Pretty graph log
gl
```

### Branch management

```bash
# Create a new branch
g n demo/kiro-tooling

# See what you did since yesterday
g standup
```

### Stash with preview

```bash
# View stashes with fzf preview
g sl
```

### Cleanup

```bash
# Delete branches whose remote is gone
g prune-remote

# Delete merged branches
g cleanup
```

**Explain:** These aliases collapse multi-flag git commands into short memorable mnemonics. The fzf integration means you rarely have to type branch names.

---

## 5. Project Detection (2 min)

```bash
# cd into a Node.js project
cd ~/code/some-node-project

# Notice: node_modules/.bin is added to PATH automatically
# Notice: Makefile targets are displayed if present
echo $PATH | tr ':' '\n' | head -5

# cd out — PATH is cleaned up
cd ~
```

**Explain:** The chpwd hook detects project markers (package.json, Makefile, .env) and auto-configures your environment. No manual setup per project.

---

## 6. Docker & Kubernetes Shortcuts (1 min)

```bash
# Docker shortcuts
d ps                    # docker ps
dc up -d               # docker-compose up -d
dsh my-container       # shell into a running container
dcl api                # tail logs for a compose service

# Kubernetes
k get pods             # kubectl get pods
```

**Explain:** Single-letter aliases for tools you use dozens of times a day. Small savings that compound.

---

## 7. Plugin Management (1 min)

```bash
# Show plugin manifest
cat plugins.txt

# Update all plugins to latest
update_plugins
```

**Explain:** No plugin framework (oh-my-zsh, zinit). Just a text file with git URLs and a simple clone/pull script. Fast startup, no magic.

---

## 8. Auto-Updater (1 min)

```bash
# Check how it works
cat ~/.mshell/zsh/auto_updater.zsh

# It runs on shell startup every 7 days
# Fetches with a 2-second timeout (never blocks)
# Prompts y/n if updates exist
```

**Explain:** Your dotfiles stay current without you thinking about it. If the network is slow or down, it silently skips.

---

## 9. AI Integration — The Grand Finale (4 min)

### Chat with local LLM

```bash
# Ask a question
ai "what does the -Z flag do in curl?"
```

### Command suggestion

```bash
# Describe what you want in plain English
how "find all files larger than 100MB in home directory"

# It suggests the command and offers to run it
```

### AI commit messages

```bash
# Stage some changes
gaa

# Generate a commit message from the diff
gai

# It reads the diff, suggests a conventional commit message
# Accept with y, reject with n
```

### History search by description

```bash
# Find a past command by describing what it did
hsearch "that docker cleanup command I ran last week"
```

**Explain:** All AI features connect to a local LLM (LM Studio / mlx-lm-server on localhost:1234). No data leaves your machine. The `how` command is like having a shell expert on speed dial, and `gai` eliminates the "what do I write for this commit" friction.

---

## Wrap-Up Talking Points

- **Startup time:** Fast — no framework overhead, lazy-loaded completions
- **Portable:** One `git clone && ./install` sets up everything
- **Composable:** Each piece (aliases, functions, plugins) is a separate file
- **AI-local:** All intelligence runs on your machine via aichat + local models
- **Self-updating:** Weekly check keeps it fresh without manual pulls

---

## Quick Reference for Live Demo

| Demo Beat | Key Command | Wow Factor |
|-----------|-------------|------------|
| Pretty files | `ls --tree` | Icons + colors |
| Syntax cat | `cat aliases` | Highlighted code |
| Smart jump | `cd mshell` | Instant teleport |
| Fuzzy history | `Ctrl+R` | Type and filter |
| Git branches | `g col` | fzf + preview |
| Git diff | `gd` | delta + fzf |
| Project detect | `cd node-project` | Auto PATH |
| AI chat | `ai "question"` | Local LLM answers |
| AI command | `how "description"` | Suggests + runs |
| AI commit | `gai` | Reads diff, writes msg |
