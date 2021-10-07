﻿select * 
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
exec sp_rename



IF object_id(N'id_custom_email') IS NOT NULL
--tạo cluster dạng unique
create unique index email_custom_unique
on khachhang(email)
--Tạo index unique kết hợp nhiều thuộc tính
create unique index hoten_unique
on khachhang(email)
include(hokh,tenkh)
 