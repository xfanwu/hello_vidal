Vidalo
===========

Vidalo is a simple ruby gem for [Vidal](https://vidal.3scale.net/docs/api_fr) REST API.

## Requirements

0. **APP_ID & APP_KEY** You may need to apply from Vidal's [website](https://vidal.3scale.net/signup)
1. **Faraday** - HTTP connection
2. **Nokogiri** - XML parser

## A simple test example

```ruby
require 'nokogiri'
require 'faraday'
require 'vidalo'

api = Vidalo::Connection.new('YOUR_APP_ID', 'YOUR_APP_KEY')

## Get total number of products ##
total = api.get_number_of_products

## Search a set of products (A set of Nokogiri XML elements) ##
result = api.search(type: 'packages', query: 'Doliprane', page_size: 20, start_page: 1)

## Get a node inner text ##
title = api.get_inner_text(type: 'package', id: 5355, node: 'title')
```

## Todo

- Get a product with aggregating information.
- Get packages from a product.
- Search a product/package by its cip13 code.

More features are comming and welcome to fork.
