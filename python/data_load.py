import pandas as pd
from sqlalchemy import create_engine
password = "MYSQL_PASSWORD"
csv_path = "user_action_clean.csv"
df = pd.read_csv(csv_path, encoding="utf-8")
engine = create_engine(
    f"mysql+pymysql://root:{password}@localhost:3306/user_action_analysis?charset=utf8mb4"
)
df.to_sql(
    name="user_action",
    con=engine,
    if_exists="replace",
    index=False,
    chunksize=10000
)
print(" 导入完成！总共：", len(df), "条数据")
