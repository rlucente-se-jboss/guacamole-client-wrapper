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
    && mkdir -p /home/guacamole \
    && for d in /opt/guacamole /usr/local/tomcat /home/guacamole; do \
           chgrp -R 0 $d; \
           chmod -R g+rwX $d; \
       done

USER 1000

EXPOSE 8080

CMD ["/opt/guacamole/bin/start.sh" ]

