import React from "react";
import PropTypes from "prop-types";
import Button from "@material-ui/core/Button/Button";
import Typography from "@material-ui/core/Typography/Typography";
import {withStyles} from "@material-ui/core/styles";
import Grid from "@material-ui/core/Grid/Grid";
import Card from "@material-ui/core/Card/Card";
import CardHeader from "@material-ui/core/CardHeader/CardHeader";
import CardActions from "@material-ui/core/CardActions/CardActions";
import CardContent from "@material-ui/core/CardContent/CardContent";
import CardMedia from "@material-ui/core/CardMedia/CardMedia";

const styles = theme => ({
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
            <main className={classes.layout}>
                <Grid container={true} spacing={40} alignItems="flex-end">
                    <Grid item={true} xs={12}>
                        <Typography variant={"display3"} align={"center"} color={"textPrimary"}>Products</Typography>
                    </Grid>
                    {products.map(product => (
                        <Grid key={product.getId()} item={true} xs={12} sm={6} md={4}>
                            <Card>
                                <CardMedia className={classes.media} image={product.getImageurl()}
                                           component={"img"} title={product.name}/>
                                <CardHeader title={product.getName()} titleTypographyProps={{align: 'center'}}/>
                                <CardContent>
                                    <Typography>{product.getDescription()}</Typography>
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
