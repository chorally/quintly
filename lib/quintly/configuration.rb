module Quintly
  class Configuration
    ATTRIBUTES = [
      :username,
      :password
    ]

    ATTRIBUTES.each { |attribute| attr_accessor attribute }

    def initialize
      yield self if block_given?
    end

    def valid?
      ATTRIBUTES.each do |attribute|
        return false if self.send(attribute).nil? || self.send(attribute).empty?
      end
      true
    end
  end
end
