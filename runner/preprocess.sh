#!/usr/bin/env bash
set -euo pipefail

for app in "$(dirname $PWD/$0)/../benchmark"/*/; do
	for lib in "$app"*/; do
		echo -e "Pre-processing $lib"
		cd "$lib"

		if [ -f "$lib/package.json" ] | [ -f "$lib/package-lock.json" ]; then
			echo "Detected npm files, installing dependencies ..."
			npm ci
		fi

		if [ -f "$lib/*.sln" ]; then
			echo "Detected dotnet files, installing dependencies ..."
			dotnet restore
		fi

		if [ -f "$lib/pubspec.yaml" ]; then
			echo "Detected flutter files, installing dependencies ..."
			flutter pub get
		fi
	done
done