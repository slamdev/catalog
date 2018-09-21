## admin url
- http://api-gateway-admin-svc.micro-ci.svc.cluster.local/ambassador/v0/diag/
- http://localhost:8888/ambassador/v0/diag/?logging=debug

## notes

Ambassador is built from sources because currently it doesn't support envoy's gRPC-Web filter.

**envoy.j2** was extended with corresponding filter support.

Open issue: https://github.com/datawire/ambassador/issues/456
