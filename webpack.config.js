/* eslint-disable no-undef */
const path = require('path');
const webpack = require('webpack');
const BANNER = `
   Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/beyond_canvas/' and run \`yarn build\`

   //= require jquery3
   //= require_self
  `;

module.exports = {
  mode: 'production',
  entry: [
    './app/javascript/beyond_canvas/base.js',
    './app/javascript/beyond_canvas/initializers/functions.js',
  ],
  resolve: {
    extensions: ['.js'],
  },
  target: 'web',
  output: {
    filename: 'base.js',
    path: path.resolve(__dirname, 'app/assets/javascripts/beyond_canvas'),
    libraryTarget: 'global',
  },
  optimization: {
    minimize: false,
  },
  module: {
    rules: [
      {
        test: /\.m?js$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: 'babel-loader',
        },
      },
    ],
  },
  plugins: [
    new webpack.BannerPlugin({
      banner: BANNER,
    }),
  ],
  externals: {
    $: 'jquery',
    jQuery: 'jquery',
  },
};
