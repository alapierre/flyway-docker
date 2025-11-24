FROM lapierre/java-alpine:21

LABEL maintainer="Adrian Lapierre <al@alapierre.io>"

# Add the flyway user
RUN addgroup -S flyway && adduser --home /flyway -S -G flyway flyway \
    && apk add --no-cache bash

WORKDIR /flyway

# Change to the flyway user
USER flyway

ARG FLYWAY_VERSION

RUN wget https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz --strip-components=1 \
  && rm flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz

ADD wait-for.sh wait-for.sh

ENV PATH="/flyway:${PATH}"

ENTRYPOINT ["flyway"]
CMD ["-?"]
