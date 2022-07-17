#!/bin/bash

mysql -h 127.0.0.1 -u root -e \
    "SET GLOBAL collation_connection = 'utf8mb4_general_ci';"
mysql -h 127.0.0.1 -u root -e "SET GLOBAL sql_mode = '';"

./import_csv.sh data/world.csv owid
./import_csv.sh data/us_vaccine.csv owid
./import_csv.sh data/us_cases.csv owid
./import_csv.sh data/us_states_iso2.csv owid

mysql -h 127.0.0.1 -u root owid <query/covid_deaths_eu.sql >./out/covid_deaths_eu.tsv
mysql -h 127.0.0.1 -u root owid <query/covid_cases_eu.sql >./out/covid_cases_eu.tsv
mysql -h 127.0.0.1 -u root owid <query/covid_deaths.sql >./out/covid_deaths.tsv
mysql -h 127.0.0.1 -u root owid <query/covid_cases.sql >./out/covid_cases.tsv

mysql -h 127.0.0.1 -u root owid <query/covid_cases_vaccine_eu.sql >./out/covid_cases_vaccine_eu.tsv
mysql -h 127.0.0.1 -u root owid <query/covid_cases_vaccine_eu_2022.sql >./out/covid_cases_vaccine_eu_2022.tsv
mysql -h 127.0.0.1 -u root owid <query/covid_deaths_vaccine_eu.sql >./out/covid_deaths_vaccine_eu.tsv
mysql -h 127.0.0.1 -u root owid <query/covid_cases_vaccine.sql >./out/covid_cases_vaccine.tsv
mysql -h 127.0.0.1 -u root owid <query/covid_cases_vaccine_2022.sql >./out/covid_cases_vaccine_2022.tsv
mysql -h 127.0.0.1 -u root owid <query/covid_deaths_vaccine.sql >./out/covid_deaths_vaccine.tsv
mysql -h 127.0.0.1 -u root owid <query/covid_cases_vaccine_us_2022.sql >./out/covid_cases_vaccine_us_2022.tsv
mysql -h 127.0.0.1 -u root owid <query/covid_cases_vaccine_us_7_21-6-22.sql >./out/covid_cases_vaccine_us_7_21-6-22.tsv

mysql -h 127.0.0.1 -u root owid <query/excess_deaths_vaccine_eu.sql >./out/excess_deaths_vaccine_eu.tsv
mysql -h 127.0.0.1 -u root owid <query/excess_deaths_vaccine.sql >./out/excess_deaths_vaccine.tsv
mysql -h 127.0.0.1 -u root owid <query/excess_deaths_vaccine_q4.sql >./out/excess_deaths_vaccine_q4.tsv
mysql -h 127.0.0.1 -u root owid <query/excess_deaths_vaccine_q1.sql >./out/excess_deaths_vaccine_q1.tsv
mysql -h 127.0.0.1 -u root owid <query/excess_deaths_vaccine_q4_q1.sql >./out/excess_deaths_vaccine_q4_q1.tsv
mysql -h 127.0.0.1 -u root owid <query/excess_deaths_vaccine_2022.sql >./out/excess_deaths_vaccine_2022.tsv

mysql -h 127.0.0.1 -u root owid <query/world_covid_deaths.sql >./out/world_covid_deaths.tsv
mysql -h 127.0.0.1 -u root owid <query/world_covid_deaths_ts.sql >./out/world_covid_deaths_ts.tsv
mysql -h 127.0.0.1 -u root owid <query/correl_acm_c19deaths.sql >./out/correl_acm_c19deaths.tsv

mysql -h 127.0.0.1 -u root owid <query/stringency_tl_avg.sql >./out/stringency_tl_avg.tsv
mysql -h 127.0.0.1 -u root owid <query/stringency_vaxx_2020_2021.sql >./out/stringency_vaxx_2020_2021.tsv
