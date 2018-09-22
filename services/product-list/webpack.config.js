const HtmlWebPackPlugin = require("html-webpack-plugin");
const ProtoWebpackPlugin = require("./proto-webpack-plugin");

const indexHtmlWebpackPlugin = new HtmlWebPackPlugin({
    filename: "./index.html",
    template: "./src/index.html",
    inject: false
});

const componentHtmlWebpackPlugin = new HtmlWebPackPlugin({
    filename: "./product-list.html",
    template: "./src/product-list.html",
    inject: false,
    chunks: ['main']
});

const protoWebpackPlugin = new ProtoWebpackPlugin({
    protoDir: "../../etc/proto",
    outputDir: "./src/proto"
});

module.exports = {
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: "babel-loader"
                }
            },
            {
                test: /\.css$/,
                use: [
                    {
                        loader: "style-loader"
                    },
                    {
                        loader: "css-loader",
                        options: {
                            modules: true,
                            importLoaders: 1,
                            localIdentName: "[name]_[local]_[hash:base64]",
                            sourceMap: true,
                            minimize: true
                        }
                    }
                ]
            }
        ]
    },
    plugins: [indexHtmlWebpackPlugin, componentHtmlWebpackPlugin, protoWebpackPlugin]
};
