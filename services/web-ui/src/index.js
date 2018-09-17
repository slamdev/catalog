import React from "react";
import ReactDOM from "react-dom";
import CssBaseline from "@material-ui/core/CssBaseline";
import ProductPageContainer from "./ProductPageContainer";

function App() {
    return (
        <CssBaseline>
            <ProductPageContainer/>
        </CssBaseline>
    );
}

ReactDOM.render(<App/>, document.getElementById("index"));
