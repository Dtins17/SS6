-- 1. Vì sao NOT IN + NULL = “toang toàn bộ”?
-- Giả sử bạn viết:

-- WHERE room_id NOT IN (SELECT room_id FROM Bookings)

-- Nếu trong Bookings có chỉ 1 dòng room_id = NULL, thì tập con sẽ kiểu:
-- {101, 102, NULL}

-- Phân tích bằng logic (rất quan trọng)

-- Điều kiện:

-- room_id NOT IN (101, 102, NULL)

-- Tương đương:

-- room_id != 101
-- AND room_id != 102
-- AND room_id != NULL
-- ❌ Vấn đề nằm ở đây:
-- room_id != NULL  → UNKNOWN

-- Trong SQL:

-- So sánh với NULL → không TRUE, không FALSE → UNKNOWN
-- 👉 Toàn bộ biểu thức:
-- TRUE AND TRUE AND UNKNOWN = UNKNOWN

-- Trong WHERE:

-- Chỉ nhận TRUE
-- UNKNOWN bị loại

-- ⛔ ⇒ Kết quả: lọc hết → trả về 0 dòng

-- 2. Cách khắc phục an toàn
-- Cách 1: Lọc NULL trong subquery

SELECT room_id, room_name
FROM Rooms
WHERE room_id NOT IN (
    SELECT room_id 
    FROM Bookings
    WHERE room_id IS NOT NULL
);

-- Cách 2
SELECT r.room_id, r.room_name
FROM Rooms r
LEFT JOIN Bookings b 
    ON r.room_id = b.room_id
WHERE b.room_id IS NULL;