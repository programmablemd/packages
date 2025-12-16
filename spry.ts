#!/usr/bin/env -S deno run -A --node-modules-dir=auto
// Use `deno run -A --watch` in the shebang if you're contributing / developing Spry itself.

// import { CLI } from "https://raw.githubusercontent.com/sijucj/spry_private/refs/tags/v0.106.0/bin/spry.ts";
import { CLI } from "https://raw.githubusercontent.com/programmablemd/spry/refs/tags/v0.106.0/bin/spry.ts";

await CLI({ defaultFiles: ["Spryfile.md"] }).parse(Deno.args);
