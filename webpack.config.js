
const path = require('path');
var CopyWebpackPlugin = require('copy-webpack-plugin');
console.log('dirname'+__dirname);
var webpack = require("webpack");

module.exports = {
    entry: [ 
             './src/javascript/index.js',
             './src/scss/app.scss'
           ],
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: 'bundle.js'
    },
    mode: 'development',
    watch:true,
   plugins: [
        new CopyWebpackPlugin([
            {from:'src/css',to:'css'} 
        ]), 
        new webpack.ProvidePlugin({
          $: require.resolve('jquery'),
          jQuery: require.resolve('jquery')
        })
    ],
    
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /(node_modules)/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['@babel/preset-env']
                    }
                }
            },
            {
                test: /\.(sa|sc|c)ss$/,
                use: [
                   { loader :      "style-loader", },
                   { loader :      "css-loader", },
{
      loader: 'postcss-loader', // Run post css actions
      options: {
        plugins: function () { // post css plugins, can be exported to postcss.config.js
          return [
            require('precss'),
            require('autoprefixer')
          ];
        }
      }
    },
                   { loader :      "sass-loader" }
                ]
            },
            {
                test: /\.(png|jpe?g|gif|svg)$/,
                use: [
                    {
                        loader: "file-loader",
                        options: {
                            name: '[name].[ext]',
                            outputPath: 'img/',
                            publicPath: 'dist/img/'
                        }
                    }
                ]
            },

            {
                test: /\.(woff|woff2|ttf|otf|eot)$/,
                use: [
                    {
                        loader: "file-loader",
                        options: {
                            name: '[name].[ext]',
                            outputPath: 'fonts',
                            publicPath: 'dist/fonts/'
                        }
                    }
                ]
            }
        ]
    },
    
};
