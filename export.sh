#!/bin/bash

mysql -h 127.0.0.1 -u root -e \
    "SET GLOBAL collation_connection = 'utf8mb4_general_ci';"
mysql -h 127.0.0.1 -u root -e "SET GLOBAL sql_mode = '';"

./import_csv.sh data/world.csv owid

mysql -h 127.0.0.1 -u root owid <query/covid_deaths_eu.sql >./out/covid_deaths_eu.csv
mysql -h 127.0.0.1 -u root owid <query/covid_cases_eu.sql >./out/covid_cases_eu.csv
mysql -h 127.0.0.1 -u root owid <query/covid_deaths.sql >./out/covid_deaths.csv
mysql -h 127.0.0.1 -u root owid <query/covid_cases.sql >./out/covid_cases.csv
