FROM maven:3.9.9-eclipse-temurin-17 AS maven_build

COPY app /tmp/

WORKDIR /tmp/

CMD ["mvn", "spring-boot:run"]