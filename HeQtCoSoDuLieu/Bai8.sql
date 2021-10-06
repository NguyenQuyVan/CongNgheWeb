select *
into Custom_noindex
from KhachHang

select *from 
KhachHang
insert into Custom_noindex values (N'003',N'Võ Huỳnh ',N'Hằng','0999999999',N'Hang@gmail.com')
insert into Custom_noindex values (N'004',N'Võ Thị ',N'Nga','0786687787',N'Nga@gmail.com')
select *from 
Custom_noindex

--tìm KH có mã 004
select * from Custom_noindex
where MaKH='004'
--tạo 1 cluster 
create clustered index index_clustered_maKH
on dbo.custom_noindex(MaKH);
--thực thi câu lệnh dạng cluster
select * from Custom_noindex
where MaKH='004'

select *
from KhachHang
where Email ='an@gmail.com'

--tạo non cluster cho email
create	nonclustered index id_custom_email
on KhachHang(email);

--tạo non 