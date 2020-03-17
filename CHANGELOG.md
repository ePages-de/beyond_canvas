### v0.10.0.pre

* bug-fixes
  * Fix locale switch functionality

* enhancements
  * Improve `notice_success`, `notice_info`, `notice_warning` and `notice_error` styles

* features
  * Add title display functionality
  * Add styles for `file_field`

### v0.9.0.pre

* enhancements
  * Make javascripts work with turbolinks

* features
  * Add `.markdown` class for styling `.md` content
  * Add text align class

### v0.8.1.pre

* bug-fixes
  * Prevent calling 2 times `set_locale` method
  * Fix `http/accept` requirement

### v0.8.0.pre

* deprecations
  * Remove form builder generator

* features
  * Make `beyond_canvas` work as a Rails engine
  * Add locale switch functionality
  * Add form builder initializer
  * Add rubocop

### v0.7.0.pre

* deprecations
  * Use custom `stylesheet_link_tag` and `javascript_include_tag` on head

* enhancements
  * Make `lib/generators/templates/beyond_canvas_form_utils.rb` rubocop compatible

* features
  * Add loading buttons

### v0.6.4.pre

* bug-fixes
  * Fix requiting to create the `_head.html.*` on the project instead of the gem itself

### v0.6.3.pre

* bug-fixes
  * Add `slim-rails` dependency
  * Fix requiring dependencies on `Engine`

* deprecations
  * Remove `neat` dependency as is no longer maintained

### v0.6.2.pre

* bug-fixes
  * Fix button `border-color`
  * Fix error-input's `border-color`

* deprecations
  * Update error-input's class to `.input__error`

### v0.6.1.pre

* bug-fixes
  * Fix `logo_image_tag`

### v0.6.0.pre

* deprecations
  * Rename `notice` flash types in favor of `info` flash types
  * Rename `beyond_canvas:form_utils:install` rake task in favor of `beyond_canvas:install`

* bug-fixes
  * Fix `p` tag `font-size` and change `rem` to `px` on typography
  * Fix button styles

* enhancements
  * Update how the public layout logo is handled. Now the logo is set via `config/initializers/beyond_canvas.rb` initializer and it also supports web URLs

* features
  * Add notice boxes
  * Add custom styles generator
  * Add a rake task (`beyond_canvas:release:prepare`) that creates or updates the `beyond_canvas_custom_styles.sass` generator template

### v0.5.0.pre

* features
  * Add select box styles

### v0.4.0.pre

* bug-fixes
  * Fix transparent button bottom border
  * Fix list styles

* features
  * Add table styles
  * Add comment styles
  * Add margin styles
  * Add input type file

### v0.3.0.pre

* features
  * Add flash messages
  * Add CHANGELOG file
  * Add CONTRIBUTING file
  * Add Rakefile

### v0.2.1.pre

* bug-fixes
  * Fix headline margin on card
  * Fix gem name

### v0.2.0.pre

* features
  * Add Beyond form utils
  * Add single page layout
  * Add lins with icons
  * Add FontAwesome
  * Add input errors

* enhancements
  * Improve styles

### v0.1.0.pre

* features
  * First pre-release of the gem
