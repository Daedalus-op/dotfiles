#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      web-search.sh
#   created:   24.02.2017.-08:59:54
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   rofi
# Description:
#   Use rofi to search the web.
# Usage:
#   web-search.sh
# -----------------------------------------------------------------------------
# Script:
#
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

list_col='1'
list_row='6'

declare -A URLS

URLS=(
  ["google"]="https://www.google.com/search?q="
  ["bing"]="https://www.bing.com/search?q="
  ["duckduckgo"]="https://www.duckduckgo.com/?q="
  ["github"]="https://github.com/search?q="
  ["symbolhound"]="http://symbolhound.com/?q="
  ["searchcode"]="https://searchcode.com/?q="
  ["youtube"]="https://www.youtube.com/results?search_query="
  ["perplexity"]="https://www.perplexity.ai/search?s=o&q="
  ["tldr"]="https://tldr.inbrowser.app/search?query="
)

# List for rofi
gen_list() {
    for i in "${!URLS[@]}"
    do
      echo "$i"
    done
}
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-dmenu \
		-i \
		-markup-rows \
		-theme ${theme} \
		-normal-window -steal-focus \
		-matching fuzzy -location 0 $*
}

main() {
  # Pass the list to rofi
  platform=$( (gen_list) | rofi_cmd -no-custom)
		

  if [[ -n "$platform" ]]; then
    prompt="Query"
    query=$( (echo ) | rofi_cmd )

    if [[ -n "$query" ]]; then
      url=${URLS[$platform]}$query
      xdg-open "$url"
    else
      exit
    fi

  else
    exit
  fi
}

main

exit 0
