#!/usr/bin/env bash

# thanks to rxyhn

path () {
  local temp_path=null
  for i in /sys/class/hwmon/hwmon*/temp*_input;
  do
    temp_path="$(echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null ||
      echo $(basename ${i%_*})) $(readlink -f $i)");"
    label="$(echo $temp_path | awk '{print $2}')"
    if [ "$label" = "Package" ];
    then
      echo ${temp_path} | awk '{print $5}' | tr -d ';\n'
      exit;
    fi
  done
}

get () {
  sensors | awk '/Tctl:/ {gsub(/[+°C]/,"",$2); print int($2)}'
}

_ () {
  ${@}
  exit 0
}

if [[ $1 == "get" ]]; then
  _ get
fi
