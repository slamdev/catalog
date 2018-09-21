FROM alpine/git as CLONE

WORKDIR /

RUN git clone --branch 0.39.0 https://github.com/datawire/ambassador.git
RUN	cd ambassador && sed -e "s/{{VERSION}}/0.0.0/g" < VERSION-template.py > ambassador/ambassador/VERSION.py

COPY envoy.j2 ambassador/ambassador/templates/envoy.j2

FROM quay.io/datawire/ambassador-envoy:v1.7.0-64-g09ba72b1-alpine-stripped as BUILD

RUN apk --no-cache add curl python3 socat

ENV AMBASSADOR_ROOT=/ambassador
WORKDIR ${AMBASSADOR_ROOT}

COPY --from=CLONE /ambassador/ambassador/requirements.txt .

RUN pip3 install -r requirements.txt

COPY --from=CLONE /ambassador/ambassador ambassador
RUN cd ambassador && python3 setup.py --quiet install
RUN rm -rf ./ambassador

RUN mkdir ambassador-config

COPY --from=CLONE /ambassador/ambassador/default-config/ ambassador-demo-config

RUN chgrp -R 0 ${AMBASSADOR_ROOT} && \
    chmod -R u+x ${AMBASSADOR_ROOT} && \
    chmod -R g=u ${AMBASSADOR_ROOT} /etc/passwd

COPY --from=CLONE /ambassador/ambassador/kubewatch.py .
COPY --from=CLONE /ambassador/ambassador/hot-restarter.py .
COPY --from=CLONE /ambassador/ambassador/start-envoy.sh .
COPY --from=CLONE /ambassador/ambassador/entrypoint.sh .
RUN chmod 755 start-envoy.sh entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
