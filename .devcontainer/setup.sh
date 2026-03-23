#!/usr/bin/env bash
set -e

echo "🚀 Installing dependencies..."
sudo apt-get update
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

echo "🧩 Installing Dart..."
if ! command -v dart >/dev/null 2>&1; then
  sudo apt-get install -y apt-transport-https
  wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list \
    | sudo tee /etc/apt/sources.list.d/dart_stable.list
  sudo apt-get update
  sudo apt-get install -y dart
fi

echo "⚙️ Installing FVM..."
dart pub global activate fvm

echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.bashrc
export PATH="$PATH:$HOME/.pub-cache/bin"

echo "📦 Installing Flutter 3.41.1 via FVM..."
fvm install 3.41.1
fvm global 3.41.1

echo 'export PATH="$PATH:$HOME/fvm/default/bin"' >> ~/.bashrc
export PATH="$PATH:$HOME/fvm/default/bin"

echo "🌐 Enable Flutter Web..."
flutter config --enable-web

echo "🧪 Doctor check..."
flutter doctor || true

echo "✨ Setup complete!"
