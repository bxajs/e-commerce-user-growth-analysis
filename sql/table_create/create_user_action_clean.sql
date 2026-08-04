CREATE TABLE user_action_clean (
new_user TINYINT,
age INT,
sex VARCHAR(10),
market VARCHAR(50),
device VARCHAR(30),
operative_system VARCHAR(30),
source VARCHAR(30),
total_pages_visited INT,
home_page INT,
listing_page INT,
product_page INT,
payment_page INT,
confirmation_page INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
