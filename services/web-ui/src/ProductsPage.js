import React from "react";
import PropTypes from "prop-types";
import Button from "@material-ui/core/Button/Button";
import AppBar from "@material-ui/core/AppBar/AppBar";
import Toolbar from "@material-ui/core/Toolbar/Toolbar";
import Typography from "@material-ui/core/Typography/Typography";
import {withStyles} from "@material-ui/core/styles";
import Grid from "@material-ui/core/Grid/Grid";
import Card from "@material-ui/core/Card/Card";
import CardHeader from "@material-ui/core/CardHeader/CardHeader";
import CardActions from "@material-ui/core/CardActions/CardActions";
import CardContent from "@material-ui/core/CardContent/CardContent";
import CardMedia from "@material-ui/core/CardMedia/CardMedia";

const styles = theme => ({
    grow: {
        flexGrow: 1
    },
    layout: {
        width: 'auto',
        marginLeft: theme.spacing.unit * 3,
        marginRight: theme.spacing.unit * 3
    },
    media: {
        width: 128
    }
});

const ProductsPage = ({classes, products}) => {
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
            <main className={classes.layout}>
                <Grid container={true} spacing={40} alignItems="flex-end">
                    <Grid item={true} xs={12}>
                        <Typography variant={"display3"} align={"center"} color={"textPrimary"}>Products</Typography>
                    </Grid>
                    {products.map(product => (
                        <Grid key={product.id} item={true} xs={12} sm={6} md={4}>
                            <Card>
                                <CardMedia className={classes.media} image={product.imageUrl}
                                           component={"img"} title={product.name}/>
                                <CardHeader title={product.name} titleTypographyProps={{align: 'center'}}/>
                                <CardContent>
                                    <Typography>{product.description}</Typography>
                                </CardContent>
                                <CardActions>
                                    <Button fullWidth color={"primary"}>Add to favorites</Button>
                                </CardActions>
                            </Card>
                        </Grid>
                    ))}
                </Grid>
            </main>
        </React.Fragment>
    );
};

ProductsPage.propTypes = {
    classes: PropTypes.object.isRequired,
    products: PropTypes.arrayOf(PropTypes.object).isRequired
};

export default withStyles(styles)(ProductsPage);
