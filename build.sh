#!/bin/bash

clear
echo ""
zig build
./zig-out/bin/weird-js.exe # $1 $2
