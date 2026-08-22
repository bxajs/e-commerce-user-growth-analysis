-- =============================================
-- 文件：user_depth_analysis.sql
-- 功能：用户访问深度与转化率关联分析
-- 依赖表：user_depth_analysis
-- 对应看板：Page 3 转化分析 - 用户行为深度 vs 转化率
-- 输出：不同访问深度层级的用户数、购买用户数、对应转化率
-- =============================================

-- ========== 1. 各访问深度层级用户数量统计 ==========
SELECT
    depth_level,
    COUNT(new_user) AS user_count
FROM user_depth_analysis
GROUP BY depth_level;

-- ========== 2. 访问深度‑购买转化统计，自定义业务排序 ==========
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
