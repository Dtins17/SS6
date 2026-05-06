-- 1. Ý tưởng logic (I/O & Luồng)
-- Mục tiêu

-- Với mỗi user_id, bạn cần tính 2 chỉ số cùng lúc:

-- Tổng số đơn → đếm tất cả
-- Số đơn bị hủy → chỉ đếm status = 'CANCELLED'
--  Vấn đề mấu chốt

--  COUNT(*) thì đếm được tất cả
--  Nhưng làm sao đếm riêng đơn bị hủy trong cùng GROUP?

--  Giải pháp chuẩn

-- Dùng:

-- SUM(CASE WHEN ... THEN 1 ELSE 0 END)
--  Cách hoạt động

-- Ví dụ dữ liệu:

-- user_id	status
-- 1	SUCCESS
-- 1	CANCELLED
-- 1	CANCELLED
--  Khi chạy:
-- SUM(CASE WHEN status = 'CANCELLED' THEN 1 ELSE 0 END)

-- → sẽ biến thành:

-- status	giá trị
-- SUCCESS	0
-- CANCELLED	1
-- CANCELLED	1

--  SUM = 2 

-- 2. Câu SQL hoàn chỉnh

SELECT 
    user_id,
    COUNT(*) AS total_orders,
    SUM(CASE 
        WHEN status = 'CANCELLED' THEN 1 
        ELSE 0 
    END) AS cancelled_orders
FROM bookings
GROUP BY user_id
HAVING 
    total_orders >= 10
    AND cancelled_orders > 5;
