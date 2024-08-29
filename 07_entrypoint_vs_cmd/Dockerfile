FROM alpine:latest

ENV MY_VAR=default_value

WORKDIR /app

COPY . .

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["ls", "/app"]
