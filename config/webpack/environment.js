const { environment } = require('@rails/webpacker')
const path = require('path')

const webpack = require('webpack')


environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    "window.$": "jquery",
    "window.jQuery": "jquery",
    Popper: ['popper.js', 'default']
  }),
);
environment.config.merge({
  module: {
    rules: [
      {
        test: require.resolve("jquery"),
        use: [
          {
            loader: "expose-loader",
            options: "jQuery"
          },
          {
            loader: "expose-loader",
            options: "$"
          }
        ]
      },
    ]
  }
})

module.exports = environment