DrupalGenerator
===============

Author and License
------------------

DrupalGenerator was created by James Andres.  DrupalGenerator is under the
GPL v3 license (http://www.gnu.org/licenses/gpl.html).


Requirements
------------

1. Ruby (sudo apt-get install ruby)
2. RDoc (sudo apt-get install rdoc)


Installation
------------

Place the script files somewhere sensible, examples:
 * /usr/local/DrupalGenerator
 * ~/bin/DrupalGenerator

Symlink the _generate_ command into a directory that is in $PATH, examples:
 * ln -s /usr/local/DrupalGenerator/generate /usr/local/bin/generate
 * ln -s ~/bin/DrupalGenerator/generate      ~/bin/generate


Usage and Options
-----------------

        generate [options] {profile|module|node_module} PATH

        -h, --help          Displays help message
        -v, --version       Display the version, then exit
        -q, --quiet         Output as little as possible, overrides verbose
        -V, --verbose       Verbose output
        -5, --drupal-5      Use Drupal 5 templates
        -6, --drupal-6      Use Drupal 6 templates, this is the default
        -y, --yes           Yes to all questions, ie: to overwrite files

