#
# == Synopis
#   Drupal code generator for modules.
#
# == Author
#   James Andres
#
# == Copyright
#   GPL Version 3

class GeneratorHelper

  attr_accessor :template_path

  def initialize()
    @template_path = nil
    @ignorables = ['.', '..', '.svn', 'CVS']
  end

  # A basic generator template, works in most scenarios
  def do_generate(type, options, template_path, path, title = nil)
    title ||= File.split(path).last

    replacements = {
      '%title%' => title,
      # Replace - and _ with spaces and title-case
      '%Title%' => title.gsub(/[-_]/, ' ').split(/\s+/).each{ |word|
        word.capitalize!
      }.join(' '),
      '%TITLE%' => title.upcase,
    }
    replacements['%TiTlE%'] = replacements['%Title%'].gsub(' ', '')
    replacements['%Title0%'] = replacements['%Title%'].split(' ').first

    puts "Generating #{type} '#{title}' ..." if !options['quiet']

    FileUtils.mkdir_p path

    puts "Processing templates ... \n\n" if options['verbose']

    # Use the generator helpers to loop over the templates directory
    # creating sub directories into path as needed.
    self.each_template(template_path, path) do |item, type, depth|
      rel_item = self.get_item_relative_path item

      # Get the destination, replacing any placeholders as necessary.
      dest_item = self.replace_lots(path + '/' + rel_item, replacements)

      # Only need to handle files, directories are created by the
      # GeneratorHelper since we pased the destination path argument, path.
      if type == 'file'
        template = self.load_template_and_replace(item, replacements)

        confirm = true if options['yes_to_all']
        # TODO: Tersify this.
        if !confirm && FileTest.file?(dest_item)
          confirm = self.confirm_replace dest_item
        else
          confirm = true
        end

        # Only write the file if it isn't going to cause damage, or the user
        # consented to the damage.
        open(dest_item, 'w') { |f| f << template } if confirm
      end

      puts "  " + ".." * depth + " " + dest_item if options['verbose']      
    end
  end

  # Recurses over a template path yielding to a code block on every item
  # found.  Can also be configured to automatically create found directories.
  #
  def each_template(template_path, dest_path = FALSE, depth = 1, &block)
    false if FileTest.directory?(template_path)

    @template_path = template_path if @template_path.nil?

    Dir.open(template_path) { |d|
      d.each { |item|
        # Always skip . and ..
        next if @ignorables.include?(item)

        item = template_path + '/' + item
        item_rel = get_item_relative_path(item)

        if FileTest.file?(item)
          block.call(item, 'file', depth)
        elsif FileTest.directory?(item)
          # If the destination path is set attempt to create the item
          # in the directory path
          if !dest_path.nil? && dest_path != FALSE
            FileUtils.mkdir_p dest_path + '/' + item_rel
          # else
          end

          block.call(item, 'dir', depth)

          # Recurse into the found directory
          each_template(item, dest_path, depth + 1, &block)
        end
      }
    }
  end

  # Returns the relative path to item, assuming @template_path is set.
  def get_item_relative_path(item)
    item.sub(@template_path + '/', '')
  end

  # Find and replace all
  def load_template_and_replace(template_file, replacements)
    template = open(template_file) { |f| f.read }
    template = replace_lots(template, replacements)
  end

  # Based on a hash, replaces a whole bunch of things in a string.
  def replace_lots(string, replacements)
    replacements.each_pair { |from, to|
      string.gsub!(from, to)
    }
    string
  end

  # Confirmation if a file should be replaced.
  def confirm_replace(file)
    input = ''

    puts "Overwrite possibly modified file? '#{file}'"

    while !input[/^[YN]$/]
      print "[Y]es/[N]o: "
      input = $stdin.gets.strip.upcase
    end

    true if input == 'Y'
  end

end
