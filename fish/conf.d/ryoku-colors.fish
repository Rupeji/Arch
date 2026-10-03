# Ryoku palette for fish and fzf. Rendered by the theme daemon; do not edit.
#
# Dropped straight into conf.d, which fish sources on its own, so nothing in the
# shipped config has to include it. Your ~/.config/fish/user.fish loads last and
# still wins.

# Syntax highlighting.
set -g fish_color_normal f0dfd6
set -g fish_color_command ffb782
set -g fish_color_keyword c7ca95
set -g fish_color_quote e4bfa7
set -g fish_color_redirection d6c3b7
set -g fish_color_end c7ca95
set -g fish_color_error ffb4ab
set -g fish_color_param f0dfd6
set -g fish_color_comment d6c3b7
set -g fish_color_selection --background=6d390a
set -g fish_color_operator c7ca95
set -g fish_color_escape e4bfa7
set -g fish_color_autosuggestion d6c3b7
set -g fish_color_cancel ffb4ab
set -g fish_color_search_match --background=6d390a
set -g fish_color_valid_path --underline

# Completion pager.
set -g fish_pager_color_progress d6c3b7
set -g fish_pager_color_prefix ffb782
set -g fish_pager_color_completion f0dfd6
set -g fish_pager_color_description d6c3b7
set -g fish_pager_color_selected_background --background=6d390a

# fzf takes the same palette, so Ctrl-R and Ctrl-T match the terminal they open
# in. Appended to whatever options are already set rather than replacing them.
set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
--color=fg:#f0dfd6,bg:-1,hl:#ffb782 \
--color=fg+:#f0dfd6,bg+:#6d390a,hl+:#ffb782 \
--color=info:#e4bfa7,prompt:#ffb782,pointer:#c7ca95 \
--color=marker:#c7ca95,spinner:#e4bfa7,header:#d6c3b7 \
--color=border:#52443b"
