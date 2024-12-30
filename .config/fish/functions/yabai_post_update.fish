function yabai_post_update --description 'Update yabai sudoers file after installation'
    set -l yabai_path (which yabai)
    set -l yabai_hash (shasum -a 256 $yabai_path | cut -d " " -f 1)
    set -l current_user (whoami)

    printf "%s ALL=(root) NOPASSWD: sha256:%s %s --load-sa\n" \
        $current_user \
        $yabai_hash \
        $yabai_path | sudo tee /private/etc/sudoers.d/yabai
end
