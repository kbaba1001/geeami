var path = require("path");
module.exports = {
  context: path.resolve(__dirname, "apps/web/assets/source"),
  entry: "./index.js",
  output: {
    path: path.resolve(__dirname, "apps/web/assets/javascripts/"),
    filename: "output.js"
  },
  devtool: "inline-source-map"
};
