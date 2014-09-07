#!/bin/bash

VERSION=$1
if [[ -z "$VERSION" ]]; then
    echo "Usage: $0 <version>"
    exit 1
fi

HEAD="$(git rev-parse HEAD)"

if [[ -z "$TRAVIS_COMMIT" ]]; then
    LAST_COMMIT="$HEAD"
else
    LAST_COMMIT="$TRAVIS_COMMIT"
fi
COMMITTER_NAME="$(git show -s --format=%cn $LAST_COMMIT)"
COMMITTER_EMAIL="$(git show -s --format=%ce $LAST_COMMIT)"
export DEBEMAIL="$COMMITTER_NAME <$COMMITTER_EMAIL>"

if [[ -z "$TRAVIS_COMMIT_RANGE" ]]; then
    COMMITS="$HEAD"
else
    COMMITS="$(git rev-list --abbrev-commit $TRAVIS_COMMIT_RANGE|tr '\n' ' ')"
fi
echo "commits: $COMMITS"

#git log --oneline|awk '{$1=""; print substr($0,2)}'|while read -r line; do
for commit in $COMMITS; do
    line="$(git show -s --format=%s $commit)"
    grep "$line" debian/changelog > /dev/null 2>&1
    if [[ $? != 0 ]]; then
        echo "Adding $commit"
        debchange -v $VERSION "$line" || exit 1
    fi
done

debchange -r ""

if [[ -n "$TRAVIS_BUILD_NUMBER" ]]; then
    git config credential.helper "store --file=~/.gitcredentials"
    echo "https://${GH_TOKEN}:@github.com" > ~/.gitcredentials
    git config user.name "$COMMITTER_NAME"
    git config user.email "$COMMITTER_EMAIL"
    git add debian/changelog
    git commit -m "Update debian/changelog [ci skip]."
    git push
fi

exit 0
