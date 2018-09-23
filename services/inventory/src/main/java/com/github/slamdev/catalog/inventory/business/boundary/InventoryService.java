package com.github.slamdev.catalog.inventory.business.boundary;

import com.github.slamdev.catalog.inventory.api.InventoryGrpc;
import com.github.slamdev.catalog.inventory.api.InventoryOuterClass;
import com.github.slamdev.catalog.inventory.business.control.ProductRepository;
import com.github.slamdev.catalog.inventory.business.entity.Product;
import com.google.protobuf.Empty;
import io.grpc.stub.StreamObserver;
import lombok.RequiredArgsConstructor;
import org.lognet.springboot.grpc.GRpcService;

import java.util.List;

import static com.github.slamdev.catalog.inventory.api.InventoryOuterClass.ProductsResponse;
import static java.util.stream.Collectors.toList;

@GRpcService
@RequiredArgsConstructor
public class InventoryService extends InventoryGrpc.InventoryImplBase {

    private final ProductRepository productRepository;

    @Override
    public void getProducts(Empty request, StreamObserver<ProductsResponse> responseObserver) {
        List<Product> products = productRepository.findAll();
        ProductsResponse response = ProductsResponse.newBuilder()
                .addAllProducts(products.stream().map(this::toProductDto).collect(toList()))
                .build();
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }

    private InventoryOuterClass.Product toProductDto(Product product) {
        return InventoryOuterClass.Product.newBuilder()
                .setId(product.getId().toString())
                .setName(product.getName())
                .setDescription(product.getDescription())
                .setImageUrl(product.getImageUrl())
                .build();
    }
}
