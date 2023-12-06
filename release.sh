#!/bin/bash

rm -rf docs/*
flutter clean
cd example/
flutter build web --release
cd ..
mv example/build/web/* docs

echo "Content successfully moved to docs"
