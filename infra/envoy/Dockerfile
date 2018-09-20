FROM envoyproxy/envoy:latest

COPY envoy.yaml /etc/envoy/envoy.yaml

EXPOSE 18080

WORKDIR /etc/envoy
CMD /usr/local/bin/envoy -c /etc/envoy/envoy.yaml
