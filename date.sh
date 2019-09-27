#!/bin/bash
#A simple testbed for date formatting.

echo "This script ran at $(date +%B%d,%T)"
echo "This script ran at $(date +'%Y-%m-%d %H:%M:%S')"
echo "The script has finished."
