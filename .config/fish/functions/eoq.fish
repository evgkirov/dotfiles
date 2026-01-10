function eoq
    cd ~/Obsidian/Personal
    nvim -c "call timer_start(200, {-> execute('ObsidianQuickNote')})"
end
