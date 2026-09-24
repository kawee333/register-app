FROM tomcat:latest

# Tomcat default webapps ටික Copy කිරීම
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps

# Maven Target folder එකේ ඇති .war file එක ROOT.war ලෙස Copy කිරීම
COPY webapp/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
