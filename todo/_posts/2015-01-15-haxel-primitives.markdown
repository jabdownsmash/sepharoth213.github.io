---
layout: post
title:  "Haxel Primitives"
date:   2014-01-15 21:00:41
name: "haxelprimitives"
abstract: "Primitives in haxel are using get/set pixel and their own array, should look into optimizing using ByteArray."
---

####Why?

Filled polygon drawing is much too slow for my tastes right now. It should be a snappy quick function, but something about using setPixel() is slow for some reason. It's really very aggravating.