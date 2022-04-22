SELECT
    date,
    @avg := avg(stringency_index) AS "stringency_avg",
    @stddv := stddev(stringency_index) AS "stringency_stddv"
FROM
    owid.imp_world
WHERE
    stringency_index <> ""
GROUP BY
    date;