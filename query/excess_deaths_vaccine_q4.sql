DROP VIEW IF EXISTS owid.excess_2020_q3;

CREATE VIEW owid.excess_2020_q3 AS
SELECT
    a.continent,
    a.location,
    b.date,
    excess_mortality_cumulative_per_million AS excess_mortality_cumulative_per_million_2020_q3
FROM
    owid.imp_world a
    JOIN (
        SELECT
            location,
            max(date) AS date
        FROM
            owid.imp_world a
        WHERE
            left(date, 7) = '2020-09'
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
        GROUP BY
            location
    ) b ON a.location = b.location
    AND a.date = b.date;

DROP VIEW IF EXISTS owid.excess_2021_q3;

CREATE VIEW owid.excess_2021_q3 AS
SELECT
    a.continent,
    a.location,
    b.date,
    excess_mortality_cumulative_per_million AS excess_mortality_cumulative_per_million_2021_q3
FROM
    owid.imp_world a
    JOIN (
        SELECT
            location,
            max(date) AS date
        FROM
            owid.imp_world a
        WHERE
            left(date, 7) = '2021-09'
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
        GROUP BY
            location
    ) b ON a.location = b.location
    AND a.date = b.date;

DROP VIEW IF EXISTS owid.excess_2020_q4;

CREATE VIEW owid.excess_2020_q4 AS
SELECT
    a.continent,
    a.location,
    b.date,
    excess_mortality_cumulative_per_million AS excess_mortality_cumulative_per_million_2020_q4
FROM
    owid.imp_world a
    JOIN (
        SELECT
            location,
            max(date) AS date
        FROM
            owid.imp_world a
        WHERE
            left(date, 7) = '2020-12'
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
        GROUP BY
            location
    ) b ON a.location = b.location
    AND a.date = b.date;

DROP VIEW IF EXISTS owid.excess_2021_q4;

CREATE VIEW owid.excess_2021_q4 AS
SELECT
    a.continent,
    a.location,
    b.date,
    excess_mortality_cumulative_per_million AS excess_mortality_cumulative_per_million_2021_q4
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
    AND a.date = b.date;

DROP VIEW IF EXISTS owid.excess_2022_q4;

CREATE VIEW owid.excess_2022_q4 AS
SELECT
    a.continent,
    a.location,
    b.date,
    excess_mortality_cumulative_per_million AS excess_mortality_cumulative_per_million_2022_q4
FROM
    owid.imp_world a
    JOIN (
        SELECT
            location,
            max(date) AS date
        FROM
            owid.imp_world a
        WHERE
            left(date, 7) = '2022-12'
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
        GROUP BY
            location
    ) b ON a.location = b.location
    AND a.date = b.date;

DROP VIEW IF EXISTS owid.excess_diff_q4;

CREATE VIEW owid.excess_diff_q4 AS
SELECT
    continent,
    location,
    excess_mortality_cumulative_per_million_2021_q4,
    excess_mortality_cumulative_per_million_2020_q4,
    excess_mortality_cumulative_per_million_2021_q4 - excess_mortality_cumulative_per_million_2020_q4 AS "excess_mortality_cumulative_per_million_delta_q4"
FROM
    (
        SELECT
            a.continent,
            a.location,
            c.excess_mortality_cumulative_per_million_2020_q4 - d.excess_mortality_cumulative_per_million_2020_q3 AS "excess_mortality_cumulative_per_million_2020_q4",
            a.excess_mortality_cumulative_per_million_2021_q4 - b.excess_mortality_cumulative_per_million_2021_q3 AS "excess_mortality_cumulative_per_million_2021_q4"
        FROM
            owid.excess_2021_q4 a
            JOIN owid.excess_2021_q3 b
            JOIN owid.excess_2020_q4 c
            JOIN owid.excess_2020_q3 d ON a.location = b.location
            AND b.location = c.location
            AND c.location = d.location
    ) a;

SELECT
    a.location,
    a.excess_mortality_cumulative_per_million_delta_q4,
    people_fully_vaccinated_per_hundred,
    a.excess_mortality_cumulative_per_million_2021_q4,
    a.excess_mortality_cumulative_per_million_2020_q4
FROM
    owid.excess_diff_q4 a
    JOIN (
        SELECT
            date,
            location,
            avg(people_fully_vaccinated_per_hundred) / 100 AS people_fully_vaccinated_per_hundred
        FROM
            owid.imp_world
        WHERE
            left(date, 7) IN ('2021-10', '2021-11', '2021-12')
            AND people_fully_vaccinated_per_hundred <> ""
        GROUP BY
            location
    ) b ON a.location = b.location;