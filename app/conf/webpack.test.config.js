const webpack = require('webpack')
const { VueLoaderPlugin } = require('vue-loader')
const PermissionsOutputPlugin = require('webpack-permissions-plugin')
const path = require('path')
const nodeEnv = process.env.NODE_ENV || 'production'

module.exports = {
  mode: 'development',
  devtool: 'inline-cheap-module-source-map',
  entry: './src/js/main.js',
  output: {
    path: path.resolve(__dirname, '../public/dist'),
    filename: 'bundle.js',
    libraryTarget: 'var',
    library: 'Asesora'
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader',
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.css$/,
        use: [
          'vue-style-loader',
          'css-loader'
        ]
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
    new VueLoaderPlugin(),
    new webpack.EnvironmentPlugin({
      'API_HOST': 'localhost',
      'API_PORT': '4567'
    }),
    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify(nodeEnv) }
    }),
    new PermissionsOutputPlugin({
      buildFolders: [
        {
          path: path.resolve(__dirname, '../public/dist/'),
          fileMode: '777',
          dirMode: '666'
        }
      ],
      buildFiles: [
        {
          path: path.resolve(__dirname, '../public/dist/bundle.js'),
          fileMode: '777'
        }
      ]
    })
  ]
}
