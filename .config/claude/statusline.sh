#!/usr/bin/env bash
# Claude Code status line: <dir> | <branch> | <model> | <context used>K
input=$(cat)

IFS=$'\t' read -r dir model ctx < <(
	jq -r '[
		.workspace.current_dir // .cwd // "",
		.model.display_name // "",
		(.context_window.current_usage // null
			| if . == null then ""
			  else ((.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens) / 1000 | round)
			  end)
	] | @tsv' <<<"$input"
)

sep=" \033[2m|\033[0m "
out="\033[34m${dir/#$HOME/\~}\033[0m"

branch=$(git -C "$dir" branch --show-current 2>/dev/null)
[ -n "$branch" ] && out+="$sep\033[35m$branch\033[0m"

[ -n "$model" ] && out+="$sep\033[38;2;240;147;43m$model\033[0m"
[ -n "$ctx" ] && out+="$sep${ctx}K"

printf '%b\n' "$out"
