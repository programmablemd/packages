#!/usr/bin/env -S deno run -A --node-modules-dir=auto
// Use `deno run -A --watch` in the shebang if you're contributing / developing Spry itself.

// Monkey-patch fetch to support GH_TOKEN for private asset downloads from Spry repository
const originalFetch = globalThis.fetch;
globalThis.fetch = (input: string | Request | URL, init?: RequestInit) => {
    const url = typeof input === "string" ? input : (input instanceof URL ? input.toString() : input.url);
    const ghToken = Deno.env.get("GH_TOKEN");
    if (ghToken && url.includes("raw.githubusercontent.com/programmablemd/spry")) {
        const headers = new Headers(init?.headers);
        if (!headers.has("Authorization")) {
            headers.set("Authorization", `Bearer ${ghToken}`);
        }
        return originalFetch(input, { ...init, headers });
    }
    return originalFetch(input, init);
};

import { CLI } from "https://raw.githubusercontent.com/programmablemd/spry/refs/tags/v0.109.2/bin/spry.ts";

await CLI({ defaultFiles: ["Spryfile.md"] }).parse(Deno.args);
