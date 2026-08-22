SELECT
    depth_level,
    COUNT(new_user) AS user_count
FROM user_depth_analysis
GROUP BY depth_level;


SELECT
    depth_level,
    COUNT(new_user) AS total_users,
    SUM(CASE WHEN confirmation_page = 1 THEN 1 ELSE 0 END) AS buyers,
    CONCAT(
        ROUND(
            SUM(CASE WHEN confirmation_page = 1 THEN 1 ELSE 0 END)
            / COUNT(new_user)
            * 100,
            2
        ),
        '%'
    ) AS conversion_rate
FROM user_depth_analysis
GROUP BY depth_level
ORDER BY CASE depth_level
    WHEN '低访问深度(1-2页)' THEN 1
    WHEN '中低访问深度(3-5页)' THEN 2
    WHEN '中高访问深度(6-10页)' THEN 3
    WHEN '高访问深度(10页以上)' THEN 4
END;
