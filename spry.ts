#!/usr/bin/env -S deno run -A --node-modules-dir=auto

// Monkey-patch fetch to support GH_TOKEN and serving web-ui from embedded assets
const BAKE_GH_TOKEN = "__BAKED_GH_TOKEN__";
const VERSION = "1.0.2";
const originalFetch = globalThis.fetch;
globalThis.fetch = async (input: string | Request | URL, init?: RequestInit) => {
    const url = typeof input === "string" ? input : (input instanceof URL ? input.toString() : input.url);

    // Intercept web-ui asset requests to serve them from local/embedded files
    if (url.includes("/lib/axiom/web-ui/")) {
        const assetName = url.split("/").pop();
        if (assetName && ["index.html", "index.css", "index.js"].includes(assetName)) {
            try {
                // Try to resolve relative to this script's location
                const assetUrl = new URL(`./web-ui/${assetName}`, import.meta.url);
                const content = await Deno.readTextFile(assetUrl);
                const contentType = assetName.endsWith(".html") ? "text/html; charset=utf-8" :
                    assetName.endsWith(".css") ? "text/css; charset=utf-8" :
                        "text/javascript; charset=utf-8";
                return new Response(content, { headers: { "content-type": contentType } });
            } catch (_e) {
                // Fall back to original fetch
            }
        }
    }

    // Support GH_TOKEN for private asset downloads from Spry repository
    const ghToken = Deno.env.get("GH_TOKEN") || (BAKE_GH_TOKEN.startsWith("__") ? undefined : BAKE_GH_TOKEN);
    if (ghToken && (url.includes("raw.githubusercontent.com/programmablemd/spry"))) {
        const headers = new Headers(init?.headers);
        if (!headers.has("Authorization")) {
            headers.set("Authorization", `Bearer ${ghToken}`);
        }
        return originalFetch(input, { ...init, headers });
    }

    return originalFetch(input, init);
};

// import { CLI } from "https://raw.githubusercontent.com/sijucj/spry_private/v0.111.0/bin/spry.ts";
import { CLI } from "https://raw.githubusercontent.com/programmablemd/spry/refs/tags/v1.0.2/bin/spry.ts";

const cli = await CLI({ defaultFiles: ["Spryfile.md"] });
cli.getVersion = () => VERSION;
await cli.parse(Deno.args);

