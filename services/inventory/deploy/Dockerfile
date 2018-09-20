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

COPY build/libs/*.jar /opt/app.jar
