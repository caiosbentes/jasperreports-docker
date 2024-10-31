#!/bin/bash

# startup.sh
echo "Starting JasperReports Server setup..."

cd /opt/jasperreports/jasperreports-server-cp-${JASPERREPORTS_VERSION}-bin/buildomatic

# Wait for PostgreSQL to be ready
until PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USERNAME -d $DB_NAME -c '\q'; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

echo "PostgreSQL is up - executing installer"

# Run the JasperReports Server installer
./js-install-ce.sh minimal

# Start Tomcat
/opt/jasperreports/tomcat/bin/catalina.sh run
