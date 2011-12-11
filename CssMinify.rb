module Jekyll
  MINIFIED_FILENAME = Time.new.strftime("%Y%m%d%H%M") + '.min.css'

  # use this as a workaround for getting cleaned up
  # reference: https://gist.github.com/920651
  class CssMinifyFile < StaticFile
    def write(dest)
      # do nothing
    end
  end

  # minify css files
  class CssMinifyGenerator < Generator
    safe true
    def generate(site)
      relative_dir = 'css'

      css_files = get_css_files(site, relative_dir)
      output_file = File.join(site.config['destination'], relative_dir, MINIFIED_FILENAME)
      minify_css(css_files, output_file)

      site.static_files << CssMinifyFile.new(site, site.source, relative_dir, MINIFIED_FILENAME)
    end

    # read the css dir for the css files to compile
    def get_css_files(site, relative_dir)
      # not sure if we need to do this, but keep track of the current dir
      pwd = Dir.pwd
      Dir.chdir(File.join(site.config['source'], relative_dir))
      # read css files
      css_files = Dir.glob('*.css').map{ |f| File.join(relative_dir, f) }
      Dir.chdir(pwd)

      return css_files
    end

    def minify_css(css_files, output_file)
      css_files = css_files.join(' ')
      juice_cmd = "juicer merge -f #{css_files} -o #{output_file}"
      puts juice_cmd
      system(juice_cmd)
    end
  end

  class CssMinifyLinkTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      MINIFIED_FILENAME
    end
  end
end

Liquid::Template.register_tag('minified_css_file', Jekyll::CssMinifyLinkTag)