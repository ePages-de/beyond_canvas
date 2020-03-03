# Beyond Canvas

![Gem Version](https://img.shields.io/gem/v/beyond_canvas?label=gem%20version)
![License](https://img.shields.io/github/license/ePages-de/beyond_canvas)

## Installation

1. Add this line to your application's Gemfile:

    ```ruby
    gem "beyond_canvas"
    ```

1. Then execute:

    ```bash
    $ bundle install
    ```

1. Restart your server and rename `application.css` to `application.scss` or `application.sass` (in case you prefer to use the `sass` syntax):

    ```bash
    $ mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
    ```

1. Delete _all_ Sprockets directives in `application.scss` (`require`, `require_tree` and `require_self`) and use Sass’s native `@import` instead ([Here's why?](https://content.pivotal.io/blog/structure-your-sass-files-with-import)).

1. Import Beyond Canvas at the beginning of `application.scss`. Any other styles must be imported after Beyond Canvas to avoid issues:

    ```scss
    @import 'beyond_canvas'
    ```

1. Add the following to `application.js`:

    ```js
    //= require beyond_canvas
    ```

1. Mount the engine in your routes file:

    ```ruby
    mount BeyondCanvas::Engine => "/<your-mounting-path>"
    ```

1. Run the generator:

    ```bash
    $ rails g beyond_canvas:install
    ```

    This will generate `config/initializers/beyond_canvas.rb` file, used for general Beyond Canvas configuration

## Style Customization

Beyond Canvas comes with _out-of-the-box_ styles to make your app look like as a Beyond integrated one. If you want to customize the gem styles, follow these instructions:

1. Run the custom style generator:

    ```bash
    $ rails g beyond_canvas:custom_styles
    ```

    This command will generate a file (`app/assets/stylesheets/_beyond_canvas_custom_styles.sass`) that contains all variables you can customize.

1. Import the custom styles **before** Beyond Canvas itself (to override the default styles) on `application.scss`:

    ```scss
    @import 'beyond_canvas_custom_styles'
    @import 'beyond_canvas'
    ```

## Documentation

TBD

## Contributing

Please see [CONTRIBUTING](https://github.com/ePages-de/beyond_canvas/blob/master/CONTRIBUTING.md).

## Changelog

Beyond Canvas's changelog is available [here](https://github.com/ePages-de/beyond_canvas/blob/master/CHANGELOG.md).

## License

beyond_canvas is Copyright © 2019 ePages GmbH. It is free software, and may be redistributed under the terms specified in the [LICENSE](https://github.com/ePages-de/beyond_canvas/blob/master/LICENSE) file.

## About ePages

As the largest independent provider of online shop software in Europe, ePages specialises in high-performance ecommerce solutions for small and medium-sized businesses.
Today, 100,000 companies in 70 countries operate professional online shops with ePages software in the cloud.

And we love open source software!
Check out our [other projects](https://github.com/ePages-de), or [become part of our team](https://developer.epages.com/devjobs/) and develop great ecommerce software with us!
