FROM golang:1.11-alpine AS build
RUN apk add --update make
WORKDIR /go/src/github.com/brancz/kube-rbac-proxy
COPY . .
RUN make build

FROM alpine:3.8
RUN apk add -U --no-cache ca-certificates && rm -rf /var/cache/apk/*
COPY --from=build /go/src/github.com/brancz/kube-rbac-proxy/_output/linux/$(go env GOARCH)/kube-rbac-proxy .
ENTRYPOINT ["./kube-rbac-proxy"]
EXPOSE 8080
