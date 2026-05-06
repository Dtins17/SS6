-- revenue là bí danh (alias) của SUM(total_amount)
-- Nhưng:
-- WHERE chạy TRƯỚC SELECT
--  Lúc này chưa tồn tại revenue

--  Vì vậy:

-- WHERE revenue > 0

-- → Sai hoàn toàn về mặt thời điểm thực thi


CREATE DATABASE SalesDB;

USE SalesDB;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100),
    total_amount DECIMAL(12,2),
    order_date DATE
);

INSERT INTO orders (city, total_amount, order_date) VALUES
('Đà Nẵng', 2000000000, '2025-01-01'),
('Đà Nẵng', 3000000000, '2025-02-01'),
('Nha Trang', 1000000000, '2025-01-05'),
('Nha Trang', 2000000000, '2025-02-10'),
('Hà Nội', 0, '2025-03-01'),
('Hồ Chí Minh', 5000000000, '2025-03-15');

SELECT 
    city,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY city
HAVING SUM(total_amount) > 0;
