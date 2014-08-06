module HumbleRubyist

  class Styleguide < View
    def initialize(template_content, example_template_content, styleguide, template_values = {})
      super(template_content, template_values)
      @_example_template_content = example_template_content
      @_styleguide = styleguide
    end

    private # helpers

    def styleguide_block(section, &block)
      section = @_styleguide.section(section)
      example_html = capture(&block)
      @_result << View.new(@_example_template_content,
                           section: section,
                           example_html: example_html).render
    end
  end

end


