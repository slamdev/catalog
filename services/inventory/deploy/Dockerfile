FROM openjdk:8-jre-alpine

EXPOSE 6565

ENTRYPOINT [ \
    "java", \
    "-XX:+UnlockExperimentalVMOptions", \
    "-XX:+UseCGroupMemoryLimitForHeap", \
    "-XX:MaxRAMFraction=1", \
    "-jar", \
    "/opt/app.jar" \
]

RUN wget -qO /usr/local/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v0.1.0-alpha.1/grpc_health_probe-linux-amd64 \
 && chmod +x /usr/local/bin/grpc_health_probe

COPY build/libs/*.jar /opt/app.jar
