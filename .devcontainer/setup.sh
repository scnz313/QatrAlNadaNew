#!/bin/bash

# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter
export PATH="$PATH:/usr/local/flutter/bin"

# Enable flutter command globally
echo 'export PATH="$PATH:/usr/local/flutter/bin"' >> ~/.bashrc

# Pre-cache Flutter
flutter precache

# Accept Android Licenses (if applicable)
yes | flutter doctor --android-licenses

# Run Flutter Doctor
flutter doctor
