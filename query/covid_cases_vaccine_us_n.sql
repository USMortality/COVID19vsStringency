SET
    @start_date = DATE_FORMAT(
        DATE_SUB(
            str_to_date(@end_date, '%m/%d/%Y'),
            INTERVAL 7 DAY
        ),
        '%m/%d/%Y'
    );

SELECT
    a.state,
    round(
        (total_cases_end - total_cases_start) / population * 1000000 / datediff(
            str_to_date(@end_date, '%m/%d/%Y'),
            str_to_date(@start_date, '%m/%d/%Y')
        )
    ) AS total_cases_per_million_per_day,
    series_complete_pop_pct
FROM
    (
        SELECT
            state,
            sum(total_cases_start) AS 'total_cases_start'
        FROM
            (
                SELECT
                    CASE
                        WHEN state IN ('NY', 'NYC') THEN 'NY'
                        ELSE state
                    END AS 'state',
                    tot_cases AS total_cases_start
                FROM
                    owid.imp_us_cases
                WHERE
                    submission_date = @start_date
            ) a
        GROUP BY
            state
    ) a
    JOIN(
        SELECT
            state,
            sum(total_cases_end) AS 'total_cases_end'
        FROM
            (
                SELECT
                    CASE
                        WHEN state IN ('NY', 'NYC') THEN 'NY'
                        ELSE state
                    END AS 'state',
                    tot_cases AS total_cases_end
                FROM
                    owid.imp_us_cases
                WHERE
                    submission_date = @end_date
            ) a
        GROUP BY
            state
    ) b
    JOIN (
        SELECT
            location AS 'state',
            round(avg(series_complete_pop_pct) / 100, 3) AS 'series_complete_pop_pct'
        FROM
            owid.imp_us_vaccine a
        WHERE
            str_to_date(date, '%m/%d/%Y') >= str_to_date(@start_date, '%m/%d/%Y')
            AND str_to_date(date, '%m/%d/%Y') < str_to_date(@end_date, '%m/%d/%Y')
            AND date_type = 'Admin'
        GROUP BY
            location
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
            AND age_group = 'all'
    ) d ON a.state = b.state
    AND b.state = c.state
    AND c.state = d.state
ORDER BY
    state;