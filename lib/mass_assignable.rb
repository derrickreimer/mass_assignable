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
  # attribute_hash - A Hash of attribute values with symbol keys.
  #
  # Returns nothing.
  def attributes=(attribute_hash)
    allowed = self.class.mass_assignable_attributes.map { |a| a.to_s }
    attribute_hash.each do |key, value|
      send(:"#{key}=", value) if allowed.include?(key.to_s)
    end
  end
end
