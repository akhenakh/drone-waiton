FROM akhenakh/waiton:latest

ENV HOSTS="${DRONE_HOSTS}"
ENV GLOBALTIMEOUT="${DRONE_GLOBALTIMEOUT}"
ENV URLTIMEOUT="${DRONE_URLTIMEOUT}"

WORKDIR /root/
ENTRYPOINT ["./waiton"]
