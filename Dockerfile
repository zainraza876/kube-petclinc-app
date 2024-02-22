FROM techiescamp/jre-17:1.0.0
COPY /__w/github-actions/github-actions/target/*.jar /app/java.jar
EXPOSE 8080