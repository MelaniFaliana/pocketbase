FROM alpine:latest

# Install SSL cert (untuk HTTPS)
RUN apk --no-cache add ca-certificates

WORKDIR /app

# Tambahkan file PocketBase dan beri izin eksekusi
COPY pocketbase /app/pocketbase
RUN chmod +x /app/pocketbase

# (Optional) Tambahkan folder data atau public kalau ada
COPY pb_data /app/pb_data
COPY pb_public /app/pb_public

EXPOSE 8090

ENTRYPOINT ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
