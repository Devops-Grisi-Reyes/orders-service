FROM maven:3-jdk-13-alpine as builder

WORKDIR /app

COPY ./pom.xml ./pom.xml
COPY ./src ./src

RUN mvn package

FROM openjdk:11

COPY --from=builder /app/target/orders-service-example-*.jar /target/orders-service-example.jar

EXPOSE 8080

RUN curl http://payments-service:30037/payments/
RUN curl http://shipping-service:30038/shipping/
RUN curl http://products-service:30039/products/

CMD ["java", "-jar", "/target/orders-service-example.jar", "http://payments-service:30037/payments/", "http://shipping-service:30038/shippings/",  "http://products-service:30039/products/"]