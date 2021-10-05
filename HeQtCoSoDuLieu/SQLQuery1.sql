use QLSACH
--Hi?n th? tác gi? mà s? ði?n tho?i th? 3 là s? 3 và s? 8
Select*from TacGiaWhere sdt like '09[38]%'
--Hi?n th? tác gi? mà s? ði?n tho?i th? 3 mà không ph?i là s? 8
select *from TacGiawhere sdt like '09[^8]%'

select *from TacGiawhere sdt like '09[^8]%'

--hi?n th? ds mà không b?t ð?u b?ng ch? T
select * from sach
where tensach like '[^T]%'

-- insert thêm d?ng d? li?u vào trong b?ng sách, v?i có m? KTMT , m? TL là QTKD , manxb là NXBKHKT
insert into Sach(MaSach,MaTL,MaXB) 
values(N'KTMT',N'QTKD',N'NXBKHKT');

-- cho bi?t nh?ng cu?n sách nào chýa c?p nh?t thông tin tên sách 
select * from Sach where TenSach is not Null
-- cho bi?t nh?ng cu?n sách nào mà ð? c?p nh?t ð?y ð? thông tin tác gi?
select s.*
from Sach s, TacGia tg ,Sach_TacGia stg
where (s.MaSach = stg.MaSach and tg.MaTG = stg.MaTG);
-- cho bi?t các sách mà có s? trang l?n nh?t ,nh? nh?t trung b?nh
select * from sach
select max(sotrang) as sotranglonnhat,min(sotrang) as sotrangnhonhat, avg (sotrang) as tb
from sach
-- ð?m s? sách theo t?ng th? lo?i
select MaTL, count(*) 
from Sach 
group by MaTL
-- ð?m s? sách theo t?ng th? lo?i
select tl.MaTL , count(s.MaSach) sosach
from Sach s , TheLoai tl
where s.MaTL = tl.MaTL
group by tl.MaTL
-- Gom nhóm có ði?u ki?n 
-- having dieu kien gom nhom 

--ð?m s? sách theo t?ng th? lo?i , mà có s? lý?ng >1
select tl.MaTL , count (s.MaSach) as DemSoSach
from Sach s,TheLoai tl
where s.MaTL=tl.MaTL
group by tl.MaTL
Having count (s.MaSach)>1 
---ð?m s? sách theo t?ng th? lo?i ,mà có s? lý?ng > 1 mà thu?c th? lo?i TH
SELECT    Sach.MaSach, Sach.TenSach, Sach.SoTrang, Sach.NgayXB, NhaXB.TenXB
FROM         Sach INNER JOIN
                      NhaXB ON Sach.MaXB = NhaXB.MaXB
WHERE     (Sach.SoTrang >= 50) OR
                      (NhaXB.TenXB = N'NXBGD')