. scripts/utils.sh

fmt_step "Setting Fish as the default shell"
if ! grep -q "/fish$" /etc/shells; then
    echo $(which fish) | sudo tee -a /etc/shells
    chsh -s $(which fish)
    fmt_success "Fish added to /etc/shells and set as default shell"
fi


