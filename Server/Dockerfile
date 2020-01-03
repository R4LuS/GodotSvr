FROM debian:stable-slim

RUN apt-get update \ 
    && apt-get install -y libgpg-error0 libpcre3 libicu63 libgcrypt20 liblz4-1 liblzma5 libsystemd0 libicu63 libpcre2-16-0 libglib2.0-0 libc6 libssl1.1 libqt5network5 libstdc++6 zlib1g libqt5core5a \
    && rm -rf /var/lib/apt/lists/*
COPY ./GodotNetTest /app
ENTRYPOINT ["/app/GodotNetTest"]
CMD ["30000"]
EXPOSE 30000/tcp
