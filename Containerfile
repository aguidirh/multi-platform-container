FROM golang:1.21-alpine AS build
RUN mkdir /gobin
WORKDIR /gobin
COPY main.go .
ARG MY_OS
ARG MY_ARCH
ENV GOOS=${MY_OS}
ENV GOARCH=${MY_ARCH}
RUN go build -o /gobin/hello main.go
FROM scratch
COPY --from=build /gobin/hello /hello
ENTRYPOINT ["/hello"]