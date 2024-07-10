#!/bin/bash

# Move the application source to the build directory
mv /tmp/src /opt/app-root/src

# Navigate to the project directory
cd /opt/app-root/src

# Build the WAR file using Maven
mvn clean package
