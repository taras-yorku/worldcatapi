worldcatapi
============

The RUBY API to access WorldCat.org webservices. Inspired by original wcapi implementation


# Worldcatapi

Forked from RubyForge WCAPI project. It now lives on rubygems.org for easy installation and usage. 

## Installation

Add this line to your application's Gemfile:

    gem 'worldcatapi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install worldcatapi

## Usage

Clone this project and look at example.rb file.

It outlines all of the available operations.
    
    require 'worldcatapi'
    
    client = WORLDCATAPI::Client.new key: YOUR_KEY
    response = client.OpenSearch(q: 'Ruby Development', format: 'atom', start: 1, count: 20, cformat: "all")
    
    puts "Total Results #{response.header["totalResults"]
    response.records.each do |record| 
        puts "title: #{record[:title]}\n"
        puts "url: #{record[:link]}\n"
        puts "authors: #{record[:author].join(", "}\n"
        puts "description: #{record[:summary]}\n"
    end

More examples available in example.rb

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
