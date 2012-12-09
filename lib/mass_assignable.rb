require "mass_assignable/version"

module MassAssignable
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def attr_assignable(*attributes)
      @mass_assignable_attributes = attributes
    end
    
    def mass_assignable_attributes
      @mass_assignable_attributes
    end
  end
  
  # Public: Assigns a Hash of attributes to their corresponding
  # instance methods. If attributes are specified with attr_assignable,
  # then only those attributes are allowed to be assigned.
  #
  # attribute_hash - A Hash of attribute values.
  #
  # Returns nothing.
  def attributes=(attribute_hash)
    
  end
end
