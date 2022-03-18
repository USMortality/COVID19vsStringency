SELECT
    a.continent,
    a.location,
    iso_code,
    b.date,
    a.total_deaths_per_million,
    excess_mortality_cumulative_per_million
FROM
    owid.imp_world a
    JOIN (
        SELECT
            location,
            max(date) AS date
        FROM
            owid.imp_world a
        WHERE
            left(date, 7) IN ('2021-12', '2022-01', '2021-02', '2021-03')
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
        GROUP BY
            location
    ) b ON a.location = b.location
    AND a.date = b.date