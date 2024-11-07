# Dockerfile
FROM openjdk:11-jdk

# Environment variables
ENV JASPERREPORTS_VERSION=7.8.0
ENV TOMCAT_VERSION=9.0.68

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
RUN wget https://master.dl.sourceforge.net/project/jr-community-installers/Server/TIB_js-jrs-cp_${JASPERREPORTS_VERSION}_bin.zip \
    && unzip TIB_js-jrs-cp_${JASPERREPORTS_VERSION}_bin.zip \
    && rm TIB_js-jrs-cp_${JASPERREPORTS_VERSION}_bin.zip

# Copy configuration files
COPY ./default_master.properties /opt/jasperreports/jasperreports-server-cp-${JASPERREPORTS_VERSION}-bin/buildomatic/default_master.properties

# Fix permissions
RUN chmod +x /opt/jasperreports/jasperreports-server-cp-${JASPERREPORTS_VERSION}-bin/buildomatic/*.sh

# Expose ports
EXPOSE 8080

# Add startup script
COPY ./startup.sh /opt/jasperreports/
RUN chmod +x /opt/jasperreports/startup.sh

CMD ["/opt/jasperreports/startup.sh"]
