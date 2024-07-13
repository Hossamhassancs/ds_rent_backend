# config/initializers/parameters.rb
ActionController::Parameters.include(Module.new do
    def slice(*keys)
      keys.map! { |key| convert_key(key) } if respond_to?(:convert_key)
      self.class.new(select { |key, _| keys.include?(key) })
    end
  end)
  