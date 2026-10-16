#!/bin/sh -eu

# Appends one test framework to the test_frameworks list the base image
# wrote in /versions.json, keeping any entry an earlier image added. Stops
# the build if the list is not found, rather than record nothing. Short grep
# flags because busybox grep has no long ones.
add_test_framework()
{
  name="${1}"
  version="${2}"
  entry="{\"name\": \"${name}\", \"version\": \"${version}\"}"
  if grep -q '"test_frameworks": \[\]' /versions.json; then
    sed -i "s|\"test_frameworks\": \[\]|\"test_frameworks\": [${entry}]|" /versions.json
  else
    sed -i "/\"test_frameworks\": \[/s|}\]|}, ${entry}]|" /versions.json
  fi
  if ! grep -q -F "${entry}" /versions.json; then
    echo "Could not add ${name} to /versions.json" >&2
    cat /versions.json >&2
    exit 1
  fi
}

# funit is a ruby gem that generates and builds the Fortran test runner, so
# the image needs ruby and make beside gfortran. No version is named, so a
# rebuild installs the newest funit.
apk add --no-cache ruby make
gem install funit

# Asked of rubygems, which records what is actually installed.
readonly FUNIT_VERSION=$(gem list --exact funit | sed -n 's/^funit (\([0-9.]*\)).*$/\1/p')
if [ -z "${FUNIT_VERSION}" ]; then
  echo 'Could not read the installed funit version' >&2
  gem list funit >&2
  exit 1
fi
add_test_framework funit "${FUNIT_VERSION}"
cat /versions.json
