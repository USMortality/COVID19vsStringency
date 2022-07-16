#!/bin/sh

wget https://github.com/owid/covid-19-data/blob/master/public/data/owid-covid-data.csv?raw=true -O data/world.csv
wget "https://data.cdc.gov/api/views/rh2h-3yt2/rows.csv?accessType=DOWNLOAD" -O data/us_vaccine.csv
wget "https://data.cdc.gov/api/views/9mfq-cb36/rows.csv?accessType=DOWNLOAD" -O data/us_cases.csv
