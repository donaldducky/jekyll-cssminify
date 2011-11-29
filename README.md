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

Instructions:
-------------

1. Put the CssMinify.rb plugin into your `<root>/_plugins` directory so Jekyll can load it

2. Put the css files you want to minify into a `<root>/css` folder

    root
      css
        normalize.css
        site.css
        mobile.css
        ...
      
3. In your layout file, link to the minified css file, /css/site.min.css:

`<link rel="stylesheet" href="/css/site.min.css">`

4. Compile your site `jekyll`

### Technical:

Reads all the css files in the css directory and creates a site.min.css into your site's destination directory.

For example:

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
          site.min.css

What this plugin does is equivalent to (using the above example):

`juicer merge -f css/style.css css/syntax.css -o _site/css/site.min.css`

### Note:

This plugin is in an early stage and put together quickly with my limited Ruby knowledge. If there are any suggestions or criticisms about the code, open up an issue :D

### TODO:

* there's an issue where `jekyll --server --auto` seems to constantly regenerate files, could be because of the hackery used to keep jekyll from blowing away the minified file (see: https://github.com/mojombo/jekyll/issues/268)
* make the pre-minified css location configurable
* have a nice way to include all the non-minified css, since it doesn't always have to be minifed
* make the minified location configurable
* option to use static file versioning (cache busters, feature supported by juicer)

