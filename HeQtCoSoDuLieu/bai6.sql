--Viết 1 sp đếm số lượng sách theo tên sách 

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

create table KhachHang (	MaKH nvarchar(10) not null primary key,	HoKH nvarchar(100),	TenKH nvarchar(100),	Phone nvarchar(10),	Email nvarchar(200))

CREATE TABLE NhanVien (	MaNV NVARCHAR(10) NOT NULL PRIMARY KEY,	HotenNV NVARCHAR(50),	GT NVARCHAR(5),	NS DATE,	MaNVQL NVARCHAR(10)	FOREIGN KEY (MaNVQL) REFERENCES NhanVien(MaNV));

create table DonDatHang (	SoDH nvarchar(10) not null primary key,	NgayDH datetime,	TrangThaiDH int,	MaKH nvarchar(10),	NgayDuKienGiao datetime,	NgayThucTeGiao datetime,	MaNV nvarchar(10),	foreign key (MaKH) references KhachHang(MaKH),	foreign key (MaNV) references NhanVien(MaNV))
create table ChiTietDonHang (	ID_item int not null primary key,	SoDH nvarchar(10),	MaSach nchar(10),	SoLuong int,	GiaTien float,	GiamGia float,	foreign key (SoDH) references DonDatHang(SoDH),	foreign key (MaSach) references Sach(MaSach) )
insert into KhachHang (MaKH,HoKH,TenKH,Phone,Email)values ('001',N'Nguyễn Văn','An','098899999','an@gmail.com'),		('002',N'Lưu Bình',N'Nguyên','0978977777','nguyen@gmail.com')

select * from khachhang

--insert dữ liệu vào DonDatHang	insert into DonDatHang(SoDH,NgayDH,TrangThaiDH,MaKH,NgayDuKienGiao) values (N'001','2020-10-20 09:00:00','1','001','2020-10-20 09:00:00');insert into DonDatHang(SoDH,NgayDH,TrangThaiDH,MaKH,NgayDuKienGiao) values (N'002','2020-12-20 09:00:00','0','002','2020-12-20 09:00:00');--issert dữ liệu vào ChiTietDHinsert into ChiTietDonHang(ID_item,SoDH,MaSach,SoLuong,GiaTien,GiamGia) values(N'1','001',N'KTDC','10','30000','0.1');insert into ChiTietDonHang(ID_item,SoDH,MaSach,SoLuong,GiaTien,GiamGia) values(N'2','001',N'KTMT','5','20000','0.2');insert into ChiTietDonHang(ID_item,SoDH,MaSach,SoLuong,GiaTien,GiamGia) values(N'3','002',N'KTMTCB','2','40000','0.5');insert into ChiTietDonHang(ID_item,SoDH,MaSach,SoLuong,GiaTien,GiamGia) values(N'4','002',N'THVP','1','35000','0.4');

insert into NhanVien(MaNV,HotenNV,GT,NS) values (N'0000000001' ,N'Viên Thanh NHã',N'Nam','1981-07-16') insert into NhanVien(MaNV,HotenNV,GT,NS) values (N'0000000002' ,N'Trần Thanh An ',N'Nam','1978-08-20') insert into NhanVien(MaNV,HotenNV,GT,NS) values (N'0000000003' ,N'Nguyễn Tâm Như',N'Nữ','1990-10-10')
--Tạo 1 cộtalter table Sachadd GiaSach float

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

select left(right(rtrim(masach),len(masach)-1),len(masach)-1) as ki_tufrom sach

select masach
from sach
where masach like rtrim('_%_') 

SELECT LEFT(RIGHT(rtrim(MaSach), LEN(rtrim(MaSach)) - 1), LEN(RIGHT(rtrim(MaSach), LEN(rtrim(MaSach)) - 1)) - 1) AS cat_trai_phai FROM Sach
select left(SUBSTRING(MaSach,2,LEN(MaSach) -1),len(SUBSTRING(MaSach,2,LEN(MaSach) -1)) - 1) from sach
select right(left(rtrim(masach),len(masach)-1),ltrim(LEN(masach)-2))
from Sach
