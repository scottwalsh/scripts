#!/usr/bin/env bash

# Delete all desktop.ini and Thumbs.db on share

find /mnt/media/ -name desktop.ini -exec rm {} \;
find /mnt/media/ -name Thumbs.db -exec rm {} \;
