use QLSACH
--Hi?n th? t�c gi? m� s? �i?n tho?i th? 3 l� s? 3 v� s? 8
Select*from TacGiaWhere sdt like '09[38]%'
--Hi?n th? t�c gi? m� s? �i?n tho?i th? 3 m� kh�ng ph?i l� s? 8
select *from TacGiawhere sdt like '09[^8]%'

select *from TacGiawhere sdt like '09[^8]%'

--hi?n th? ds m� kh�ng b?t �?u b?ng ch? T
select * from sach
where tensach like '[^T]%'

-- insert th�m d?ng d? li?u v�o trong b?ng s�ch, v?i c� m? KTMT , m? TL l� QTKD , manxb l� NXBKHKT
insert into Sach(MaSach,MaTL,MaXB) 
values(N'KTMT',N'QTKD',N'NXBKHKT');

-- cho bi?t nh?ng cu?n s�ch n�o ch�a c?p nh?t th�ng tin t�n s�ch 
select * from Sach where TenSach is not Null
-- cho bi?t nh?ng cu?n s�ch n�o m� �? c?p nh?t �?y �? th�ng tin t�c gi?
select s.*
from Sach s, TacGia tg ,Sach_TacGia stg
where (s.MaSach = stg.MaSach and tg.MaTG = stg.MaTG);
-- cho bi?t c�c s�ch m� c� s? trang l?n nh?t ,nh? nh?t trung b?nh
select * from sach
select max(sotrang) as sotranglonnhat,min(sotrang) as sotrangnhonhat, avg (sotrang) as tb
from sach
-- �?m s? s�ch theo t?ng th? lo?i
select MaTL, count(*) 
from Sach 
group by MaTL
-- �?m s? s�ch theo t?ng th? lo?i
select tl.MaTL , count(s.MaSach) sosach
from Sach s , TheLoai tl
where s.MaTL = tl.MaTL
group by tl.MaTL
-- Gom nh�m c� �i?u ki?n 
-- having dieu kien gom nhom 

--�?m s? s�ch theo t?ng th? lo?i , m� c� s? l�?ng >1
select tl.MaTL , count (s.MaSach) as DemSoSach
from Sach s,TheLoai tl
where s.MaTL=tl.MaTL
group by tl.MaTL
Having count (s.MaSach)>1 
---�?m s? s�ch theo t?ng th? lo?i ,m� c� s? l�?ng > 1 m� thu?c th? lo?i TH
SELECT    Sach.MaSach, Sach.TenSach, Sach.SoTrang, Sach.NgayXB, NhaXB.TenXB
FROM         Sach INNER JOIN
                      NhaXB ON Sach.MaXB = NhaXB.MaXB
WHERE     (Sach.SoTrang >= 50) OR
                      (NhaXB.TenXB = N'NXBGD')