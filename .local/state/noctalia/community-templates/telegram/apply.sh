#!/usr/bin/env bash
set -euo pipefail

# Telegram paints a chat wallpaper over the whole content area. Wrap the
# generated color scheme in a standard .tdesktop-theme archive with a solid
# Noctalia-colored background: a fully transparent PNG is composited as white
# by this Qt/Wayland build because the top-level window is not ARGB-enabled.
theme_path="$HOME/.var/app/org.telegram.desktop/data/TelegramDesktop/noctalia.tdesktop-theme"
[ -f "$theme_path" ] || exit 0

work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT

if unzip -t "$theme_path" >/dev/null 2>&1; then
  unzip -p "$theme_path" colors.tdesktop-theme > "$work_dir/colors.tdesktop-theme"
else
  cp "$theme_path" "$work_dir/colors.tdesktop-theme"
fi

# Older generated copies had these two values hardcoded to a purple Catppuccin
# color. Keep them aligned with the current Material 3 surface container.
sed -i \
  -e 's/^chat_inBubbleSelected: #313244/chat_inBubbleSelected: #322826/' \
  -e 's/^chat_outBubbleSelected: #313244/chat_outBubbleSelected: #322826/' \
  "$work_dir/colors.tdesktop-theme"

background_hex="$(sed -n 's/^windowBg:[[:space:]]*#\([0-9a-fA-F]\{6\}\).*/\1/p' "$work_dir/colors.tdesktop-theme" | head -1)"
background_hex="${background_hex:-1a1110}"
magick -size 1x1 "xc:#$background_hex" "$work_dir/background.png"
(cd "$work_dir" && zip -q -j "$theme_path.tmp" colors.tdesktop-theme background.png)
mv "$theme_path.tmp" "$theme_path"
