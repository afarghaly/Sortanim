#!/bin/sh

#  travis-script.sh
#  Sortanim
#
#  Created by Ahmed Farghaly on 7/19/16.
#  Copyright © 2016 Ahmed Farghaly. All rights reserved.

echo "Starting Travis..."
set -o pipefail

SCHEME="Sortanim"#"${SCHEME:-All UI Tests}"


#if [ "$SCHEME" == "AmigoDevice" ]; then
#swiftlint lint --quiet # run lint once per build
#fastlane beta
#exit
#fi


#BUILD_FOLDER='build'
#TEST_LOG="$BUILD_FOLDER/testLog.txt"
#TEST_RESULT_DIR="$BUILD_FOLDER/testResults"

#rm -rf $TEST_RESULT_DIR || true
#rm $TEST_LOG || true
#mkdir $BUILD_FOLDER || true
#DERIVED_DATA_DIR="$BUILD_FOLDER/XcodeDerivedData"

xcodebuild -project dev/Sortanim.xcodeproj \
-scheme "$SCHEME" \
-sdk iphonesimulator \
-destination "platform=iOS Simulator,name=iPhone 6s,OS=latest" \
#-derivedDataPath "$DERIVED_DATA_DIR" \
build \
| xcpretty -f $(xcpretty-travis-formatter)

#$(dirname $0)/travis-heroku-prepare.sh
#
#xcodebuild -workspace Amigo.xcworkspace \
#-scheme "$SCHEME" \
#-sdk iphonesimulator \
#-destination "platform=iOS Simulator,name=iPhone 6s,OS=latest" \
#-derivedDataPath "$DERIVED_DATA_DIR" \
#-resultBundlePath $TEST_RESULT_DIR \
#test \
#| tee $TEST_LOG | xcpretty -f $(xcpretty-travis-formatter)

result=$?
echo "Completed Tests with exit code: $result"

#SIMULATOR_APP=$(xcrun simctl get_app_container booted io.amigo.BetaAmigo)
#if [ -z ${SIMULATOR_APP+x} ]; then
#echo "Unable to find simulator app folder!"
#exit 3
#fi
#
#echo "Coverage Report"
#bundle exec slather version
#bundle exec slather coverage -x \
#-b "$DERIVED_DATA_DIR" \
#--source-files "{Code,SwiftAmigo}/**/*.{swift,m}" \
#--binary-file "$SIMULATOR_APP/Amigo" \
#--binary-file "$SIMULATOR_APP/Frameworks/SwiftAmigo.framework/SwiftAmigo"
#bash <(curl -s 'https://codecov.io/bash') -D "$DERIVED_DATA_DIR"
#echo "Coverage Report uploaded"
#
#if [ "$SCHEME" == "Amigo" ]; then
#appZip=Amigo.app.zip
#ditto -ck --rsrc --sequesterRsrc --keepParent $SIMULATOR_APP $appZip
#gdriveFileId=0B3cxCkUNrXmoVG4xSXd6cWV1RlU
#if [ -z ${GDRIVE_REFRESH_TOKEN+x} ]; then
#filePath=$(gdrive info $gdriveFileId|grep Path)
#if [ "$filePath" != "Path: Development/BetaBuild/Amigo.app.zip" ]; then
#echo "Unexcpected file path: $filePath"
#exit 2
#fi
#gdrive update $gdriveFileId $appZip
#else
#gdrive --refresh-token $GDRIVE_REFRESH_TOKEN update $gdriveFileId $appZip
#fi
#exit $result
#fi

if [ $result -ne 0 ]; then
[[ -e $TEST_LOG ]] && tail -n 200 $TEST_LOG
fi

#if [ -e $TEST_LOG ]; then
#bundle exec scripts/collect-screenshots.rb $TEST_LOG "$TEST_RESULT_DIR/1_Test" 'test_screenshots'
#fi

exit $result
