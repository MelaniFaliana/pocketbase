FROM golang:1.22 as build

WORKDIR /app
COPY . .

RUN go build -o pocketbase .

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /app
COPY --from=build /app/pocketbase /app/pocketbase
COPY pb_migrations /app/pb_migrations
COPY pb_public /app/pb_public

EXPOSE 8090

ENTRYPOINT ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
