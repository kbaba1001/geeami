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
      },
      {
        test: /\.styl$/,
        loader: ['style-loader', 'css-loader', 'stylus-loader']
      }
    ]
  },
  resolve: {
    alias: { 'vue$': 'vue/dist/vue.runtime.esm.js' }
  },
  plugins: [
    new StatsPlugin("webpack_manifest.json")
  ],
  devtool: '#eval-source-map'
};

module.exports = config;
