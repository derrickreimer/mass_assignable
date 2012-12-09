# MassAssignable

MassAssignable is a simple gem that adds Rails-like mass-assignment behavior
to ordinary Ruby objects. This gem has no external dependencies and works
everywhere.

## Installation

Add this line to your application's Gemfile:

    gem 'mass_assignable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mass_assignable

## Usage

Simply include `MassAssignable` in your class and specify mass assignable
attributes using `attr_mass_assignable`. Any attributes not specified
will not be mass assignable.

```ruby
require 'mass_assignable' # not needed with Rails

class Person
  include MassAssignable
  
  attr_accessor :name, :age, :height
  attr_mass_assignable :name, :age
end
```

Then, mass assignment is as easy as calling `attributes=`.

```ruby
person = Person.new
person.attributes = { :name => "Derrick", :age => 24, :height => 77 }

person.name
# => "Derrick"

person.age
# => 24

person.height
# => nil
```

Notice that `#height` is nil, because we didn't include it in our call to
`attr_mass_assignable`.

If you want an error to be raised when invalid mass assignment is attempted,
simply use `attr_mass_assignable!`.

```ruby
class ParanoidPerson
  include MassAssignable
  
  attr_accessor :name, :age, :height
  attr_mass_assignable! :name, :age
end

person = ParanoidPerson.new
person.attributes = { :height => 77 }
# => Raises a RuntimeError
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
