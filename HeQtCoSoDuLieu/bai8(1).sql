select * 
into custom_noindex
from khachhang

select * from
khachhang
insert into custom_noindex values(N'003',N'Võ Huỳnh',N'Hằng','0999999999',N'hang@gmail.com');
insert into custom_noindex values(N'004',N'Võ Thị',N'Nga','0989999999',N'nga@gmail.com');
select * from
custom_noindex

--Tìm khách hàng có mã khách hàng 004
select * from custom_noindex
where makh='004'

--tạo 1 cluster
create clustered index index_cluster_makh
on dbo.custom_noindex(MaKH);
--Thực thi câu lệnh dạng cluster
select * from custom_noindex
where makh='004'

--Minh họa non clustered

--Tìm kiếm khách hàng có email là an@gmail.com
select * 
from khachhang
where email ='an@gmail.com' 


--tạo non cluster cho email
create nonclustered index id_custom_email
on Khachhang(email);

select * 
from khachhang
where email ='an@gmail.com' 

--Tạo non cluster 
create nonclustered index id_custom_ho_ten
on Khachhang(hokh,tenkh);
--Đổi tên id_custom_email thành index_custom_email
exec sp_rename	N'KhachHang.id_custom_email',	N'ix_cust_email',	N'INDEX';


--Xóa mà có kiểm tra điều kiện tồn tại  IF EXISTS (SELECT *  FROM sys.indexes  WHERE name='ix_cust_email'     AND object_id = OBJECT_ID('dbo.KhachHang'))  begin    DROP INDEX ix_cust_email ON dbo.KhachHang;  end  if exists(select * from sys.indexes where object_id('dbp.khachhang') is not null )drop index id_custom_email on dbo.khachhang
IF object_id(N'id_custom_email') IS NOT NULL    DROP index id_custom_email on dbo.khachhangGO
--tạo cluster dạng unique
create unique index email_custom_unique
on khachhang(email)
--Tạo index unique kết hợp nhiều thuộc tính
create unique index hoten_unique
on khachhang(email)
include(hokh,tenkh)
 
