#!/bin/sh

#  travis-script.sh
#  Sortanim
#
#  Created by Ahmed Farghaly on 7/19/16.
#  Copyright © 2016 Ahmed Farghaly. All rights reserved.

echo "Starting Travis..."

set -o pipefail

SCHEME="Sortanim"

xcodebuild -project dev/Sortanim.xcodeproj \
-scheme "$SCHEME" \
-sdk iphonesimulator \
-destination "platform=iOS Simulator,name=iPhone 6s,OS=latest" \

result=$?
echo "Completed Tests with exit code: $result"

if [ $result -ne 0 ]; then
[[ -e $TEST_LOG ]] && tail -n 200 $TEST_LOG
fi

exit $result
