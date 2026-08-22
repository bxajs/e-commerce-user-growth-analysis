-- =============================================
-- 文件：cross_analysis.sql
-- 功能：多维度交叉下钻分析
-- 依赖表：user_action_clean
-- 说明：通过双维度组合拆解，定位不同分层下的转化差异，支撑深度业务诊断
-- 输出：各交叉维度下的用户规模与最终转化率
-- =============================================

-- ========== 1. 年龄段 × 性别 交叉分析 ==========
SELECT
    CASE
        WHEN age <= 20 THEN '20岁及以下'
        WHEN age > 20 AND age <= 30 THEN '21-30之间'
        WHEN age > 30 AND age <= 40 THEN '31-40之间'
        WHEN age > 40 THEN '41岁及以上'
    END AS `年龄段`,
    sex AS `性别`,
    COUNT(*) AS `用户数`,
    CONCAT(ROUND(AVG(confirmation_page)*100, 2), '%') AS `最终转化率`
FROM user_action_clean
GROUP BY `年龄段`, `性别`
ORDER BY `年龄段`, `性别`;

-- ========== 2. 流量渠道 × 新老用户 交叉分析 ==========
SELECT
    source AS `流量渠道`,
    new_user AS `新老用户`,
    COUNT(*) AS `用户数`,
    CONCAT(ROUND(AVG(confirmation_page)*100, 2), '%') AS `最终转化率`
FROM user_action_clean
GROUP BY `流量渠道`, `新老用户`
ORDER BY `流量渠道`, `新老用户`;

-- ========== 3. 活跃度 × 性别 交叉分析 ==========
SELECT
    CASE
        WHEN total_pages_visited >= 13 THEN '高活跃度'
        WHEN total_pages_visited >= 7 AND total_pages_visited < 13 THEN '中活跃度'
        WHEN total_pages_visited <= 6 THEN '低活跃度'
    END AS `活跃度`,
    sex AS `性别`,
    COUNT(*) AS `用户数`,
    CONCAT(ROUND(AVG(confirmation_page)*100, 2), '%') AS `最终转化率`
FROM user_action_clean
GROUP BY `活跃度`, `性别`
ORDER BY `活跃度`, `性别`;

-- ========== 4. 访问设备 × 新老用户 交叉分析 ==========
SELECT
    device AS `访问设备`,
    new_user AS `新老用户`,
    COUNT(*) AS `用户数`,
    CONCAT(ROUND(AVG(confirmation_page)*100, 2), '%') AS `最终转化率`
FROM user_action_clean
GROUP BY `访问设备`, `新老用户`
ORDER BY `访问设备`, `新老用户`;

-- ========== 5. 地区 × 流量渠道 交叉分析 ==========
SELECT
    market AS `地区`,
    source AS `流量渠道`,
    COUNT(*) AS `用户数`,
    CONCAT(ROUND(AVG(confirmation_page)*100, 2), '%') AS `最终转化率`
FROM user_action_clean
GROUP BY `地区`, `流量渠道`
ORDER BY `地区`, `流量渠道`;
