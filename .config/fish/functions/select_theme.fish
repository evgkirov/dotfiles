function select_theme --description 'Select and apply a theme across different applications'
    set choice (fd -td --format {/} . $HOME/.config/themes | fzf)
    if test -n "$choice"
        echo "Selected $choice"
        echo $choice > $HOME/.config/themes/current
        touch $HOME/.config/sketchybar/sketchybarrc
        touch $HOME/.config/wezterm/wezterm.lua
        cp $HOME/.config/themes/$choice/ghostty.conf $HOME/.config/ghostty/current_theme.conf
        osascript -e 'tell application "Ghostty" to activate'
        skhd -k 'cmd-r'
    end
end
