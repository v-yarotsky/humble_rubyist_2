module HumbleRubyist

  class TemplateStorage
    def initialize(templates_path)
      @templates_path = templates_path
    end

    def retrieve_template(template_name)
      template_filename = File.join(@templates_path, template_name + ".erb")
      File.read(template_filename)
    end
  end

end

