#!/usr/bin/env bash
set -Eeuo pipefail

# lint / format only markdown files that are being edited
#
# `remark` can handle formatting an entire directory, however that (a) is slow, and
# (b) touches _every_ file. this script uses git to determine what is changing and only run
# `remark` on those files.
#
# environment variables:
#
# * `MARKDOWN_FORMAT_DIFF_FILTER`: defaults to "AM" -- "Added" and "Modified". during
#   pre-commit, you probably only want to set this to "A", but during editing, "AM"
#

format_file() {
    remark --output "${1}" --frail "${1}"
}

main() {
    local diff_filter="${MARKDOWN_FORMAT_DIFF_FILTER:-AM}"
    local error_files=()
    while read -r file; do
        format_file "${file}" || error_files+=("${file}")
    done < <(git diff --name-only --diff-filter "${diff_filter}" | grep --perl-regexp '\.md$')
    if [ "${#error_files[@]}" -gt 0 ]; then
        echo
        echo "Files with warnings / errors:"
        echo
        for f in "${error_files[@]}"; do
            echo "  ${f}"
        done
        echo
        return 1
    fi
}

main
