FROM rust:1.56 AS builder

WORKDIR /app

COPY . ./

RUN cargo build --release

FROM ubuntu AS final

COPY --from=builder /app/target/release/agora /usr/local/bin/agora

ENV PATH="/usr/local/bin:$PATH"

COPY "entrypoint.sh" .
RUN chmod +x entrypoint.sh

COPY "wait-for-it.sh" .
RUN chmod +x wait-for-it.sh

CMD ["./entrypoint.sh"]
