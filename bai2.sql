-- 1. Phân tích kiến trúc (vì sao sai)

-- Giả sử query “hiện trường” của bạn dạng này:

-- SELECT 
--     hotel_id,
--     room_name,
--     MIN(price) AS min_price
-- FROM rooms
-- GROUP BY hotel_id;
-- ❌ Vấn đề cốt lõi

-- Bạn đang nói với database:

-- “Hãy gom tất cả phòng theo hotel_id, rồi trả về 1 dòng / khách sạn”

-- 👉 Nhưng lại yêu cầu thêm:

-- room_name
-- 🔥 Mâu thuẫn logic

-- Một khách sạn có nhiều phòng:

-- hotel_id	room_name	price
-- 1	Deluxe	1tr
-- 1	Standard	800k
-- 1	VIP	2tr

-- 👉 Sau GROUP BY hotel_id:

-- Chỉ còn 1 dòng cho hotel_id = 1
-- MIN(price) = 800k

-- ❗ Nhưng:

-- room_name là gì?
-- Deluxe?
-- Standard?
-- VIP?

-- ⛔ Không có câu trả lời duy nhất → vi phạm toán học

-- 💣 Vì sao MySQL 8 báo lỗi?
-- Trước đây MySQL “dễ dãi” → chọn random 😅
-- MySQL 8 Strict Mode:
-- 👉 Cấm luôn để tránh bug dữ liệu

-- 2. Câu truy vấn đúng

SELECT 
    hotel_id,
    MIN(price) AS min_price
FROM rooms
GROUP BY hotel_id;