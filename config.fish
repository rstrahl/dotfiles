set PATH /opt/bin $PATH
set PATH $HOME/.rbenv/opt/bin $PATH
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

function config
	subl ~/.config/fish/config.fish
end

# Git Status in Prompt
function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_diff (git diff)

  if test -n "$git_diff"
    echo (set_color red) $branch (set_color normal)
  else
    echo (set_color green) $branch (set_color normal)
  end
end

#	Prompt
function fish_prompt
  if test -d .git
    printf '%s@%s %s%s%s:%s> ' (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s@%s %s%s%s> ' (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  end
end
