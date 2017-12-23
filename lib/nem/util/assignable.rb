module Nem
  module Util
    module Assignable
      def initialize(attributes = {})
        attributes.each do |k, v|
          send("#{k.to_s}=", v) if respond_to?("#{k.to_s}=")
        end if attributes
        yield self if block_given?
      end

      # @param [Symbol, String] attr Attribute name
      # @return [Any] Attribute value
      def [](attr)
        send(attr)
      end

      # @return [Hash] Attribute and value pairs
      def to_hash
        hashed_properties = instance_variables.each_with_object({}) do |var, hash|
          hash[var.to_s.delete('@').to_sym] = instance_variable_get(var)
        end
        hashnize(hashed_properties)
      end

      # @return [String] JSON formatted structure
      def to_json(state = nil)
        to_hash.to_json(state)
      end

      private

      def hashnize(obj)
        case true
        when obj.class.to_s.start_with?('Nem::Unit')
          obj.to_s
        when obj.class.to_s.start_with?('Nem::Struct')
          obj.to_hash
        when obj.is_a?(Array)
          obj.map { |el| hashnize(el) }
        when obj.is_a?(Hash)
          obj.inject({}) do |hash, (k, v)|
            hash[k] = hashnize(v)
            hash
          end
        else
          obj
        end
      end
    end
  end
end