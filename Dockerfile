# Build stage
FROM gcc:13 AS builder
WORKDIR /app
COPY . .
RUN g++ -O2 -std=c++17 -o server main.cpp -lpthread

# Run stage
FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/server .
COPY --from=builder /app/index.html .
EXPOSE 8080
CMD ["./server"]
