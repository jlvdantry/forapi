
const path = require('path');
var CopyWebpackPlugin = require('copy-webpack-plugin');
console.log('dirname'+__dirname);

module.exports = {
    entry: './src/javascript/index.js',
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
                        "style-loader",
                        "css-loader",
                        "sass-loader"
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
