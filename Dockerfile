FROM maven:3-jdk-13-alpine as builder

WORKDIR /app

COPY ./pom.xml ./pom.xml
COPY ./src ./src

RUN mvn package

FROM openjdk:11

COPY --from=builder /app/target/orders-service-example-*.jar /target/orders-service-example.jar

EXPOSE 5000

CMD ["java", "-jar", "/target/orders-service-example.jar", "http://localhost:5002/", "http://localhost:5003/",  "http://localhost:5001/"]