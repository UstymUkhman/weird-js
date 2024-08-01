# Weird JS

[JavaScript Is Weird (EXTREME EDITION)](https://youtu.be/sRWE5tnaxlI) algorithm written in Zig (for learning purposes) and exposed on the web via WASM.

## Download

```bash
git clone https://github.com/UstymUkhman/weird-js.git
cd weird-js
```

## Develop

```bash
# CMD:
./build.sh

# This script optionally accepts 2 arguments,
# JS code to compile and an output file name:
./build.sh "console.log('Hi!')" out

# Run:
node ./zig-out/out.js

# Web:
bun i
bun dev
```

## Build

```bash
bun run build
bun run preview
```
