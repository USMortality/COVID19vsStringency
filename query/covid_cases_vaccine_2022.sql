SELECT
    a.location,
    total_cases_per_million_end - total_cases_per_million_start AS total_cases_per_million_w40_w52,
    people_fully_vaccinated_per_hundred
FROM
    (
        SELECT
            continent,
            location,
            total_cases_per_million AS total_cases_per_million_start
        FROM
            owid.imp_world
        WHERE
            date = '2021-12-31'
            AND total_cases_per_million NOT IN (0, "")
    ) a
    JOIN(
        SELECT
            location,
            total_cases_per_million AS total_cases_per_million_end
        FROM
            owid.imp_world
        WHERE
            date = '2022-06-30'
            AND total_cases_per_million NOT IN (0, "")
    ) b
    JOIN (
        SELECT
            location,
            max(people_fully_vaccinated_per_hundred) AS 'people_fully_vaccinated_per_hundred'
        FROM
            owid.imp_world
        WHERE
            left(date, 7) = '2022-07'
        GROUP BY
            location
    ) c ON a.location = b.location
    AND b.location = c.location;