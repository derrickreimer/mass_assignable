module MassAssignable
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    # Internal: Flag determining whether to raise an exception when
    # you attempt to mass-assign attributes that are not allowed.
    attr_accessor :raise_on_invalid_mass_assignment
    
    # Internal: The Array of Symbols representing attributes that are
    # mass assignable. This property is defined by the attr_assignable
    # method.
    attr_writer :mass_assignable_attributes
    
    def mass_assignable_attributes
      @mass_assignable_attributes ||= []
    end
    
    # Public: Accepts a list of symbols representing instance methods
    # that allow mass-assignment.
    #
    # *attributes - An Array of symbols or strings.
    #
    # Returns nothing.
    def attr_mass_assignable(*attributes)
      self.raise_on_invalid_mass_assignment = false
      self.mass_assignable_attributes ||= []
      self.mass_assignable_attributes.push(*attributes)
    end
    
    # Public: Accepts a list of symbols representing instance methods
    # that allow mass-assignment and will raise an exception if
    # mass assignment is attempted for attributes not specified here.
    #
    # *attributes - An Array of symbols or strings.
    #
    # Returns nothing.
    def attr_mass_assignable!(*attributes)
      attr_mass_assignable(*attributes)
      self.raise_on_invalid_mass_assignment = true
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
    paranoid = self.class.raise_on_invalid_mass_assignment
    allowed = self.class.mass_assignable_attributes.map { |a| a.to_s }
    
    attribute_hash.each do |key, value|
      if allowed.include?(key.to_s)
        send(:"#{key}=", value)
      else
        raise(RuntimeError, "Mass assignment error") if paranoid
      end
    end
  end
end
