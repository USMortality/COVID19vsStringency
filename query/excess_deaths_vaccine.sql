SELECT
    a.location,
    excess_mortality_cumulative_per_million_end - excess_mortality_cumulative_per_million_start AS excess_mortality_cumulative_per_million_w40_w52,
    people_fully_vaccinated_per_hundred
FROM
    (
        SELECT
            continent,
            location,
            excess_mortality_cumulative_per_million AS excess_mortality_cumulative_per_million_start
        FROM
            owid.imp_world
        WHERE
            date = '2021-09-26'
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
    ) a
    JOIN(
        SELECT
            location,
            excess_mortality_cumulative_per_million AS excess_mortality_cumulative_per_million_end
        FROM
            owid.imp_world
        WHERE
            date = '2021-12-31'
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
    ) b
    JOIN (
        SELECT
            location,
            people_fully_vaccinated_per_hundred
        FROM
            owid.imp_world
        WHERE
            date = '2021-09-26'
    ) c ON a.location = b.location
    AND b.location = c.location;