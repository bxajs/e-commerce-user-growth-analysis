import pandas as pd
df = pd.read_csv("E:\Data\用户行为数据\用户行为分析.csv")
print(f"清洗前行数：{len(df)}")
print("=== 各字段缺失值数量 ===")
print(df.isnull().sum())
df = df.dropna(subset=['sex', 'source', 'device', 'operative_system'])
df = df[
    (df['sex'] != '0') &
    (df['source'] != '0') &
    (df['device'] != '0') &
    (df['operative_system'] != '0') &
    (df['age'] > 0) & (df['age'] < 100)
]
q99 = df['total_pages_visited'].quantile(0.99)
df = df[df['total_pages_visited'] <= q99]
print("\n=== 清洗后数据量 ===")
print(f"清洗后行数：{len(df)}")
df.to_csv("user_action_clean.csv", index=False)
print("\n清洗完成！")


df = pd.read_csv("user_action_clean.csv")
print(df.head())
print(df.info())
print(df.describe())
