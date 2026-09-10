## Dotfiles

This is my current Niri + Noctalia setup with Material 3-ish colors, rounded
corners, a transparent Ghostty, btop on startup, Noctalia lockscreen and some
custom app themes.

### Installation

**Arch-based Linux**

```bash
sudo pacman -S nerd-fonts niri starship btop fish noctalia \
	ghostty xwayland-satellite udiskie mako fuzzel
```

Install the apps used by the extra themes if you need them:

```bash
flatpak install flathub org.telegram.desktop com.discordapp.Discord
```

Then clone this repo and paste all of this shit into your home dir:

```bash
cp -a ~/Documents/dotfiles/. ~/
```

This repo includes configs under `.config`, `.local` and `.var`, so don't use
`cp *` — it will skip the hidden folders.

### What's inside

- Niri config and Noctalia settings.
- Ghostty theme, shader and soft background transparency.
- Fish and btop configs.
- Zen Browser Material-style userChrome template.
- Telegram Flatpak Material-style theme with a dark background.
- Discord Vencord Noctalia themes.
- Noctalia desktop audio visualizer.

### Small warning

`.local/bin/noctalia` is a wrapper for my local Noctalia build. It expects the
binary at `~/.local/lib/noctalia/noctalia` and its assets at
`~/.local/share/noctalia/assets`.

If you use the normal package version, change the absolute Noctalia paths in
`.config/niri/config.kdl` to just `noctalia`.

Runtime data, browser profiles, Telegram accounts, notification history and
other secret/private stuff are intentionally not included here.
