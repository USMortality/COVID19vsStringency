SELECT
    a.location,
    a.excess_mortality_cumulative_per_million_delta_q4 + b.excess_mortality_cumulative_per_million_delta_q1,
    c.people_fully_vaccinated_per_hundred
FROM
    owid.excess_diff_q4 a
    JOIN owid.excess_diff_q1 b
    JOIN (
        SELECT
            date,
            location,
            avg(people_fully_vaccinated_per_hundred) / 100 AS people_fully_vaccinated_per_hundred
        FROM
            owid.imp_world
        WHERE
            left(date, 7) IN ('2021-10', '2022-03')
            AND people_fully_vaccinated_per_hundred <> ""
        GROUP BY
            location
    ) c ON a.location = b.location
    AND a.location = c.location;