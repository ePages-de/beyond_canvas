import babel from '@rollup/plugin-babel';
import commonjs from '@rollup/plugin-commonjs';
import resolve from '@rollup/plugin-node-resolve';
import { stripIndent } from 'common-tags';
import { uglify } from 'rollup-plugin-uglify';

const uglifyOptions = {
  mangle: false,
  compress: false,
  output: {
    beautify: true,
    indent_level: 2,
    preamble:
      stripIndent`
      /*
       * Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/beyond_canvas/' and run \`yarn build\`
       */
      //= require jquery3
      //= require rails-ujs
      //= require beyond_canvas/commonFunctions
      //= require_self
    ` + '\n',
  },
};

export default [
  {
    input: 'app/javascript/beyond_canvas/base.js',
    output: {
      file: 'app/assets/javascripts/beyond_canvas/base.js',
      format: 'umd',
      name: 'BeyondCanvas',
    },
    plugins: [
      resolve(),
      commonjs(),
      babel(),
      uglify(uglifyOptions)
    ],
    // Use client's yarn dependencies instead of bundling everything
    external: [
      'jquery'
    ]
  },
  {
    input: 'app/javascript/beyond_canvas/lib/commonFunctions.js',
    output: {
      file: 'app/assets/javascripts/beyond_canvas/commonFunctions.js',
      format: 'iife',
      name: 'bc',
    },
    plugins: [
      resolve(),
      babel()
    ],
  }
];
