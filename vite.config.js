import zigar from "rollup-plugin-zigar";
import { defineConfig } from "vite";

export default defineConfig({
  base: "./",

  plugins: [
    zigar({ topLevelAwait: false })
  ]
});
