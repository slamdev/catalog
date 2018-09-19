package com.github.slamdev.catalog.inventory.business.boundary;

import com.github.slamdev.catalog.inventory.api.InventoryGrpc;
import com.github.slamdev.catalog.inventory.api.InventoryOuterClass.Product;
import com.google.protobuf.Empty;
import io.grpc.stub.StreamObserver;
import org.lognet.springboot.grpc.GRpcService;

import java.util.List;
import java.util.stream.IntStream;

import static com.github.slamdev.catalog.inventory.api.InventoryOuterClass.ProductsResponse;
import static java.util.stream.Collectors.toList;

@GRpcService
public class InventoryService extends InventoryGrpc.InventoryImplBase {

    public void getProducts(Empty request, StreamObserver<ProductsResponse> responseObserver) {
        List<Product> products = IntStream.range(0, 20)
                .mapToObj(i -> Product.newBuilder()
                        .setId(i)
                        .setName("Product #" + i)
                        .setDescription("Description #" + i)
                        .setImageUrl("https://developers.chrome.com/extensions/examples/api/idle/idle_simple/sample-128.png")
                        .build())
                .collect(toList());
        ProductsResponse response = ProductsResponse.newBuilder()
                .addAllProducts(products)
                .build();
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }
}
