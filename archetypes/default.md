+++
title       = "{{ replace .Name \"-\" \" \" | title }}"
description = ""
date        = "{{ .Date }}"
lastmod     = "{{ .Date }}"
draft       = false
weight      = 20
type        = "page"
layout      = "single"

[menu.main]
# .Section is the parent folder under content/,
# humanized by replacing "-" with " " and title-casing
parent = "{{ replace .Section \"-\" \" \" | title }}"
+++
