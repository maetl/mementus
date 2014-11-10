# Mementus

[![Build Status](https://travis-ci.org/maetl/mementus.svg?branch=master)](https://travis-ci.org/maetl/mementus)

Mementus is a transient ORM for creating and querying in-memory object models.

## Installation

Add this line to your application's Gemfile:

    gem 'mementus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mementus

## Usage

### Defining model classes

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

### Creating objects

To write objects to the in-memory index, call their `create` method:

```ruby
book3 = Book.new(
  :title => "Crash",
  :author => "J.G. Ballard"
)

book3.create
```

### Matching queries

Basic match queries can be constructed by passing a predicate hash to the `where` method:

```ruby
Book.where(author: "Doris Lessing")

Book.where(title: "Crash")
```

### Scoped queries

Reusable query shortcuts can be constructed on the model class by defining a `scope`:

```ruby
class Book < Mementus::Model
  attribute :title, String
  attribute :author, String
  attribute :genre, String
  scope :scifi, genre: 'scifi'
  scope :romance, genre: 'romance'
end 
```

These defined scopes become class methods on the model:

```ruby
scifi_books = Book.scifi
romance_books = Book.romance
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
