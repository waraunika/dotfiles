#!/bin/bash

playerctl --all-players status 2>/dev/null | grep -q '^Playing$'
