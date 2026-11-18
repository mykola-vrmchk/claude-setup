# claude-setup

Personal Claude Code configuration. One copy of each file serves local and cloud sessions.

- `output-styles/architect.md`: the Architect output style.
- `install.sh`: installs the styles into `~/.claude` and sets `outputStyle` to `Architect`, keeping other settings.

## Local install

```bash
git clone git@github.com:mykola-vrmchk/claude-setup.git ~/claude-setup && bash ~/claude-setup/install.sh
```

The style is a symlink into the clone. Edit it there, then restart Claude Code.

## Cloud sessions (claude.ai/code)

Add this line to the environment's setup script:

```bash
curl -fsSL https://raw.githubusercontent.com/mykola-vrmchk/claude-setup/main/install.sh | bash || echo 'claude-setup: install failed'
```
