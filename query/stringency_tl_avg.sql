SELECT
    date,
    @avg := avg(stringency_index),
    @stddv := stddev(stringency_index)
FROM
    owid.imp_world
GROUP BY
    date;