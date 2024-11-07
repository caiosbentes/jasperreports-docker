#!/bin/bash

# startup.sh
echo "Starting JasperReports Server setup..."

cd /opt/jasperreports/jasperreports-server-cp-${JASPERREPORTS_VERSION}-bin/buildomatic

# Ensure all scripts are executable
echo "Setting up permissions..."
chmod -R +x /opt/jasperreports/jasperreports-server-cp-${JASPERREPORTS_VERSION}-bin/


# Wait for PostgreSQL to be ready
until PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USERNAME -d $DB_NAME -c '\q'; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

echo "PostgreSQL is up - executing installer"

# Set execute permissions again just to be sure
chmod +x ./js-install-ce.sh
chmod +x ./bin/do-js-install.sh

# Run the JasperReports Server installer
echo "y" | ./js-install-ce.sh minimal

# Check if installation was successful
if [ $? -ne 0 ]; then
    echo "Error: JasperReports Server installation failed"
    exit 1
fi

echo "JasperReports Server installation completed successfully"

# Start Tomcat
/opt/jasperreports/tomcat/bin/catalina.sh run
