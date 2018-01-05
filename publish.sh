#!/bin/bash
set -e
rm -rf pkg

echo '~~~ Build the gem'
bundle install
bundle exec rake install

echo '+++ Upload to artifactory'
curl -H "X-JFrog-Art-Api:$ARTIFACTORY_SECRET" -X PUT "https://na.artifactory.swg-devops.com/artifactory/compose-gems-local/gems/" -T $(find pkg -name \*.gem -print | tail -n 1)