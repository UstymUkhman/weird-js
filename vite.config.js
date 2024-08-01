import zigar from "rollup-plugin-zigar";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [zigar({ topLevelAwait: false })]
});
