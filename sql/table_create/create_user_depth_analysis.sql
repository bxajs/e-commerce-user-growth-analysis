CREATE TABLE user_depth_analysis AS
SELECT
    new_user,
    total_pages_visited,
    confirmation_page,
    CASE
        WHEN total_pages_visited <= 2 THEN '低访问深度(1-2页)'
        WHEN total_pages_visited BETWEEN 3 AND 5 THEN '中低访问深度(3-5页)'
        WHEN total_pages_visited BETWEEN 6 AND 10 THEN '中高访问深度(6-10页)'
        WHEN total_pages_visited > 10 THEN '高访问深度(10页以上)'
    END AS depth_level,
    CASE
        WHEN confirmation_page = 1 THEN '已购买'
        ELSE '未购买'
    END AS order_status
FROM user_action_clean;
