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
  
  class Car
    include MassAssignable
    
    attr_mass_assignable :make
    attr_mass_assignable :model
  end
  
  class BlankClass
    include MassAssignable
  end
  
  class NothingAssignable
    include MassAssignable
    attr_mass_assignable
  end
  
  class ParanoidNothingAssignable
    include MassAssignable
    attr_mass_assignable!
  end
  
  class ProtectedAttributes
    include MassAssignable
    
    attr_accessor :name, :age, :height
    attr_mass_assignable :name
  end
  
  class ParanoidPerson
    include MassAssignable
    
    attr_accessor :name, :age, :height
    attr_mass_assignable! :name, :age, :height
  end
  
  context ".attr_mass_assignable" do
    should "set mass assignable attributes" do
      assert_equal [:name, :age, :height], Person.mass_assignable_attributes
    end
    
    should "set mass assignable attribute to an empty array if not called" do
      assert BlankClass.mass_assignable_attributes.is_a?(Array)
      assert BlankClass.mass_assignable_attributes.empty?
    end
    
    should "set mass assignable attribute to an empty array if no arguments given" do
      assert NothingAssignable.mass_assignable_attributes.is_a?(Array)
      assert NothingAssignable.mass_assignable_attributes.empty?
    end
    
    should "append attributes on multiple calls" do
      assert Car.mass_assignable_attributes.include?(:make)
      assert Car.mass_assignable_attributes.include?(:model)
    end
    
    should "not raise an exception for invalid mass assignment attempts" do
      person = Person.new
      person.attributes = { :gender => "male" }
    end
  end
  
  context ".attr_mass_assignable!" do
    should "set mass assignable attributes" do
      assert_equal [:name, :age, :height], ParanoidPerson.mass_assignable_attributes
    end
    
    should "set mass assignable attribute to an empty array if no arguments given" do
      assert ParanoidNothingAssignable.mass_assignable_attributes.is_a?(Array)
      assert ParanoidNothingAssignable.mass_assignable_attributes.empty?
    end
    
    should "raise an exception for invalid mass assignment attempts" do
      assert_raises(RuntimeError) do
        person = ParanoidPerson.new
        person.attributes = { :gender => "male" }
      end
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
    
    should "not overwrite unspecified attributes" do
      original_attr = { :name => "Derrick" }
      new_attr = { :age => 24, :height => 77 }
      person = Person.new
      person.attributes = original_attr
      person.attributes = new_attr
      
      assert_equal "Derrick", person.name
      assert_equal 24, person.age
      assert_equal 77, person.height
    end
  end
end