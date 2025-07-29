#!/bin/sh -l

BRANCH_NAME=${GITHUB_REF#refs/heads/}
git config --global --add safe.directory /github/workspace

if [ -n "$4" ] && [ "$4" != "0000000000000000000000000000000000000000" ]
then
    git fetch --depth 1  origin $4
    FILES=`git diff FETCH_HEAD HEAD --diff-filter=AM --name-only|grep '\.scm$'|sed 's/^.*$/"&"/g'|tr "\n" " "`
elif [ "$BRANCH_NAME" = "master" -o   "$BRANCH_NAME" = "main" ]
then
    git fetch --unshallow
    FILES=`git diff HEAD^..HEAD --name-only|grep '\.scm$'|sed 's/^.*$/"&"/g'|tr "\n" " "`
else
    git fetch --unshallow
    BASE_NEXT_HASH=$(git log $BRANCH_NAME  --not `git for-each-ref --format='%(refname)' refs |grep -v /$BRANCH_NAME$ ` --pretty=format:"%H"|tail -n 1)
    FILES=`git diff $BASE_NEXT_HASH^ HEAD --diff-filter=AM --name-only|grep '\.scm$'|sed 's/^.*$/"&"/g'|tr "\n" " "`

    echo "BASE_HASH=" $BASE_NEXT_HASH
fi

echo "FILES=" $FILES
