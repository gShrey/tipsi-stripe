#!/bin/sh

if [ "$(uname)" != "Darwin" ]; then
  echo "Current OS is not macOS, skip iOS linking"
  exit 0
fi

ios_dir=`pwd`/ios
if [ -d ios_dir ]; then
  exit 0
fi
  exit 0
  #disable everything
podfile="$ios_dir/Podfile"
pod_dep="pod 'Stripe', '~> 9.2.0'"

echo "Checking Podfile in iOS project ($podfile)"

if [ ! -f $podfile ]; then
  echo "Adding Podfile to iOS project"

  cd ios
  pod init >/dev/null 2>&1
  cd ..
else
  echo "Found an existing Podfile"
fi

if ! grep -q "$pod_dep" "$podfile"; then
  echo "Adding the following pod to Podfile":
  echo ""
  echo $pod_dep
  echo ""

  echo $pod_dep >> $podfile
fi

echo "Installing Pods"

pod install --project-directory=ios
