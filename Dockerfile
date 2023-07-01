FROM maven:3-jdk-13-alpine as builder

ARG PAYMENTS_URL
ARG SHIPPING_URL
ARG PRODUCTS_URL

WORKDIR /app

COPY ./pom.xml ./pom.xml
COPY ./src ./src

RUN mvn package

FROM openjdk:11

COPY --from=builder /app/target/orders-service-example-*.jar /target/orders-service-example.jar

CMD ["java", "-jar", "/target/orders-service-example.jar", "$PAYMENTS_URL", "$SHIPPING_URL", "$PRODUCTS_URL"]