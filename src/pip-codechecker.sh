#!/bin/bash
if [[ ! -z "$CODECHECKER_ACTION_DEBUG" ]]; then
  set -x
fi

echo "::group::Installing CodeChecker from PyPI"
if [[ "$IN_VERSION" == "master" ]]; then
  # The default branch name "master" is offered as a convenient shortcut for
  # fetching the latest release.
  pip3 install codechecker
else
  pip3 install codechecker=="$IN_VERSION"
fi
pip3 show codechecker
echo "::endgroup::"

which CodeChecker
CodeChecker analyzer-version
CodeChecker web-version

echo "PATH=$(dirname $(which CodeChecker))" >> "$GITHUB_OUTPUT"
echo "VERSION=$(CodeChecker analyzer-version | grep 'Base package' | cut -d'|' -f 2 | tr -d ' ')" >> "$GITHUB_OUTPUT"
echo "GITSEVEN=$(CodeChecker analyzer-version | grep 'Git commit' | cut -d'|' -f 2 | cut -c 2-8)" >> "$GITHUB_OUTPUT"
