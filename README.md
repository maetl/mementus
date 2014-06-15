# Mementus

[![Build Status](https://travis-ci.org/maetl/mementus.svg?branch=master)](https://travis-ci.org/maetl/mementus)

```ruby
# Proof of concept for a toy ORM that combines some aspects of the
# ActiveRecord API with an in-memory query model based on the Axiom
# relational algebra API.
#
# The weirdest trick is that the data stored in the relational model
# is a read-only index that never gets re-materialised back into the
# model objects themselves (though Axiom does seem to be capable of
# doing this).
# 
# Instead of returning mapped data from queries, the Ruby object_id
# is used as a reference to point to the existing instance in the
# runtime object space.
```

## Installation

Add this line to your application's Gemfile:

    gem 'mementus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mementus

## Usage

To define model classes, inherit from the `Mementus::Model` base class and add attributes using the [Virtus API](https://github.com/solnic/virtus):

```ruby
class Book < Mementus::Model
  attribute :title, String
  attribute :author, String
end
```

Create new instances by passing data through the constructor or assigning attributes directly:

```ruby
book1 = Book.new(
  :title => "Gravity's Rainbow",
  :author => "Thomas Pynchon"
)

book2 = Book.new
book2.title = "The Golden Notebook"
book2.author = "Doris Lessing"
```

To write objects to the in-memory index, call their `create` method:

```ruby
book3 = Book.new(
  :title => "Crash",
  :author => "J.G. Ballard"
)

book3.create
```

The query API is currently being worked on. Right now to test it out, you can access the relational collection for each model through the `collection` method, and execute basic matching queries using the `where` method:

```ruby
Book.collection.count

Book.collection.first

Book.where(author: "Doris Lessing")

Book.where(title: "Crash")
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
