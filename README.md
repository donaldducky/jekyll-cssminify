CssMinify
=========

Generates minified CSS using the [juicer gem](http://cjohansen.no/en/ruby/juicer_a_css_and_javascript_packaging_tool) for use with the static site generator [Jekyll](http://jekyllrb.com).
It's basically a wrapper for juicer that is called automatically when the site is compiled.

This came about when I wanted to minify some CSS but couldn't find any way to automatically do it, using Jekyll.
I did a few quick searches for a plugin or liquid filter, but came up with nil.

Here is my quick solution.

### Requires:

* [jekyll](https://github.com/mojombo/jekyll) `gem install jekyll`
* [juicer](https://github.com/cjohansen/juicer) `gem install juicer`

# Installation

1. Place the CssMinify.rb plugin into your `<root>/_plugins` directory so that Jekyll can load it
2. Create a new path `<root>/css`.
3. Follow the Usage instructions below.
4. Compile your site with `jekyll`

# Usage

## Specifying source files

The simplest way of specifying source files for minification is to place them all into a `<root>/css` folder

    root
      css
        normalize.css
        site.css
        mobile.css
        ...

Alternatively, you can create a configuration called 'CssMinify.yml' in your `<root>` directory. In this configuration file you can use the following syntax to list source files:

    files: [
      'css/reset.css',
      'css/file1.css',
      'other-folder/file2.css'
    ]

Note that this second method also allows you to specify the order in which files should be added to the output. This is especially handy if you want to make sure that your reset file is always first.
   
## Updating your HTML files

As the filename for the generated CSS output changes each time, you need to update your layout file. Simply, link to the minified css file by using the parameter {% minified_css_file %}:

`<link rel="stylesheet" href="{% minified_css_file %}">`

## Specifying an alternative output destination

If, for whatever reason, you wish to override the default output location for your generated, minified file. Create a configuration called 'CssMinify.yml' in your `<root>` directory. In this configuration file you can use the following syntax to set a destination directory (relative to the Jekyll site output directory):

`css_destination: '/alternative_location/css/'`

# Overview

Reads all the css files in the css directory or CssMinify.yml configuration file and creates a single, minified file into your site's destination directory (unless overridden in the configuration file). 

The file name is based on the current date and time, in order to ensure that any updates are automatically cache-busted.

Using the default settings, for example:

    root
      _layouts
      _plugins
        CssMinify.rb
      _posts
      css
        style.css
        syntax.css

When the site is compiled using jekyll, the minified css file will be in the css folder of your site's destination directory.

    root
      _site
        css
          201112111214.min.css

What this plugin does is equivalent to (using the above example):

`juicer merge -f css/style.css css/syntax.css -o _site/css/site.min.css`

# TODO

This plugin is in an early stage and put together quickly with my limited Ruby knowledge. If there are any suggestions or criticisms about the code, open up an issue :D

* there's an issue where `jekyll --server --auto` seems to constantly regenerate files, could be because of the hackery used to keep jekyll from blowing away the minified file (see: https://github.com/mojombo/jekyll/issues/268)
* have a nice way to include all the non-minified css, since it doesn't always have to be minifed

