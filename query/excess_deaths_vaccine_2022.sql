SELECT
    a.location,
    excess_mortality_cumulative_per_million_end - excess_mortality_cumulative_per_million_start AS excess_mortality_cumulative_per_million_w40_w52,
    people_fully_vaccinated_per_hundred
FROM
    (
        SELECT
            continent,
            location,
            max(excess_mortality_cumulative_per_million) AS excess_mortality_cumulative_per_million_start
        FROM
            owid.imp_world
        WHERE
            left(date, 7) = '2021-06'
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
        GROUP BY
            continent,
            location
    ) a
    JOIN(
        SELECT
            continent,
            location,
            max(excess_mortality_cumulative_per_million) AS excess_mortality_cumulative_per_million_end
        FROM
            owid.imp_world
        WHERE
            left(date, 7) = '2022-06'
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
        GROUP BY
            continent,
            location
    ) b
    JOIN (
        SELECT
            location,
            max(people_fully_vaccinated_per_hundred) AS 'people_fully_vaccinated_per_hundred'
        FROM
            owid.imp_world
        WHERE
            left(date, 7) = '2022-06'
        GROUP BY
            location
    ) c ON a.location = b.location
    AND b.location = c.location;