$:.unshift File.expand_path('../../lib', __FILE__)
require 'mass_assignable'
require 'minitest/autorun'
require 'shoulda-context'

class MassAssignableTest < Test::Unit::TestCase
  class Person
    include MassAssignable
    
    attr_accessor :name, :age, :height
    attr_mass_assignable :name, :age, :height
  end
  
  class BlankClass
    include MassAssignable
  end
  
  context ".attr_mass_assignable" do
    should "set mass assignable attributes" do
      assert_equal [:name, :age, :height], Person.mass_assignable_attributes
    end
  end
  
  context "#attributes=" do
    should "set attribute values" do
      person = Person.new
      person.attributes = { :name => "Derrick", :age => 24, :height => 77 }
      assert_equal "Derrick", person.name
      assert_equal 24, person.age
      assert_equal 77, person.height
    end
  end
end