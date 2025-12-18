---
layout: default
title: min Library
---

Browse and download the available ePub files from the `books/` directory. New files added to the folder will appear automatically when the site is rebuilt.

## Downloads

{% assign epubs = site.static_files | where: "extname", ".epub" | where_exp: "file", "file.path contains '/books/'" | sort: "name" %}
{% assign book_metadata = site.data.books | default: empty %}
{% if epubs.size > 0 %}

<label for="book-search" class="sr-only">Search downloads</label>
<input id="book-search" type="search" placeholder="Search by title, author, or topic" aria-describedby="book-search-hint" />
<p id="book-search-hint" class="small">Start typing to filter the list.</p>

<div class="table-wrapper">
  <table class="downloads-table">
    <thead>
      <tr>
        <th scope="col">Title</th>
        <th scope="col">Author</th>
        <th scope="col">Topic</th>
        <th scope="col" class="actions">Download</th>
      </tr>
    </thead>
    <tbody id="downloads-body">
    {% for file in epubs %}
      {% assign metadata = book_metadata[file.name] | default: book_metadata[file.path] %}
      {% assign raw_title = metadata.title | default: file.name %}
      {% assign title = raw_title | replace: file.extname, "" | replace: "_", " " | replace: "-", " " | strip | capitalize %}
      {% assign author = metadata.author | default: "Unknown" %}
      {% assign topic = metadata.topic | default: "General" %}
      {% assign epub_url = file.path | replace_first: site.source, "" %}
      <tr data-title="{{ title | downcase }}" data-author="{{ author | downcase }}" data-topic="{{ topic | downcase }}">
        <td>{{ title }}</td>
        <td>{{ author }}</td>
        <td>{{ topic }}</td>
        <td class="actions"><a class="button" href="{{ epub_url | relative_url }}" download>Download</a></td>
      </tr>
    {% endfor %}
    </tbody>
  </table>
</div>

<script>
  (function() {
    const input = document.getElementById('book-search');
    const rows = Array.from(document.querySelectorAll('#downloads-body tr'));

    if (!input || rows.length === 0) return;

    const normalize = (value) => (value || '').toLowerCase();

    input.addEventListener('input', () => {
      const query = normalize(input.value);

      rows.forEach((row) => {
        const combined = [
          row.dataset.title,
          row.dataset.author,
          row.dataset.topic
        ].join(' ');

        row.hidden = !combined.includes(query);
      });
    });
  })();
</script>
{% else %}
<p>No ePub files found yet. Add `.epub` files to the <code>books/</code> folder and rebuild the site.</p>
{% endif %}

## How to build locally

1. Install Ruby and the Jekyll CLI (`gem install jekyll`).
2. Run `jekyll serve` from this directory.
3. Visit the local server URL Jekyll provides to browse the downloads page.
