#!/bin/env sh

set -e

echo Moving "$(dirname "$0")" to ~;

mv "$(dirname "$0")/{.,}*" ~/
rm "$(dirname "$0")"
