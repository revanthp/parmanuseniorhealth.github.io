+++
title       = "Activate the Paramanu Seniors Notices app"
description = "This link activates the Paramanu Seniors Notices app. Install the app from Google Play, then enter your activation code."
date        = "2026-10-27T00:00:00+05:30"
lastmod     = "2026-10-27T00:00:00+05:30"
draft       = false
weight      = 20
# Its own type so it uses layouts/activation/baseof.html, which leaves out analytics.
type        = "activation"
layout      = "single"
# The Android app opens links to exactly this path.
url         = "/activation/"
noindex     = true

[sitemap]
disable = true
+++
# Activate the Paramanu Seniors Notices app

This link is for the **Paramanu Seniors Notices** app on Android phones. You are seeing this page
because the app is not installed on this phone, or it could not open the link.

## Step 1: Install the app from Google Play (skip if you already have it)

<p>
  <a class="btn btn-primary btn-lg" href="https://play.google.com/store/apps/details?id=org.paramanuseniorshealth.notices" rel="noopener">
    Get the app on Google Play (opens Google Play)
  </a>
</p>

## Step 2: Enter your activation code

<div id="activation-code-box" hidden>
  <p>Open the app and type in this activation code:</p>
  <p id="activation-code" class="border rounded p-3 fs-2 fw-bold font-monospace" style="letter-spacing: 0.15em; word-break: break-all;"></p>
</div>

<p id="activation-code-missing">
  Open the app and type in the activation code you were given. The code is the part after
  <code>code=</code> in the link you received.
</p>

<script>
  // Show the code from ?code= so it can be typed into the app. It is only shown on this
  // page, never sent anywhere.
  (function () {
    var code = new URLSearchParams(window.location.search).get("code");
    code = code ? code.trim() : "";
    if (!/^[A-Za-z0-9-]{1,64}$/.test(code)) return;
    // Show it the way the app does: uppercase, as XXXX-XXXX when it is 8 characters long.
    code = code.toUpperCase();
    var bare = code.replace(/-/g, "");
    if (bare.length === 8) code = bare.slice(0, 4) + "-" + bare.slice(4);
    document.getElementById("activation-code").textContent = code;
    document.getElementById("activation-code-box").hidden = false;
    document.getElementById("activation-code-missing").hidden = true;
  })();
</script>

## Need help?

If the code does not work, or you did not get one, please [contact us](/contact/).
