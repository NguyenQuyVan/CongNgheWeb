--Câu truy vấn tương đương viết inner join
SELECT distinct s.MaSach, s.TenSach
FROM Sach s
INNER JOIN Sach_TacGia stg
ON s.MaSach = stg.MaSach
WHERE stg.SoGio > 10;
--cho biết tổng số giờ viết mỗi cuốn sách

SELECT s.TenSach, truyvancon1.tong_so_gio_viet
FROM Sach s,
 (SELECT stg.MaSach, SUM(stg.SoGio) AS tong_so_gio_viet
 FROM Sach_TacGia stg
 GROUP BY stg.MaSach) truyvancon1
WHERE truyvancon1.MaSach = s.MaSach;-- cho biết sách với số giờ lớn nhất của mỗi loại sáchSELECT s.MaSach, s.TenSach,
 (SELECT MAX(stg.SoGio)
 FROM Sach_TacGia stg
 WHERE s.MaSach = stg.MaSach) as truyvancon2
FROM Sach s;