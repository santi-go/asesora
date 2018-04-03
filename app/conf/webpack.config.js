const webpack = require('webpack')
const PermissionsOutputPlugin = require('webpack-permissions-plugin')
const path = require('path')
const nodeEnv = process.env.NODE_ENV || 'production'

module.exports = {
  devtool: 'source-map',
  entry: {
    filename: './src/js/main.js'
  },
  output: {
    filename: './dist/bundle.js'
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015-native-modules']
        }
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      }
    ]
  },
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    },
    extensions: ['*', '.js', '.vue', '.json']
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      },
      output: {
        comments: false
      },
      sourceMap: true
    }),
    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify(nodeEnv) }
    }),
    new PermissionsOutputPlugin({
      buildFolders: [
        {
          path: path.resolve(__dirname, '../dist/'),
          fileMode: '777',
          dirMode: '666'
        }
      ],
      buildFiles: [
        {
          path: path.resolve(__dirname, '../dist/bundle.js'),
          fileMode: '777'
        }
      ]
    })
  ]
}
