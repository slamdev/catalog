import * as React from "react";
import ProductsPage from "./ProductsPage";

export default class ProductPageContainer extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            products: []
        };
    }

    componentDidMount() {
        fetch('http://localhost:8080/product')
            .then(response => response.json())
            .then(products => this.setState({products}));
    }

    render() {
        return <ProductsPage products={this.state.products}/>;
    }
}
