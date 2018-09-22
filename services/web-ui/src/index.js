import React from "react";
import ReactDOM from "react-dom";
import CssBaseline from "@material-ui/core/CssBaseline";
import Application from "./Application";

document.addEventListener('DOMContentLoaded', () => ReactDOM.render(
    <CssBaseline>
        <Application/>
    </CssBaseline>
    , document.getElementById("index"))
);
