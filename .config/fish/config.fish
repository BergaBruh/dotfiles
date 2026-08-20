if status is-interactive
# Commands to run in interactive sessions can go here
starship init fish | source
fastfetch
set -U fish_greeting ''
end

# Fix color for SSH
function _ssh_classic_palette
    printf '\e]4;0;#000000;1;#cc0000;2;#4e9a06;3;#c4a000;4;#3465a4;5;#75507b;6;#06989a;7;#d3d7cf;8;#555753;9;#ef2929;10;#8ae234;11;#fce94f;12;#729fcf;13;#ad7fa8;14;#34e2e2;15;#eeeeec\e\\'
end

function _ssh_restore_palette
    printf '\e]104\e\\'
end

function __wrap_ghostty_ssh_with_classic_palette --on-event fish_prompt
    functions -e __wrap_ghostty_ssh_with_classic_palette

    functions -q ssh; or return
    functions --copy ssh __ghostty_ssh

    function ssh --wraps ssh --description 'SSH with temporary classic palette'
        if isatty stdin; and isatty stdout
            _ssh_classic_palette
            __ghostty_ssh $argv
            set -l rc $status
            _ssh_restore_palette
            return $rc
        end

        __ghostty_ssh $argv
    end
end

set -gx TERM xterm-256color

# Added by Antigravity CLI installer
set -gx PATH "/home/bergamot/.local/bin" $PATH

# Add Yandex Cloud CLI
fish_add_path -g /home/bergamot/yandex-cloud/bin

fish_add_path /home/bergamot/.spicetify
