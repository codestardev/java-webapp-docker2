# setup working directory
FROM maven AS build
RUN mkdir /app
WORKDIR /app

# maven build
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package

# deploy to tomcat server
FROM tomcat 
COPY --from=build app/target/simplewebapp.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
