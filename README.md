Hello Vidal
===========

HelloVidal is a simple ruby gem for [Vidal](https://vidal.3scale.net/docs/api_fr) REST API.

## Requirements

You may need to apply an app-id and app-key from Vidal's [website](https://vidal.3scale.net/signup)

1. **Faraday** - HTTP connection
2. **Nokogiri** - XML parser

## A simple test example

```ruby
require 'nokogiri'
require 'faraday'
require 'hello_vidal'

APP_ID = 'yourappid'
APP_KEY = 'yourappkey'

api = HelloVidal.new(APP_ID, APP_KEY)

## Get total number of products ##
total = api.get_number_of_products

## Search a set of products (A set of Nokogiri XML elements) ##
result = api.search(type: 'packages', query: 'Doliprane', page_size: 20, start_page: 1)

## Get a node inner text ##
title = api.get_inner_text(type: 'package', id: 5355, node: 'title')
```

More features are comming and welcome to fork.
