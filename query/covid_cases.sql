SELECT
    a.location,
    total_cases_per_million,
    stringency_index_avg
FROM
    owid.imp_world a
    JOIN (
        SELECT
            location,
            avg(stringency_index) AS stringency_index_avg
        FROM
            owid.imp_world
        GROUP BY
            location
    ) b ON a.location = b.location
WHERE
    a.date = '2021-12-31';