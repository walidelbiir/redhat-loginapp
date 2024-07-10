#!/bin/bash

# Move the WAR file to JBoss deployment directory
mv target/*.war /deployments

# Clean up
mvn clean
rm -rf ~/.m2/repository