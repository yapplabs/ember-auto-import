#!/bin/bash

set -e

# All packages get a node_modules directory and a .bin link
for package in "sample-direct" "sample-indirect" "sample-addon" "sample-failure" "sample-intermediate-addon" "sample-double-indirect"; do
    mkdir -p ./test-apps/$package/node_modules
    pushd ./test-apps/$package/node_modules > /dev/null
    rm -rf .bin
    ln -s ../../../node_modules/.bin .bin
    popd > /dev/null
done


# These packages get to depend on ember-auto-import
for package in "sample-direct" "sample-addon" "sample-failure"; do
    pushd ./test-apps/$package/node_modules > /dev/null
    rm -rf ./ember-auto-import
    ln -s ../../.. ./ember-auto-import
    popd > /dev/null
done

# These packages get to depend on our sample-addon
for package in "sample-indirect" "sample-intermediate-addon"; do
    pushd ./test-apps/$package/node_modules > /dev/null
    rm -rf ./sample-addon
    ln -s ../../sample-addon ./sample-addon
    popd > /dev/null
done

# These packages get to depend on our sample-intermediate-addon
for package in "sample-double-indirect" ; do
    pushd ./test-apps/$package/node_modules > /dev/null
    rm -rf ./sample-intermediate-addon
    ln -s ../../sample-intermediate-addon ./sample-intermediate-addon
    popd > /dev/null
done


# These packages get to depend on inner-lib and inner-lib2
for package in "sample-addon" ; do
    pushd ./test-apps/$package/node_modules > /dev/null
    rm -rf ./inner-lib
    ln -s ../../inner-lib ./inner-lib
    rm -rf ./inner-lib2
    ln -s ../../inner-lib2 ./inner-lib2
    popd > /dev/null
done

