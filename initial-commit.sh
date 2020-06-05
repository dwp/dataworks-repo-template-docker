#!/bin/bash
ORIGIN=$(git remote get-url origin)

git remote set-url origin $ORIGIN
git checkout -b initial-commit
git submodule add https://github.com/dwp/dataworks-githooks .githooks
make git-hooks

rm initial-commit.sh

git add --all
git commit -m "Initial commit, adding githooks submodule"
git push --quiet --set-upstream origin initial-commit
