#
# == Synopis
#   Drupal code generator for modules.
#
# == Author
#   James Andres
#
# == Copyright
#   GPL Version 3

class ModuleGenerator

  def initialize(options, template_path, path)
    @options = options
    @template_path = template_path
    @path = path
  end

  def run
    # Use the generator helpers to loop over the templates directory
    # creating sub directories into @path as needed.
    genhelper = GeneratorHelper.new
    genhelper.do_generate('module', @options, @template_path, @path)
  end
end