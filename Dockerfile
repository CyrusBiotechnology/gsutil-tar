FROM golang:1.9 AS builder

WORKDIR /go/src/github.com/guillaumerose/gcloud-tar
COPY . .

RUN CGO_ENABLED=0 go build -a -installsuffix cgo .

RUN mv gcloud-tar /gcloud-tar

FROM alpine

COPY --from=builder /gcloud-tar /bin/gcloud-tar
ADD https://curl.haxx.se/ca/cacert.pem /etc/ssl/certs/ca-certificates.crt

ENTRYPOINT ["/bin/gcloud-tar"]
