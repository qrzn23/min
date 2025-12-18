---
layout: default
title: min Library
---

Browse and download the available ePub files from the `books/` directory. New files added to the folder will appear automatically when the site is rebuilt.

## Downloads

{% assign epubs = site.static_files | where: "extname", ".epub" | where_exp: "file", "file.path contains '/books/'" | sort: "name" %}
{% if epubs.size > 0 %}
<ul class="downloads">
  {% for file in epubs %}
  {% assign epub_url = file.path | replace_first: site.source, "" %}
  <li><span class="pill">ePub</span> <a href="{{ epub_url | relative_url }}" download>{{ file.name }}</a></li>
  {% endfor %}
</ul>
{% else %}
<p>No ePub files found yet. Add `.epub` files to the <code>books/</code> folder and rebuild the site.</p>
{% endif %}

## How to build locally

1. Install Ruby and the Jekyll CLI (`gem install jekyll`).
2. Run `jekyll serve` from this directory.
3. Visit the local server URL Jekyll provides to browse the downloads page.
