--tích đề các
select s.*,tl.* 
from Sach s, TheLoai tl

--kết nối bằng
select s.*,tl.* 
from Sach s, TheLoai tl
where s.matl=tl.MaTL

--Viết inner join kết nối bằng (nội)

select s.*,tl.* 
from Sach s 
inner join TheLoai tl 
on s.MaTL=tl.MaTL

--Cho biết những sách nào có thông tin của tác giả (inner join)
SELECT * FROM dbo.Sach_TacGia
INNER JOIN TacGia
ON Sach_TacGia.MaTG = dbo.TacGia.MaTG
INNER JOIN dbo.Sach
ON Sach.MaSach = Sach_TacGia.MaSach

SELECT S.TenSach
FROM Sach s 
INNER JOIN Sach_TacGia stg 
ON s.MaSach = stg.MaSach 
INNER JOIN TacGia tg
ON stg.MaTG = tg.MaTG

SELECT        Sach.TenSach
FROM            Sach INNER JOIN
                         Sach_TacGia ON Sach.MaSach = Sach_TacGia.MaSach INNER JOIN
                         TacGia ON Sach_TacGia.MaTG = TacGia.MaTG
--Left join
--Hiển thị tất các sách trong bảng sách thông tin hiển thị masach, tensach, sotrang, tentl

select MaSach, TenSach, SoTrang, Theloai.TenTL from Sach s
left join TheLoai
on s.MaTL = TheLoai.MaTL

select s.*,tl.*
from Sach s left outer join TheLoai tl
on s.MaTL = tl.MaTL

select s.MaSach,s.TenSach,s.SoTrang,tl.MaTL
from Sach s
Left join TheLoai tl
on s.MaTL=tl.MaTL

select s.MaSach,s.TenSach,s.SoTrang, tl.TenTL
from Sach s
left join TheLoai tl
on s.MaTL=tl.MaTL

select * from TheLoai

select * from sach

--Hiển thị tất cả thể loại của các sách thông tin matl, tentl , tensach, sotrang

select tl.*,s.TenSach,s.SoTrang
from sach s right join TheLoai tl
on S.MaTL=tl.MaTL

select tl.*,s.TenSach,s.SoTrang
from TheLoai tl
right join Sach s
on s.MaTL=tl.MaTL

select tl.matl,tl.tentl,s.tensach,s.SoTrang
from TheLoai tl
right outer join Sach s
on tl.MaTL=s.MaTL

insert into TheLoai(MaTL,TenTL) values(N'MC',N'Khoa học dữ liệu');

--Hiển thị tất cả các sách và thể loại , thông tin hiển thị masach, tensach, sotarng,tentl
select s.MaSach,s.TenSach,s.SoTrang,tl.TenTL
from sach s
full join Theloai tl
on s.matl=tl.matl


--Pivot hiển thị Tên Sách và giá trị của NXBTH và NXBTK
select * from sach
SELECT TenSach,
[NXBTH], [NXBTK],[NXBGD]
FROM
(select s.TenSach,s.MaXB
from sach s,TacGia tg, Sach_TacGia stg
where s.MaSach=stg.MaSach and stg.MaTG=tg.MaTG ) AS BangNguon
PIVOT
(
count(maxb)
FOR maxb IN ([NXBTH], [NXBTK],[NXBGD])
) AS BangChuyen;


--Cho biết các sách mà chưa được viết bởi tác giả
-- 
select MaSach from sach
except
select MaSach from Sach_TacGia

--Cho biết các sách mà được viết bởi các tác giả

select MaSach
from Sach 
intersect
select MaSach
from Sach_TacGia

SELECT MaSach
FROM Sach
UNION ALL
SELECT Masach
FROM Sach_TacGia;


--Cho biết danh sách của các sách có thể loại tin học hoặc kế toán 
select masach,tensach from Sach
where matl='TH'
union
select masach,tensach from 
Sach s
where  s.MaTL = 'KT'

select masach,tensach from Sach
intersect
select masach,tensach from 
Sach s,TheLoai tl
where  s.MaTL = 'KT' or s.MaTL='TH'

--thêm 1 cột số giờ trong sach_tacgia
alter table Sach_TacGia
add SoGio int;

select * from Sach_TacGia

--Tìm sách mà có số giờ viết hoàn thành của tác giả lớn hơn 1 giờ
SELECT distinct s.MaSach, s.TenSach
FROM Sach s
INNER JOIN Sach_TacGia stg
ON s.MaSach = stg.MaSach
WHERE stg.SoGio > 1;

--viết bằng câu truy vấn
SELECT s.MaSach, s.TenSach
FROM Sach s
WHERE s.MaSach IN
 (SELECT stg.MaSach
 FROM Sach_TacGia stg
 WHERE stg.SoGio > 1);