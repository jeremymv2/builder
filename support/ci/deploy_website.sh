#!/bin/bash

set -eu

if [[ "${TRAVIS_PULL_REQUEST}" = "false" ]] && [[ "${TRAVIS_BRANCH}" = "master" ]]; then
  echo "We are not on a PR and on the master branch. Going to deploy the site."
  cd www
  make deploy
else
  if [[ "${TRAVIS_PULL_REQUEST}" = "false" ]] && [[ "${TRAVIS_BRANCH}" =~ ^acceptance_deploy ]]; then
    echo "We are on a PR or against the master branch. Deploying to Acceptance."
    cd www
    BUILDER_WEB_URL="https://bldr.acceptance.habitat.sh" GITHUB_APP_URL="https://github.com/apps/habitat-builder-acceptance" make acceptance
  fi
fi
