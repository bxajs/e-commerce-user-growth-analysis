-- =============================================
-- 文件：overview_kpi.sql
-- 功能：经营总览核心指标 - SQL侧等价统计
-- 依赖表：user_action_clean
-- 说明：看板页面指标实际由PowerBI DAX度量实现，本脚本为数据库等效查询
-- 输出：user_total, order_user_cnt, overall_conversion, old_user_ratio
-- =============================================

SELECT
    COUNT(*) AS user_total,
    SUM(confirmation_page) AS order_user_cnt,
    ROUND(AVG(confirmation_page) * 100, 2) AS overall_conversion,
    ROUND(SUM(CASE WHEN new_user = 0 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS old_user_ratio
FROM user_action_clean;
