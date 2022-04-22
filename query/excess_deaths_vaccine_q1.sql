DROP VIEW IF EXISTS owid.excess_2021_q1;

CREATE VIEW owid.excess_2021_q1 AS
SELECT
    a.continent,
    a.location,
    b.date,
    excess_mortality_cumulative_per_million AS excess_mortality_cumulative_per_million_2021_q1
FROM
    owid.imp_world a
    JOIN (
        SELECT
            location,
            max(date) AS date
        FROM
            owid.imp_world a
        WHERE
            left(date, 7) = '2021-03'
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
        GROUP BY
            location
    ) b ON a.location = b.location
    AND a.date = b.date;

DROP VIEW IF EXISTS owid.excess_2022_q1;

CREATE VIEW owid.excess_2022_q1 AS
SELECT
    a.continent,
    a.location,
    b.date,
    excess_mortality_cumulative_per_million AS excess_mortality_cumulative_per_million_2022_q1
FROM
    owid.imp_world a
    JOIN (
        SELECT
            location,
            max(date) AS date
        FROM
            owid.imp_world a
        WHERE
            left(date, 7) = '2022-03'
            AND excess_mortality_cumulative_per_million NOT IN (0, "")
        GROUP BY
            location
    ) b ON a.location = b.location
    AND a.date = b.date;

DROP VIEW IF EXISTS owid.excess_diff_q1;

CREATE VIEW owid.excess_diff_q1 AS
SELECT
    continent,
    location,
    excess_mortality_cumulative_per_million_2022_q1,
    excess_mortality_cumulative_per_million_2021_q1,
    excess_mortality_cumulative_per_million_2022_q1 - excess_mortality_cumulative_per_million_2021_q1 AS "excess_mortality_cumulative_per_million_delta_q1"
FROM
    (
        SELECT
            a.continent,
            a.location,
            c.excess_mortality_cumulative_per_million_2021_q1 - d.excess_mortality_cumulative_per_million_2020_q4 AS "excess_mortality_cumulative_per_million_2021_q1",
            a.excess_mortality_cumulative_per_million_2022_q1 - b.excess_mortality_cumulative_per_million_2021_q4 AS "excess_mortality_cumulative_per_million_2022_q1"
        FROM
            owid.excess_2022_q1 a
            JOIN owid.excess_2021_q4 b
            JOIN owid.excess_2021_q1 c
            JOIN owid.excess_2020_q4 d ON a.location = b.location
            AND b.location = c.location
            AND c.location = d.location
    ) a;

SELECT
    a.location,
    a.excess_mortality_cumulative_per_million_delta_q1,
    people_fully_vaccinated_per_hundred,
    a.excess_mortality_cumulative_per_million_2022_q1,
    a.excess_mortality_cumulative_per_million_2021_q1
FROM
    owid.excess_diff_q1 a
    JOIN (
        SELECT
            date,
            location,
            avg(people_fully_vaccinated_per_hundred) / 100 AS people_fully_vaccinated_per_hundred
        FROM
            owid.imp_world
        WHERE
            left(date, 7) IN ('2022-01', '2022-02', '2022-03')
            AND people_fully_vaccinated_per_hundred <> ""
        GROUP BY
            location
    ) b ON a.location = b.location;