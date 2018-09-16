import React from "react";
import ReactDOM from "react-dom";
import CssBaseline from "@material-ui/core/CssBaseline";
import ProductsPage from "./productsPage";

function App() {
    return (
        <CssBaseline>
            <ProductsPage/>
        </CssBaseline>
    );
}

ReactDOM.render(<App/>, document.getElementById("index"));
