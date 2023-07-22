#!/bin/bash

# Create a new folder for the converted files
mkdir -p ConvertedSwiftFiles

# Find all Swift files and copy them to the new folder with .txt extension
find . -name "*.swift" -exec sh -c 'file="{}"; output="ConvertedSwiftFiles/$(basename "$file" .swift).txt"; cp "$file" "$output"' \;
