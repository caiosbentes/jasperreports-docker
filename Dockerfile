# Dockerfile
FROM openjdk:11-jdk

# Environment variables
ENV JASPERREPORTS_VERSION=8.1.0
ENV TOMCAT_VERSION=9.0.73

# Install required packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /opt/jasperreports

# Download and install Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    && tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    && mv apache-tomcat-${TOMCAT_VERSION} tomcat \
    && rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

# Download and install JasperReports Server
RUN wget https://sourceforge.net/projects/jasperserver/files/JasperServer/JasperReports%20Server%20Community%20Edition%20${JASPERREPORTS_VERSION}/TIB_js-jrs-cp_${JASPERREPORTS_VERSION}_bin.zip \
    && unzip TIB_js-jrs-cp_${JASPERREPORTS_VERSION}_bin.zip \
    && rm TIB_js-jrs-cp_${JASPERREPORTS_VERSION}_bin.zip

# Copy configuration files
COPY ./default_master.properties /opt/jasperreports/jasperreports-server-cp-${JASPERREPORTS_VERSION}-bin/buildomatic/default_master.properties

# Set up database properties
RUN echo "appServerDir = /opt/jasperreports/tomcat" >> /opt/jasperreports/jasperreports-server-cp-${JASPERREPORTS_VERSION}-bin/buildomatic/default_master.properties \
    && echo "dbHost=postgres" >> /opt/jasperreports/jasperreports-server-cp-${JASPERREPORTS_VERSION}-bin/buildomatic/default_master.properties \
    && echo "dbPort=5432" >> /opt/jasperreports/jasperreports-server-cp-${JASPERREPORTS_VERSION}-bin/buildomatic/default_master.properties

# Expose ports
EXPOSE 8080

# Add startup script
COPY ./startup.sh /opt/jasperreports/
RUN chmod +x /opt/jasperreports/startup.sh

CMD ["/opt/jasperreports/startup.sh"]
