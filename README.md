# flyway-docker

Flyway CE Docker image based on apline linux, inspired on official Flyway image, but with no security vulnerabilities, plus usefull wait-for.sh (https://github.com/eficode/wait-for)

```
trivy lapierre/flyway
2020-10-14T19:33:07.529+0200	WARN	You should avoid using the :latest tag as it is cached. You need to specify '--clear-cache' option when :latest image is changed
2020-10-14T19:33:07.550+0200	INFO	Need to update DB
2020-10-14T19:33:07.550+0200	INFO	Downloading DB...
18.51 MiB / 18.51 MiB [---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 1.36 MiB p/s 14s
2020-10-14T19:33:23.953+0200	INFO	Detecting Alpine vulnerabilities...
lapierre/flyway (alpine 3.12.0)
===============================
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)
```

## Licence 

This project is licenced on Apache 2.0, same as Flyway Community Edition - Apache 2.0. wait-for.sh in on MIT Licence. 


## Use in docker compose

```
version: '3'

services:

  flyway:
    image: lapierre/flyway
    entrypoint: ["wait-for.sh", "db:5432", "--", "flyway", "migrate"]
    volumes:
      - ./sql:/flyway/sql
    environment:
      - FLYWAY_URL=jdbc:postgresql://db:5432/sample
      - FLYWAY_USER=db_user
      - FLYWAY_PASSWORD=db_user_pass
      - FLYWAY_SCHEMAS=public      
      - FLYWAY_LOCATIONS=filesystem:./sql
    depends_on:
      - db

  db:
    image: postgres:12
    volumes:
      - pg_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=123ewqasd
      - POSTGRES_USER=db_user_pass
      - POSTGRES_DB=sample
    ports:
      - "5432:5432"

volumes:
  pg_data:
```
