FROM image-registry.openshift-image-registry.svc:5000/loginapp-dev/jws58-openjdk11-openshift-rhel8:5.8.1-2

# Copy app to the container
COPY . /opt/app

# Set the working directory
WORKDIR /opt/app

# Set permissions
USER root
RUN chgrp -R 0 /opt/app && \
    chmod -R g=u /opt/app

# Build War file needed
RUN mvn install && echo "Maven build was successful" || (echo "Maven build failed" && exit 1)

# Copy the War file to the Tomcat webapps directory
USER root
RUN mv /opt/app/target/LoginWebApp.war /deployments

# Expose the default Tomcat port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl --fail http://localhost:8080 || exit 1

