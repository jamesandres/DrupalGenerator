#
# == Synopis
#   Drupal code generator for node modules.  Relies on the standard module
#   generator for execution.
#
# == Author
#   James Andres
#
# == Copyright
#   GPL Version 3

class ThemeGenerator

  def initialize(options, template_path, path)
    @options = options
    @template_path = template_path
    @path = path
  end

  def run
    # Use the generator helpers to loop over the templates directory
    # creating sub directories into @path as needed.
    genhelper = GeneratorHelper.new
    genhelper.do_generate('theme', @options, @template_path, @path)
  end

end