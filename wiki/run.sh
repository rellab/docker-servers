docker run -d --rm -p 4567:4567 -v $(pwd)/wikidata:/wiki gollumwiki/gollum:master --allow-uploads --mathjax --h1-title
