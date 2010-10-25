#
# == Synopis
#   Drupal code generator for profiles.
#
# == Author
#   James Andres
#
# == Copyright
#   GPL Version 3

class ProfileGenerator

  def initialize(options, template_path, path)
    @options = options
    @template_path = template_path
    @path = path
  end

  def run
    # Use the generator helpers to loop over the templates directory
    # creating sub directories into @path as needed.
    genhelper = GeneratorHelper.new
    genhelper.do_generate('profile', @options, @template_path, @path)
  end
end