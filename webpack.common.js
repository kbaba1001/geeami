var path = require("path");
var webpack = require('webpack');

module.exports = {
  context: path.resolve(__dirname, "apps/web/assets/source"),
  entry: "./index.js",
  output: {
    path: path.resolve(__dirname, "apps/web/assets/javascripts/"),
    filename: "build.js"
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        include: path.resolve(__dirname, "apps/web/assets/source"),
        loader: "babel-loader"
      }
    ]
  },
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify('production')
      }
    })
  ],
  devtool: "inline-source-map"
};
