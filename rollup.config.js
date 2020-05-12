import resolve from "@rollup/plugin-node-resolve";
import commonjs from "@rollup/plugin-commonjs";
import babel from "@rollup/plugin-babel";
import { uglify } from "rollup-plugin-uglify";
import { stripIndent } from 'common-tags';

const uglifyOptions = {
  mangle: false,
  compress: false,
  output: {
    beautify: true,
    indent_level: 2,
    preamble: stripIndent`
      /*
       * Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/beyond_canvas/' and run \`yarn build\`
       */
      //= require jquery3
      //= require jquery_ujs
      //= require_self
    ` + '\n'
  }
}

export default {
  input: "app/javascript/beyond_canvas/base.js",
  output: {
    file: "app/assets/javascripts/beyond_canvas/base.js",
    format: "umd",
    name: "ActiveAdmin"
  },
  plugins: [
    resolve(),
    commonjs(),
    babel(),
    uglify(uglifyOptions),
  ],
  // Use client's yarn dependencies instead of bundling everything
  external: [
    'jquery',
    'jquery-ujs'
  ]
}
