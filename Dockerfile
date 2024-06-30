FROM gradle:4.7.0-jdk8-alpine AS build

COPY --chown=gradle:gradle . /var/www/backend

WORKDIR /var/www/backend

RUN gradle build --no-daemon 

FROM openjdk:8-jre-slim AS deploy

EXPOSE 8080

COPY --from=build /var/www/backend/build/libs/*.jar /var/www/backend/app.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/var/www/backend/app.jar"]

