#!/bin/bash
#
# Miscellaneous scripts.
#
# Usage:
#   ./run.sh <function name>

set -o nounset
set -o pipefail
set -o errexit

log() {
  echo 1>&2 "$@"
}

die() {
  log "FATAL: $@"
  exit 1
}


# Count lines of code
count() {
  find . \
    -name \*.py -o -name \*.c -o -name \*.h -o -name \*.R -o -name \*.sh \
    | xargs wc -l
}

# This must be a repoistory
readonly DOC_DEST=../rappor-gh-pages

publish() {
  test -d $DOC_DEST || die \
    "This requires that the RAPPOR repo is cloned into $DOC_DEST"

  local dest=$DOC_DEST/examples
  mkdir -p $dest

  cp --verbose --recursive \
    _tmp/report.html \
    _tmp/*_report \
    $dest

  echo "Now switch to $DOC_DEST, commit, and push."
}

"$@"
