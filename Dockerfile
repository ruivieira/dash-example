FROM radanalyticsio/openshift-spark

USER root

EXPOSE 8050

LABEL io.k8s.description="Dash python example." \
      io.k8s.display-name="Dash python example." \
      io.openshift.expose-services="8050:http"

# Temporary. Disable the fastest mirror plugin.
#RUN sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf

RUN yum -y install python-pip \
    && pip install dash==0.17.7 \
    && pip install dash-renderer==0.7.3 \
    && pip install dash-html-components==0.6.2 \
    && pip install dash-core-components==0.5.3 \
    && pip install plotly==2.0.12 \
    && pip install pandas

ADD start.sh /start.sh
RUN chmod +x /start.sh

ADD app.py /app.py

CMD ["/entrypoint", "/start.sh"]