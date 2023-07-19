FROM alpine:latest AS download
RUN apk add --no-cache unzip 
ARG PB_VERSION=0.16.10
# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

FROM alpine:latest
RUN   apk add --no-cache  ca-certificates
WORKDIR /app
VOLUME [ "/app/pb_data/" ]
EXPOSE 8090

COPY --from=download /pb/pocketbase /app/pocketbase
# start PocketBase
CMD ["/app/pocketbase", "serve", "--http=0.0.0.0:8090"]
