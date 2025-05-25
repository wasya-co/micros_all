
require 'typesense'

client = Typesense::Client.new(
  nodes: [{
    host:     'localhost', # For Typesense Cloud use xxx.a1.typesense.net
    port:     8108,        # For Typesense Cloud use 443
    protocol: 'http'       # For Typesense Cloud use https
  }],
  api_key:  'xyz',
  connection_timeout_seconds: 2
)

books_schema = {
  'name' => 'books',
  'fields' => [
    {'name' => 'title', 'type' => 'string' },
    {'name' => 'authors', 'type' => 'string[]', 'facet' => true },

    {'name' => 'publication_year', 'type' => 'int32', 'facet' => true },
    {'name' => 'ratings_count', 'type' => 'int32' },
    {'name' => 'average_rating', 'type' => 'float' }
  ],
  'default_sorting_field' => 'ratings_count'
}

client.collections.create(books_schema)
books_data = File.read('data/books.jsonl')
client.collections['books'].documents.import(books_data)

search_parameters = {
  'q'         => 'harry potter',
  'query_by'  => 'title',
  'sort_by'   => 'ratings_count:desc'
}

outs = client.collections['books'].documents.search(search_parameters)

puts outs



