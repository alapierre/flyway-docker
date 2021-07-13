FROM lapierre/java-alpine:8

MAINTAINER Adrian Lapierre <al@alapierre.io>

# Add the flyway user and step in the directory
RUN addgroup -S flyway && adduser --home /flyway -S -G flyway flyway && apk add --no-cache bash

WORKDIR /flyway

# Change to the flyway user
USER flyway

ENV FLYWAY_VERSION 7.11.1

RUN wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz --strip-components=1 \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz

ADD wait-for.sh wait-for.sh

ENV PATH="/flyway:${PATH}"

ENTRYPOINT ["flyway"]
CMD ["-?"]
