#!/usr/bin/env bash
set -ex

for script in scripts/init_hook.d/*.sh; do
  [[ -x "$script" ]] && "$script"
done
