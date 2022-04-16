SELECT
    '2020/21' AS flu_season,
    `date`,
    date_format(`date`, "%c-%d") AS `date_short`,
    new_deaths AS deaths,
    people_vaccinated_per_hundred
FROM
    (
        SELECT
            STR_TO_DATE(`date`, "%Y-%c-%d") AS `date`,
            new_deaths,
            people_vaccinated_per_hundred
        FROM
            owid.imp_world
        WHERE
            `location` = "World"
    ) a
WHERE
    `date` >= STR_TO_DATE("2020-10-01", "%Y-%c-%d")
    AND `date` < STR_TO_DATE("2021-04-15", "%Y-%c-%d")
UNION
ALL
SELECT
    '2021/22' AS flu_season,
    `date`,
    date_format(`date`, "%c-%d") AS `date_short`,
    new_deaths AS deaths,
    people_vaccinated_per_hundred
FROM
    (
        SELECT
            STR_TO_DATE(`date`, "%Y-%c-%d") AS `date`,
            new_deaths,
            people_vaccinated_per_hundred
        FROM
            owid.imp_world
        WHERE
            `location` = "World"
    ) a
WHERE
    `date` >= STR_TO_DATE("2021-10-01", "%Y-%c-%d")
    AND `date` < STR_TO_DATE("2022-04-15", "%Y-%c-%d");