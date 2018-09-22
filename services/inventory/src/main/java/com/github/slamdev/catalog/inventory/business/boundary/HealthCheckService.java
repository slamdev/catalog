package com.github.slamdev.catalog.inventory.business.boundary;

import io.grpc.health.v1.HealthCheckRequest;
import io.grpc.health.v1.HealthCheckResponse;
import io.grpc.health.v1.HealthGrpc;
import io.grpc.stub.StreamObserver;
import org.lognet.springboot.grpc.GRpcService;

import static io.grpc.health.v1.HealthCheckResponse.ServingStatus.SERVING;

@GRpcService
public class HealthCheckService extends HealthGrpc.HealthImplBase {

    @Override
    public void check(HealthCheckRequest request, StreamObserver<HealthCheckResponse> responseObserver) {
        HealthCheckResponse response = HealthCheckResponse.newBuilder()
                .setStatus(SERVING)
                .build();
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }
}
