-- =============================================
-- 文件：user_profile_stats.sql
-- 功能：用户画像多维度分布统计
-- 依赖表：user_action_clean
-- 对应看板：Page 2 用户画像分析
-- 输出：年龄性别、地区、设备、新老用户的用户规模与占比
-- =============================================

-- ========== 1. 年龄段用户分布及占比 ==========
SELECT
    CASE
        WHEN age <= 20 THEN '20岁及以下'
        WHEN age > 20 AND age <= 30 THEN '21-30之间'
        WHEN age > 30 AND age <= 40 THEN '31-40之间'
        WHEN age > 40 THEN '41岁及以上'
    END AS `年龄段`,
    COUNT(*) AS `用户数`,
    CONCAT(ROUND(COUNT(*)/SUM(COUNT(*))OVER()*100, 2), '%') AS `占比`
FROM user_action_clean
GROUP BY `年龄段`;

-- ========== 2. 地区用户分布及占比 ==========
SELECT
    market AS `地区`,
    COUNT(*) AS `用户数`,
    CONCAT(ROUND(COUNT(*)/SUM(COUNT(*))OVER()*100, 2), '%') AS `占比`
FROM user_action_clean
GROUP BY market;

-- ========== 3. 访问设备用户分布及占比 ==========
SELECT
    device AS `访问设备`,
    COUNT(*) AS `用户数`,
    CONCAT(ROUND(COUNT(*)/SUM(COUNT(*))OVER()*100, 2), '%') AS `占比`
FROM user_action_clean
GROUP BY device;

-- ========== 4. 新老用户分布及占比 ==========
SELECT
    new_user AS `新老用户`,
    COUNT(*) AS `用户数`,
    CONCAT(ROUND(COUNT(*)/SUM(COUNT(*))OVER()*100, 2), '%') AS `占比`
FROM user_action_clean
GROUP BY new_user;
