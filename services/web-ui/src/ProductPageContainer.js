import * as React from "react";
import ProductsPage from "./ProductsPage";

import {Empty} from "./proto/google/protobuf/empty_pb"
import {InventoryPromiseClient} from "./proto/inventory_grpc_web_pb"

export default class ProductPageContainer extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            products: []
        };
    }

    componentDidMount() {
        const client = new InventoryPromiseClient('http://localhost:18080', null, null);
        client.getProducts(new Empty(), {})
            .then(response => response.getProductsList())
            .then(products => this.setState({products}))
            .catch(error => console.error(error));
    }

    render() {
        return <ProductsPage products={this.state.products}/>;
    }
}
