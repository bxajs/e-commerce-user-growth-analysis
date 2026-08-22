-- =============================================
-- 文件：channel_user_stats.sql
-- 功能：各流量渠道用户规模统计
-- 依赖表：user_action_clean
-- 对应看板：Page 1 经营总览 - 不同渠道用户规模
-- 输出：direct/organic/paid 三类渠道的用户数量
-- =============================================

SELECT
    source AS `流量渠道`,
    COUNT(*) AS `用户数`,
    CONCAT(ROUND(COUNT(*)/SUM(COUNT(*))OVER()*100, 2), '%') AS `占比`
FROM user_action_clean
GROUP BY source;
