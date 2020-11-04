### v0.20.0.pre

* features
  * Add support for statuses (`status_good`, `status_warning`, `status_danger` and `status_neutral`)

### v0.19.2.pre

* deprecations
  * Prevent loading `beyond_canvas/mailer` layout by default
  * No need to specify the model when generating the custom controller

* features
  * Add `text__align--left` and `text__align--right`
  * Add `beyond_canvas_controller?` method that returns `true` if the controller is a `BeyondCanvas` controller

### v0.19.1.pre

* bug-fixes
  * Fix menu display for vertical align
  * Fix block comment on menu generator template

* features
  * Add `margin--clear` class for removing all margins

### v0.19.0.pre

* bug-fixes
  * Fix `menu__item--selected` condition

* features
  * Add support for `text_area` form tag
  * Add support for `select` form tag

### v0.18.0.pre

* features
  * Add basic grid styles
  * Add scrollbox styles
  * Add modal headline styles

### v0.17.0.pre

* bug-fixes
  * Minor CSS fixes on buttons, alignments...

* deprecations
  * Move back to rollupjs
  * Rename `menu` to `action_bar`

* features
  * Add cockpit-app development mode
  * Add `beyond_canvas/application` layout
  * Add support for modals
  * Add support for breadcrumbs
  * Add support for menu
  * Add support for titles
  * Add shop session
  * Add generator for custom menu

* enhancements
  * Update authentication flow to fit future SSO
  * Update locale switch location

### v0.16.2.pre

* enhancements
  * Add div id for wrapping flash partial

### v0.16.1.pre

* bug-fixes
  * Remove `!global` from Sass variable declarations (see: https://sass-lang.com/documentation/variables#shadowing)
  * Fix routes generation

### v0.16.0.pre

* features
  * Add shop authentication functionality
  * Add generators to create a model for authentication, controllers and views

### v0.15.3.pre

* bug-fixes
  * Add `URI.decode` on signature validation

### v0.15.2.pre

* bug-fixes
  * Make `showSpinner` `hideSpinner` `disableActionElements` `enableActionElements` `closeAlert` functions public

### v0.15.1.pre

* deprecations
  * Remove `jquery-ujs` dependency
  * Set bourbon dependency version to `~> 5.1`

* bug-fixes
  * Fix Add invalid binding for enabling buttons

* features
  * Add ESLint

### v0.15.0.pre

* features
  * Add support for `check_box` and `radio_button` form tags
  * Add support for containers
  * Add possibility to set `label: false` on form inputs

### v0.14.0.pre

* deprecations
  * `application.css` is no longer loaded by Beyond Canvas
  * Move stylesheets from `.sass` to `.scss`
  * Move partials from `.html.slim` to `.html.erb`
  * Deprecations on `BeyondCanvas` configuration file:
    * `:public_logo` is substituted by `:site_logo`

* features
  * Add support for both Webpacker and Sprockets
  * `BeyondCanvas` configuration:
    * Added support for `:favicon`
    * Added support for `:site_title`
    * Added the possibility to register stylesheets and javascripts

* enhancements
  * Remove Font Awesome dependency (now `.svg` icons are used)
  * Title is now taken from `BeyondCanvas` initializer

### v0.13.1.pre

* bug-fixes
  * Check the `HTTP_ACCEPT_LANGUAGE` header on `switch_locale` function to identify if the request comes from a browser or a server. If the request comes from a browser, use `I18n.default_locale`

### v0.13.0.pre

* bug-fixes
  * Remove `:file` from metaprogrammed fields
  * Add `text-overflow: ellipsis;` to `file_field` text to avoid line breaks

* removals
  * Remove not used `beyond_canvas_form_utils.rb` template initializer
  * Remove environment validation on `valid_signature?`

* features
  * Add `beyond_api` gem as dependency
  * Add a method (`validate_app_installation_request!`) to be called on the `before_action` of your app's main entry point. This method validates that the installation request comes from Beyond
  * Filter app installation parameters
  * Add `number_field` to form builder

* enhancements
  * Add a controller for the locale management and adapt the code to work with it
  * Add information comments to `lib/generators/templates/beyond_canvas.rb`

### v0.12.0.pre

* bug-fixes
  * Add styles to locale switch select input

* enhancements
  * Now selected locale is saved on `cookies` instead of `session`

### v0.11.2.pre

* bug-fixes
  * Add missing mailers partials

### v0.11.1.pre

* bug-fixes
  * Fix hide spinner

### v0.11.0.pre

* bug-fixes
  * Rename `app/assets/stylesheets/beyond_canvas/components/spinner.sass` to `app/assets/stylesheets/beyond_canvas/components/_spinner.sass`
  * Fix `:last-child` margin on `_markdown.sass`

* features
  * Add mailer layout
  * Add mailer text and button partials
  * Add mailer styles
  * Add `premailer-rails` as a dependency

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
