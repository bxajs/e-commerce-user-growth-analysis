WITH funnel_steps AS (
    SELECT '首页' AS step_name, COUNT(new_user) AS user_count 
    FROM user_action_clean 
    WHERE home_page = 1

    UNION ALL
    SELECT '列表页' AS step_name, COUNT(new_user) AS user_count 
    FROM user_action_clean 
    WHERE listing_page = 1

    UNION ALL
    SELECT '商品页' AS step_name, COUNT(new_user) AS user_count 
    FROM user_action_clean 
    WHERE product_page = 1

    UNION ALL
    SELECT '支付页' AS step_name, COUNT(new_user) AS user_count 
    FROM user_action_clean 
    WHERE payment_page = 1

    UNION ALL
    SELECT '订单确认页' AS step_name, COUNT(new_user) AS user_count 
    FROM user_action_clean 
    WHERE confirmation_page = 1
),
funnel_ordered AS (
    SELECT 
        step_name,
        user_count,
        CASE step_name
            WHEN '首页' THEN 1
            WHEN '列表页' THEN 2
            WHEN '商品页' THEN 3
            WHEN '支付页' THEN 4
            WHEN '订单确认页' THEN 5
        END AS step_order
    FROM funnel_steps
)

SELECT 
    step_order,
    step_name,
    user_count,
    CONCAT(ROUND(user_count / LAG(user_count) OVER(ORDER BY step_order) * 100, 2), '%') AS convertion_rate_percent,
    CONCAT(ROUND(100 - (user_count / LAG(user_count) OVER(ORDER BY step_order) * 100), 2), '%') AS loss_rate_percent
FROM funnel_ordered 
ORDER BY step_order;
