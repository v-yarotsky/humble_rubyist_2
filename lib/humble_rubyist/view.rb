require "erb"

module HumbleRubyist

  class View
    def initialize(template_content, template_values)
      @_template_content, @_template_values = template_content, template_values
    end

    def render
      @_template_values.each { |k, v| instance_variable_set("@#{k.to_sym}", v) }
      ERB.new(@_template_content, 0, "%<>-", "@_result").result(binding)
      @_result
    end
  end

end

