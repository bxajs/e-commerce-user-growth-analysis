-- =============================================
-- 文件：funnel_analysis.sql
-- 功能：用户全路径购买漏斗分析
-- 依赖表：user_action_clean
-- 对应看板：Page 1 经营总览、Page 3 转化分析 - 漏斗图 & 流失明细表
-- 输出：首页/列表页/商品页/支付页/确认页各环节用户数、转化率、流失率
-- =============================================

-- 构造漏斗各环节原始数据：统计每个页面的访问新用户数量
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
-- 给漏斗环节配置排序编号，保证窗口函数按业务顺序计算
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

-- LAG窗口函数取上一环节用户数，计算相邻环节转化率、流失率
SELECT 
    step_order,
    step_name,
    user_count,
    CONCAT(ROUND(user_count / LAG(user_count) OVER(ORDER BY step_order) * 100, 2), '%') AS conversion_rate_percent,
    CONCAT(ROUND(100 - (user_count / LAG(user_count) OVER(ORDER BY step_order) * 100), 2), '%') AS loss_rate_percent
FROM funnel_ordered 
ORDER BY step_order;
