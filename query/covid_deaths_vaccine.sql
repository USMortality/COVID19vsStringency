SELECT
    a.location,
    total_deaths_per_million_end - total_deaths_per_million_start AS total_deaths_per_million_w40_w52,
    people_fully_vaccinated_per_hundred
FROM
    (
        SELECT
            continent,
            location,
            total_deaths_per_million AS total_deaths_per_million_start
        FROM
            owid.imp_world
        WHERE
            date = '2021-09-26'
            AND total_deaths_per_million NOT IN (0, "")
    ) a
    JOIN(
        SELECT
            location,
            total_deaths_per_million AS total_deaths_per_million_end
        FROM
            owid.imp_world
        WHERE
            date = '2021-12-31'
            AND total_deaths_per_million NOT IN (0, "")
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