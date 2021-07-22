#!/bin/bash

echo "Making native executable of the project"

scripts/bashScripts/dartSdkDownload.sh # Downloading dart-sdk for the correct architecture.

unzip dartsdk-*.zip
rm dartsdk-*.zip

cd cbj_hub
../dart-sdk/bin/pub get --no-precompile
#sudo ../dart-sdk/bin/pub run build_runner build --delete-conflicting-outputs
cd ..

#chmod -R +rx dart-sdk/
dart-sdk/bin/dart2native cbj_hub/bin/cbj_hub.dart -o CyBear-Jinni_Hub
# sudo dart-sdk/bin/dart CyBear-Jinni_Hub/bin/cbj_hub.dart .

rm -r dart-sdk/
