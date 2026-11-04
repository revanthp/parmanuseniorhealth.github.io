---
title: "Alerts"
description: "Latest notices, circulars and announcements for DAE pensioners and CHSS beneficiaries"
weight: 25

# The alerts section publishes only its RSS feed (/alerts/index.xml), which the
# app's FCM broadcast reads. No HTML is written for the section or its pages.
outputs: ["rss"]
build:
  list: never        # keep the section out of site-wide page lists
sitemap:
  disable: true
noindex: true

# Applied to every alert page in this folder.
cascade:
  - build:
      render: link   # no HTML file, but the page keeps its permalink as the feed <guid>
      list: local    # only in this section's .RegularPages (the feed); not in the
                     # site RSS, sitemap, tag pages or any other site-wide list
    sitemap:
      disable: true
    noindex: true
---
