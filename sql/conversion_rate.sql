-- =============================================
-- 文件：conversion_rate.sql
-- 功能：多维度转化率拆解对比
-- 依赖表：user_action_clean
-- 对应看板：Page 3 转化分析 - 渠道/地区/性别转化统计
-- 输出：渠道、地区、性别三个维度的用户规模与转化率
-- =============================================

SELECT
    source AS `流量渠道`,
    COUNT(*) AS `总用户数`,
    ROUND(AVG(confirmation_page)*100, 2) AS `最终转化率%`
FROM user_action_clean
GROUP BY source;

SELECT
    market AS `地区`,
    COUNT(*) AS `总用户数`,
    ROUND(AVG(confirmation_page)*100, 2) AS `最终转化率%`
FROM user_action_clean
GROUP BY market;

SELECT
    sex AS `性别`,
    COUNT(*) AS `总用户数`,
    ROUND(AVG(confirmation_page)*100, 2) AS `最终转化率%`
FROM user_action_clean
GROUP BY sex;
