SELECT
    a.state,
    round(
        (total_cases_end - total_cases_start) / population * 1000000
    ) AS total_cases_per_million,
    administered_dose1_pop_pct
FROM
    (
        SELECT
            state,
            tot_cases AS total_cases_start
        FROM
            owid.imp_us_cases
        WHERE
            submission_date = '06/30/2021'
    ) a
    JOIN(
        SELECT
            state,
            tot_cases AS total_cases_end
        FROM
            owid.imp_us_cases
        WHERE
            submission_date = '06/30/2022'
    ) b
    JOIN (
        SELECT
            location AS 'state',
            administered_dose1_pop_pct
        FROM
            owid.imp_us_vaccine
        WHERE
            date = '06/30/2022'
    ) c
    JOIN (
        SELECT
            left(code, 2) AS 'state',
            population
        FROM
            population.imp_population20152021 a
            JOIN owid.imp_us_states_iso2 b ON a.jurisdiction = b.state
        WHERE
            year = 2022
            AND age_group = 'all' -- AND trim(code) = "AL"
    ) d ON a.state = b.state
    AND b.state = c.state
    AND c.state = d.state;