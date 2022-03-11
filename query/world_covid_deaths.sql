SELECT
    '2020/21' AS flu_season,
    sum(new_deaths) AS deaths
FROM
    (
        SELECT
            STR_TO_DATE(`date`, "%Y-%c-%d") AS `date`,
            new_deaths
        FROM
            owid.imp_world
        WHERE
            location = "World"
    ) a
WHERE
    `date` >= STR_TO_DATE("2021-06-01", "%Y-%c-%d")
    AND `date` < STR_TO_DATE("2022-03-09", "%Y-%c-%d")
UNION
ALL
SELECT
    '2021/22' AS flu_season,
    sum(new_deaths) AS deaths
FROM
    (
        SELECT
            STR_TO_DATE(`date`, "%Y-%c-%d") AS `date`,
            new_deaths
        FROM
            owid.imp_world
        WHERE
            location = "World"
    ) a
WHERE
    `date` >= STR_TO_DATE("2020-06-01", "%Y-%c-%d")
    AND `date` < STR_TO_DATE("2021-03-09", "%Y-%c-%d");