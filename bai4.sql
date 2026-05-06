-- 1. Luồng tư duy
--  Hướng 1: Lọc trễ (Bad Practice)
SELECT 
    hotel_id
FROM bookings
GROUP BY hotel_id
HAVING 
    SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) >= 50
    AND AVG(CASE 
        WHEN status = 'COMPLETED' THEN total_price 
        ELSE NULL 
    END) > 3000000;
    
--     Vấn đề của cách này
-- Database phải:
-- Đọc toàn bộ dữ liệu (kể cả CANCELLED, FAILED…)
-- Gom nhóm tất cả
-- Sau đó mới lọc

-- Tức là:

-- RAM: phải giữ nhiều dữ liệu hơn
-- CPU: phải tính toán trên dữ liệu “rác”
-- Rất tốn tài nguyên khi data lớn

-- Hướng 2: Lọc sớm

SELECT 
    hotel_id
FROM bookings
WHERE status = 'COMPLETED'
GROUP BY hotel_id
HAVING 
    COUNT(*) >= 50
    AND AVG(total_price) > 3000000;
 
--     Vì sao cách 2 tốt hơn
--     Execution Flow
-- Cách 2:
-- WHERE status = 'COMPLETED'
--  loại bỏ 70–90% dữ liệu ngay từ đầu
-- GROUP BY
--  chỉ xử lý dữ liệu cần thiết
-- HAVING
--  lọc điều kiện cuối cùng

-- So sánh hiệu năng
-- | Tiêu chí      | Cách 1 (Bad) | Cách 2 (Good)   |
-- | ------------- | ------------ | --------------- |
-- | Dữ liệu xử lý | 100%         | Chỉ dữ liệu cần |
-- | RAM           | Cao          | Thấp            |
-- | CPU           | Nặng         | Nhẹ             |
-- | Tốc độ        | Chậm         | Nhanh           |
-- | Tính rõ ràng  | Khó đọc      | Rõ ràng         |
