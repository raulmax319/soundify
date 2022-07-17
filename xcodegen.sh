#!/bin/sh

echo "Removing xcodeproject files..."
rm -rf *.xcodeproj
rm -rf *.xcworkspace
echo "xcodeproject files removed."
echo "Removing Pods folder..."
rm -rf Pods
echo "Pods folder removed."
echo "Removing Podfile.lock..."
rm Podfile.lock
echo "Podfile.lock removed."
echo "Generating xcodeproject files..."
xcodegen generate