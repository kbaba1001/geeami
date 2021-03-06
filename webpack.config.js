var path = require("path"),
    StatsPlugin = require("stats-webpack-plugin");

var devServerPort = process.env.WEBPACK_DEV_SERVER_PORT,
    devServerHost = process.env.WEBPACK_DEV_SERVER_HOST,
    publicPath = process.env.WEBPACK_PUBLIC_PATH;

var config = {
  context: path.resolve(__dirname, "apps/web/assets/source"),
  entry: "./index.js",
  output: {
    path: path.join(__dirname, "public/assets"),
    publicPath: publicPath,
    filename: "[name]-[chunkhash].js"
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          loaders: {
            // Since sass-loader (weirdly) has SCSS as its default parse mode, we map
            // the "scss" and "sass" values for the lang attribute to the right configs here.
            // other preprocessors should work out of the box, no loader config like this necessary.
            'scss': 'vue-style-loader!css-loader!sass-loader',
            'sass': 'vue-style-loader!css-loader!sass-loader?indentedSyntax'
          }
          // other vue-loader options go here
        }
      },
      {
        include: path.resolve(__dirname, "apps/web/assets/source"),
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /node_modules/
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        loader: 'file-loader',
        options: {
          name: '[name].[ext]'
          // ?[hash]
        }
      }
    ]
  },
  resolve: {
    alias: { 'vue$': 'vue/dist/vue.runtime.esm.js' }
  },
  plugins: [
    new StatsPlugin("webpack_manifest.json")
  ]
};

module.exports = config;
