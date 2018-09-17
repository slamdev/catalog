FROM openjdk:8-jre-alpine

EXPOSE 8080

ENTRYPOINT [ \
    "java", \
    "-XX:+UnlockExperimentalVMOptions", \
    "-XX:+UseCGroupMemoryLimitForHeap", \
    "-XX:MaxRAMFraction=1", \
    "-jar", \
    "/opt/app.jar" \
]

COPY build/libs/*.jar /opt/app.jar
