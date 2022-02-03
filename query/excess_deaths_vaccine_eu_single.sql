SELECT
    b.location,
    excess_mortality_cumulative_per_million_end,
    people_fully_vaccinated_per_hundred
FROM
    (
        SELECT
            a.continent,
            a.location,
            b.date,
            excess_mortality_cumulative_per_million AS excess_mortality_cumulative_per_million_end
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
                    AND excess_mortality_cumulative_per_million NOT IN (0, "")
                GROUP BY
                    location
            ) b ON a.location = b.location
            AND a.date = b.date
    ) b
    JOIN (
        SELECT
            location,
            people_fully_vaccinated_per_hundred
        FROM
            owid.imp_world
        WHERE
            date = '2021-09-26'
    ) c ON b.location = c.location
WHERE
    b.continent = 'Europe';