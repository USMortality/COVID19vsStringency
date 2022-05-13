SELECT
    a.location,
    sum_stringency_index,
    people_fully_vaccinated_per_hundred
FROM
    (
        SELECT
            location,
            sum(stringency_index) /(366 + 365) AS 'sum_stringency_index'
        FROM
            owid.imp_world a
        WHERE
            left(date, 4) IN ('2021', '2020')
        GROUP BY
            location
    ) a
    JOIN (
        SELECT
            a.location,
            b.date,
            people_fully_vaccinated_per_hundred
        FROM
            owid.imp_world a
            JOIN (
                SELECT
                    location,
                    max(date) AS date
                FROM
                    owid.imp_world a
                WHERE
                    left(date, 7) = '2021-12'
                    AND people_fully_vaccinated_per_hundred NOT IN (0, "")
                GROUP BY
                    location
            ) b ON a.location = b.location
            AND a.date = b.date
    ) b ON a.location = b.location
WHERE
    sum_stringency_index > 0