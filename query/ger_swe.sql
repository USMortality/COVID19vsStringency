SELECT
    iso_code,
    max(
        cast (excess_mortality_cumulative_per_million AS float)
    ) AS cum_excess_mortality,
    AVG(cast (stringency_index AS float)) AS sum_stringency_index,
    max(
        cast (people_fully_vaccinated_per_hundred AS float)
    ) AS people_fully_vaccinated_per_hundred
FROM
    imp_world
WHERE
    iso_code IN ("DEU", "SWE")
GROUP BY
    iso_code;