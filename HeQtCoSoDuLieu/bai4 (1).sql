--Tìm sách mà có số giờ viết hoàn thành của tác giả lớn hơn 1 giờ
select * from Sach_TacGia

--viết cách bình thường
SELECT distinct s.MaSach, s.TenSach
FROM Sach s
INNER JOIN Sach_TacGia stg
ON s.MaSach = stg.MaSach
WHERE stg.SoGio > 1;


--tuong duong câu truy vấn con nằm ở where
SELECT s.MaSach, s.TenSach
FROM Sach s
WHERE s.MaSach IN
 (SELECT distinct stg.MaSach
 FROM Sach_TacGia stg
 WHERE stg.SoGio > 1)

 --Cho biết tổng số giờ viết sách của mỗi cuốn sách thông tin hiển thị masach, tensach, sotrang
 select * from Sach_TacGia

 --buoc 1 là tính tổng số giờ theo từng masach
 SELECT stg.MaSach, SUM(stg.SoGio) AS tong_so_gio_viet FROM Sach_TacGia stg GROUP BY stg.MaSach

 --viết lại thành câu truy vấn con 

 select s.MaSach,s.TenSach,s.SoTrang, sogio_viet_sach.tong_so_gio_viet
 from  sach s,(SELECT stg.MaSach, SUM(stg.SoGio) AS tong_so_gio_viet				FROM Sach_TacGia stg				GROUP BY stg.MaSach) as sogio_viet_sach
 where s.masach=sogio_viet_sach.MaSach

 ----Cho biết  số giờ lớn nhất của mỗi loại sách SELECT s.MaSach, s.TenSach,
							    (SELECT MAX(stg.SoGio)
								FROM Sach_TacGia stg
								WHERE s.MaSach = stg.MaSach) as sogiolonnhat
FROM Sach s;


SELECT        COUNT(MaSach) AS [số lượng sách], MaTL
FROM            Sach
GROUP BY MaTL

INSERT INTO Sach
                         (MaSach, TenSach, SoTrang)
VALUES        (N'KTKT', N'Kế toán kiểm toán', 10)


UPDATE       Sach
SET                TenSach = N'Kế toán kiểm toán VN', SoTrang = 9
WHERE        (MaSach = N'KTKT')

DELETE FROM Sach
WHERE        (MaSach = N'KTKT')


---Tạo view những  sách là tin học
create view sachth as
select * from sach
where matl='TH'

 drop view sachth

 select * from sachth

 --thay đổi view sachth sao cho tất cả các sách tin học chỉ có trang >=50 


 alter view sachth
 as 
 select * from sach
 where matl='th' and sotrang>=50

