#!/bin/sh
# Mirrors the ./relate folder (course.yml, flows/*.yml, ...) into a git repo that
# RELATE can use as "Git source". Re-run after editing, then Fetch + Update in RELATE.
set -e
here=$(cd "$(dirname "$0")" && pwd)
out=${1:-$here/_course_repo}
mkdir -p "$out"
rsync -a --delete --exclude .git "$here/relate/" "$out/"
cd "$out"
[ -d .git ] || git init -q -b main
git add -A
git -c user.name=demo -c user.email=demo@example.com commit -qm "update demo course" || echo "no changes"
echo "Git source: $out"
