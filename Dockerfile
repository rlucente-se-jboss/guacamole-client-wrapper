FROM guacamole/guacamole:latest
MAINTAINER  Rich Lucente "rich.lucente@gmail.com"

LABEL io.k8s.description="Run guacamole-client in OpenShift" \
      io.k8s.display-name="Guacamole" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="guacamole"

COPY start.sh /opt/guacamole/bin/

# Give the tomcat and guacamole directories to root group (not root user)
# https://docs.openshift.org/latest/creating_images/guidelines.html#openshift-origin-specific-guidelines
RUN    chmod a+x /opt/guacamole/bin/start.sh \
    && chgrp -R 0 /opt/guacamole \
    && chmod -R g+rwX /opt/guacamole \
    && chgrp -R 0 /usr/local/tomcat \
    && chmod -R g+rwX /usr/local/tomcat \
    && mkdir -p /home/guacamole \
    && chgrp -R 0 /home/guacamole \
    && chmod -R g+rwX /home/guacamole 

USER 1000

EXPOSE 8080

CMD ["/opt/guacamole/bin/start.sh" ]

