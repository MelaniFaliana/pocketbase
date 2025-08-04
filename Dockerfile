# Tahap build
FROM golang:1.22 AS build

WORKDIR /app

COPY go.* ./
RUN go mod download

COPY . .
RUN go build -o pocketbase .

# Tahap production
FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /app
COPY --from=build /app/pocketbase /app/pocketbase

EXPOSE 8090
ENTRYPOINT ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
