WITH all_users AS (
    SELECT user_id,
           MAX(CASE WHEN action = 'page_load' THEN timestamp END) AS load_timestamp,
           MIN(CASE WHEN action = 'page_exit' THEN timestamp END) AS exit_timestamp,
           SUBSTRING(CAST(timestamp AS VARCHAR), 1, 10) AS date_only
    FROM facebook_web_log
    GROUP BY user_id, SUBSTRING(CAST(timestamp AS VARCHAR), 1, 10)
)
SELECT user_id, AVG(exit_timestamp - load_timestamp) AS avg_duration
FROM all_users
GROUP BY user_id
HAVING AVG(exit_timestamp - load_timestamp) IS NOT NULL;