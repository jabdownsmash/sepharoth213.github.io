---
layout: default
title: blog posts
name: blog
---

{% for post in site.categories.blog %}
  <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}