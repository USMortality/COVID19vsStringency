SELECT
    year,
    -- MONTH,
    sum(new_deaths) AS deaths
FROM
    (
        SELECT
            cast(mid(date, 6, 2) AS integer) AS MONTH,
            left(date, 4) AS year,
            new_deaths
        FROM
            owid.imp_world
        WHERE
            location = "North America"
    ) a
WHERE
    MONTH >= 6
    AND MONTH <= 12
GROUP BY
    year;

-- MONTH;