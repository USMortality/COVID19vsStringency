# Setup
```sh
brew install docker
docker run --name db -e MYSQL_ALLOW_EMPTY_PASSWORD=true -d -p 3306:3306 mariadb:latest --secure-file-priv=""
```

# Data Import
```sh
wget https://github.com/owid/covid-19-data/blob/master/public/data/owid-covid-data.csv?raw=true -O data/world.csv
```

# Export
```sh
./export.sh
```

# Visualization
1) World: https://docs.google.com/spreadsheets/d/1c8BdWiBk4uGWGVFcR4njf3ctYSakPLf5FFpWXCkRPUs/edit?usp=sharing
2) Europe: https://docs.google.com/spreadsheets/d/1f3xNj1liAw-unPXZaEgqmSBjAeBR281vAH2QoTl-k14/edit#gid=315209782

# About
- https://www.usmortality.com/
- https://twitter.com/USMortality
- https://t.me/usmortality
