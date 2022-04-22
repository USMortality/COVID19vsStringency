#!/bin/bash

mysql -h 127.0.0.1 -u root -e \
    "SET GLOBAL collation_connection = 'utf8mb4_general_ci';"
mysql -h 127.0.0.1 -u root -e "SET GLOBAL sql_mode = '';"

./import_csv.sh data/world.csv owid

mysql -h 127.0.0.1 -u root owid <query/covid_deaths_eu.sql >./out/covid_deaths_eu.csv
mysql -h 127.0.0.1 -u root owid <query/covid_cases_eu.sql >./out/covid_cases_eu.csv
mysql -h 127.0.0.1 -u root owid <query/covid_deaths.sql >./out/covid_deaths.csv
mysql -h 127.0.0.1 -u root owid <query/covid_cases.sql >./out/covid_cases.csv

mysql -h 127.0.0.1 -u root owid <query/covid_cases_vaccine_eu.sql >./out/covid_cases_vaccine_eu.csv
mysql -h 127.0.0.1 -u root owid <query/covid_deaths_vaccine_eu.sql >./out/covid_deaths_vaccine_eu.csv
mysql -h 127.0.0.1 -u root owid <query/covid_cases_vaccine.sql >./out/covid_cases_vaccine.csv
mysql -h 127.0.0.1 -u root owid <query/covid_deaths_vaccine.sql >./out/covid_deaths_vaccine.csv

mysql -h 127.0.0.1 -u root owid <query/excess_deaths_vaccine_eu.sql >./out/excess_deaths_vaccine_eu.csv
mysql -h 127.0.0.1 -u root owid <query/excess_deaths_vaccine.sql >./out/excess_deaths_vaccine.csv
mysql -h 127.0.0.1 -u root owid <query/excess_deaths_vaccine_2.sql >./out/excess_deaths_vaccine_2.csv

mysql -h 127.0.0.1 -u root owid <query/world_covid_deaths.sql >./out/world_covid_deaths.csv
mysql -h 127.0.0.1 -u root owid <query/world_covid_deaths_ts.sql >./out/world_covid_deaths_ts.csv
mysql -h 127.0.0.1 -u root owid <query/correl_acm_c19deaths.sql >./out/correl_acm_c19deaths.csv

mysql -h 127.0.0.1 -u root owid <query/stringency_tl_avg.sql >./out/stringency_tl_avg.csv
