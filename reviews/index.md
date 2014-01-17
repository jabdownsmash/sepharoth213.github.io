---
layout: default
title: reviews
name: reviews
---

{% for post in site.categories.reviews %}
  <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}