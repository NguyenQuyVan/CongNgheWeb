﻿--Viết 1 sp đếm số lượng sách theo tên sách 

select * from sach
create proc DemSoLuongSachTheoTuaC1
@title nvarchar(50), @titlecount int output
as
begin
select masach
from sach
where tensach like '%'+@title + '%'
select @titlecount=@@ROWCOUNT;
end

declare @titlecount int;

exec DemSoLuongSachTheoTuaC1 N'T', @titlecount OUTPUT;

select @titlecount as SoluongSachTheoTua;
----
create proc DemSoLuongSachTheoTua
@title nvarchar(50), @titlecount int output
as
select @titlecount = count(*)
from sach
where tensach like '%'+@title + '%'

--gọi thủ tục
declare @titlecount int;

exec DemSoLuongSachTheoTua N'T', @titlecount OUTPUT;

select @titlecount as SoluongSachTheoTua;

--Kiểm tra sự tồn tại của sách dựa vào masach, sử dụng câu lệnh return
create procedure CheckMaSach(@masach nchar(10))
as
if exists(
   select  masach,tensach
   from sach
   where masach =@masach
)
begin
   print N'Trùng';
   return(1);
end
else
begin
	print N'Không Trùng';
    return(0);
end

--Cách gọi thủ tục có câu lệnh trả về
declare @masach nchar(10), @exists int;
set @masach = 'THVP'; --gán giá trị THDC cho biến @masach
exec @exists = CheckMaSach @masach;
if @exists = 0
begin
   select N'Không có sách nào có mã' + @masach as 'kết quả'
end
else
begin
   select N'Có ít nhất sách  có mã ' + @masach as 'kết quả'
end
--Trả về nhiều kết quả của câu lệnh SQL
create procedure multi
as
begin
	select * from sach where matl is not null;

	select masach
	from sach
	intersect
	select masach 
	from sach_tacgia

end

multi

---Kiểm tra sự tồn sp trong cơ sở dữ liệu
select*from sys.procedures
if exists(select*from sys.procedures where name='ex')
 print 'true';
else
 print 'false';

 --Có dùng object_id
 if object_id('ex') is not null 
    print 'true';
else
    print 'false';

if object_id('ex1') is not null 
    print 'true';
else
    print 'false';

--tạo ra 1 sp hiển thị danh sách các sách
create procedure showdatasach
as
begin
		select s.* 
		from sach s, theloai tl 
		where tl.matl=s.matl

end
showdatasach
alter procedure showdatasach
	as
		begin
		select s.*,tl.tentl 
		from sach s, theloai tl where tl.matl=s.matl
	end
showdatasach

create table KhachHang (

CREATE TABLE NhanVien (

create table DonDatHang (
create table ChiTietDonHang (
insert into KhachHang (MaKH,HoKH,TenKH,Phone,Email)

select * from khachhang

--insert dữ liệu vào DonDatHang	

insert into NhanVien(MaNV,HotenNV,GT,NS) values (N'0000000001' ,N'Viên Thanh NHã',N'Nam','1981-07-16') 
--Tạo 1 cột

--System function

--Cho biết danh sach các hiển thị masach, tensach,ngày xb
 select masach,tensach, day(NgayXB) as Ngay
 from sach
 where NgayXB is not null

 --Những sách nào mà xuất bản được 3 năm
 select masach,tensach, 2021-year(NgayXB) as nam
 from sach
 where (NgayXB is not null) and (2021-year(ngayxb))>=3
 --
 select GETDATE() as datehienhanh from sach

  --Những sách nào mà xuất bản được 3 năm
 select masach,tensach, year(getdate())-year(NgayXB) as nam
 from sach
 where (NgayXB is not null) and (year(getdate())-year(ngayxb))>=3
 
 --Tính chiều dài của chuỗi
 select masach, len(masach) as chieudai from sach

 --lower chuyển đổi thành chuỗi thường

 select masach, lower(tensach) as chieudai from sach

 --upper chuyển đổi thành chuỗi thường

 select masach, upper(tensach) as chieudai from sach

 --left,
 select left(masach,2) as kitu_trai
 from sach
 --right
 select right(rtrim(masach),2) as kitu_phai
 from sach
 --
 select * from sach

 --Lấy chuỗi mã sách bỏ kí tự đầu và kí tự cuối

select left(right(rtrim(masach),len(masach)-1),len(masach)-1) as ki_tu

select masach
from sach
where masach like rtrim('_%_') 

SELECT LEFT(RIGHT(rtrim(MaSach), LEN(rtrim(MaSach)) - 1), LEN(RIGHT(rtrim(MaSach), LEN(rtrim(MaSach)) - 1)) - 1) AS cat_trai_phai FROM Sach
select left(SUBSTRING(MaSach,2,LEN(MaSach) -1),len(SUBSTRING(MaSach,2,LEN(MaSach) -1)) - 1) from sach
select right(left(rtrim(masach),len(masach)-1),ltrim(LEN(masach)-2))
from Sach