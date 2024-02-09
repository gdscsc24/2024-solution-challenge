for branch in `git branch -r | grep -v '\->'`; do if [ -z "$(git branch --list ${branch#origin/})" ]; then git branch --track "${branch#origin/}" "$branch"; fi done
