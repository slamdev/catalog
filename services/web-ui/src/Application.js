import React from "react";
import PropTypes from "prop-types";
import Button from "@material-ui/core/Button/Button";
import AppBar from "@material-ui/core/AppBar/AppBar";
import Toolbar from "@material-ui/core/Toolbar/Toolbar";
import Typography from "@material-ui/core/Typography/Typography";
import {withStyles} from "@material-ui/core/styles";

const styles = () => ({
    grow: {
        flexGrow: 1
    },
});

const Application = ({classes}) => {
    return (
        <React.Fragment>
            <AppBar position={"static"} color={"default"}>
                <Toolbar>
                    <Typography variant={"title"} color={"inherit"} className={classes.grow}>Catalog</Typography>
                    <Button color={"primary"}>Products</Button>
                    <Button>Favorites</Button>
                    <Button>Register</Button>
                    <Button>Login</Button>
                </Toolbar>
            </AppBar>
            <product-list/>
        </React.Fragment>
    );
};

Application.propTypes = {
    classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(Application);
