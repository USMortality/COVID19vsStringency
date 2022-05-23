SELECT
    left(date, 7) AS 'year_month',
    avg(people_vaccinated_per_hundred) / 100 AS 'vaxx_rate'
FROM
    owid.imp_world
WHERE
    iso_code IN ("SWE")
    AND people_vaccinated_per_hundred <> ""
GROUP BY
    left(date, 7);