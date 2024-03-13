# Use an official OpenJDK runtime as a parent image
# FROM openjdk:11-jre-slim
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory in the container
WORKDIR /app

# Copy the packaged JAR file into the container at the working directory
COPY school-0.0.1-SNAPSHOT.jar /app/school-0.0.1-SNAPSHOT.jar

EXPOSE 8082

# Specify the command to run on container start
CMD ["java", "-jar", "school-0.0.1-SNAPSHOT.jar"]
