use master
create database QLSACH
on
(
Name=QLSACH_Data,
filename='d:\QLSACH_Data.mdf',
size=10MB,
maxsize=100MB,
FileGrowth=10%
)
log on
(
Name=QLSACH_log,
filename='d:\QLSACH_Log.ldf',
size=2MB,
maxsize=UNLIMITED,
FileGrowth=10%
)

use QLSach
create table TheLoai
(
MaTL nchar(10) not null primary key,
TenTL nchar(100)
);

create table NhaXB
(
	MaXB nchar(20) not null primary key,
	TenXB nchar(100),
	DiaChi nchar(200),
	SDT nchar(10),
	email nchar(200)
);
create table Sach
(
	MaSach nchar(10) not null primary key,
	TenSach nchar(100),
	SoTrang int,
	NgayXB date,
	MaTL nchar(10),
	MaXB nchar(20),
	foreign key(MaTL) references TheLoai(MaTL),
	foreign key(MaXB) references NhaXB(MaXB)
	
	/*Khóa ngoại tham chiếu về bảng TheLoai*/
)
create table TacGia
(
	MaTG nchar(20) not null primary key,
	TenTG nchar(100),
	DiaChi nchar(200),
	SDT nchar(10),
	email nchar(200)
);

CREATE TABLE Sach_TacGia
(
	MaTG nchar(20) not null ,

	MaSach nchar(10) not null,
	constraint PK_SACH_TACGIA primary key (MaTG, MaSach),

	FOREIGN KEY (MaTG) REFERENCES TacGia (MaTG),
	FOREIGN KEY (MaSach) REFERENCES Sach (MaSach),
);

/* xoa database */
drop database QLSACH
/* thêm 1 cột vào table */
alter table Sach
add gia float

/*Thay đổi kiểu dữ của TenSach lên nvarchar(200) ký tự */
alter table Sach
alter column TenSach nvarchar(200)
/* xóa cột(thuộc tính) */
alter table Sach
drop column gia

alter table NhaXB
add constraint sdt_nhaxb_duynhat unique(SDT)
/* tạo bảng tochuc */

create table ToChuc
(
	matc nchar(10) not null primary key,
	tentochuc nchar(200)

)
alter table NhaXB
add matc nchar(10)
 
 alter table NhaXB
 add foreign key(matc) references ToChuc(matc);

 --DML
--Thêm mới dữ liệu vào bảng TheLoai
insert into TheLoai(MaTL,TenTL) values(N'TH',N'Tin học');
insert into TheLoai(MaTL,TenTL) values(N'KT',N'Kế toán');
insert into TheLoai(MaTL,TenTL) values(N'QTKD',N'Quản trị Kinh Doanh');
insert into TheLoai(MaTL,TenTL) values(N'TNN',N'Tài Nguyên Nước');
insert into TheLoai(MaTL,TenTL) values(N'KTMT',N'Kỹ thuật môi trường');
--Xem lại dữ liệu
select * from TheLoai

/* Thêm dữ liệu bảng NhaXB */
insert into NhaXB(MaXB,TenXB,DiaChi,SDT,email) values(N'NXBTH',N'Nhà xuất bản tổng hợp',N'12 Hai Bà 
Trưng. Hà Nội','0245678612','nxbtonghop@gmail.com');
insert into NhaXB(MaXB,TenXB,DiaChi,SDT,email) values(N'NXBGD',N'Nhà xuất bản giáo dục',N'14 Đống Đa. 
Hà Nội','0247646786','nxbgiaoduc@gmail.com');
insert into NhaXB(MaXB,TenXB,DiaChi,SDT,email) values(N'NXBTK',N'Nhà xuất bản thống kê',N'1 Bình Trị
Đông. TPHCM','0285638613','nxbthongke@gmail.com');
insert into NhaXB(MaXB,TenXB,DiaChi,SDT,email) values(N'NXBKHKT',N'Nhà xuất bản khoa học kỹ thuật',N'13 
Võ Văn Tần, TPHCM','0285678614','nxbkhkt@gmail.com')

--xem lại nhà xuất bản
select * from NhaXB
--Insert Sách
insert into Sach values(N'THDC',N'Tin học đại cương',N'20','01/01/2020',N'TH',N'NXBTH');
insert into Sach values(N'THVP',N'Tin học văn phòng',N'50','12/20/2020',N'TH',N'NXBTH');

select * from sach

SET DATEFORMAT dmy;

insert into Sach values(N'THKT',N'Tin học văn phòng cho kế toán',N'60','12/12/2020',N'TH',N'NXBGD');
insert into Sach values(N'THCT',N'Tin học văn phòng cho công trình',N'30','24/11/2019',N'TH',N'NXBGD');
insert into Sach values(N'KTDC',N'kế toán đại cương',N'40','30/10/2019',N'KT',N'NXBGD');
insert into Sach values(N'QTKDNLKD',N'Nguyên lý kinh doanh',N'90','31/7/2019',N'QTKD',N'NXBTH');
insert into Sach values(N'QTKDTLKD',N'Triết lý kinh doanh',N'90','30/9/2018',N'QTKD',N'NXBTK');
insert into Sach values(N'TNNCTN',N'Cấp thoát nước',N'40','30/08/2017',N'TNN',N'NXBTK');
insert into Sach values(N'KTMTCB',N'Kỹ thuật môi trường cơ bản',N'20','20/08/2017',N'KTMT',N'NXBKHKT');

select * from sach
SET DATEFORMAT dmy;

insert into Sach values(N'THKT',N'Tin học văn phòng cho kế toán',N'60','12/12/2020',N'TH',N'NXBGD');
insert into Sach values(N'THCT',N'Tin học văn phòng cho công trình',N'30','24/11/2019',N'TH',N'NXBGD');
insert into Sach values(N'KTDC',N'kế toán đại cương',N'40','30/10/2019',N'KT',N'NXBGD');
insert into Sach values(N'QTKDNLKD',N'Nguyên lý kinh doanh',N'90','31/7/2019',N'QTKD',N'NXBTH');
insert into Sach values(N'QTKDTLKD',N'Triết lý kinh doanh',N'90','30/9/2018',N'QTKD',N'NXBTK');
insert into Sach values(N'TNNCTN',N'Cấp thoát nước',N'40','30/08/2017',N'TNN',N'NXBTK');
insert into Sach values(N'KTMTCB',N'Kỹ thuật môi trường cơ bản',N'20','20/08/2017',N'KTMT',N'NXBKHKT');
select * from sach
--insert tac gia
insert into TacGia values(N'001',N'Phạm Hữu Độ',N'Hà Nội','0988888888','huudo@gmail.com');
insert into TacGia values(N'002',N'Phạm An Bình',N'HCM','0988675555','anbinh@gmail.com');
insert into TacGia values(N'003',N'Viên An',N'HCM','098122211','anvien@gmail.com');
insert into TacGia values(N'004',N'Viên Thanh Nhã',N'CT','093122221','nhavien@gmail.com');
--xem lại Tác giả
select * from TacGia
--insert bảng sach_tacgia
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'THDC');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'THVP');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'KTDC');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'TNNCTN');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'QTKDNLKD');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'THDC');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'THVP');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'TNNCTN');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'QTKDNLKD');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'KTMTCB');
insert into Sach_TacGia(MaTG,MaSach) values(N'003',N'THKT');
insert into Sach_TacGia(MaTG,MaSach) values(N'004',N'THKT');
insert into Sach_TacGia(MaTG,MaSach) values(N'004',N'KTDC');

--xem lại sach_tacgia

select * from sach_tacgia

--Xem lai tất cả cả các bảng
select * from TheLoai
select * from TacGia
select * from sach 
select * from sach_tacgia
select * from NhaXB

insert into TacGia values(N'005',N'Nguyễn Thanh Nhã',N'TV','093122222','nguyennhavien@gmail.com');

--Cập nhật lại thông tin địa chỉ của tác giả có mã số 005 thành địa chỉ mới là Cà mau
--Xóa thông tin của tác giả có mã số 005
DELETE FROM TacGia Where MaTG='005';

--SQL
--1 hiển thị ds các cuốn sách gồm có các thông tin sau : MaSach , Tensach , sotrang , ngaysx , matl , tentL
--c1
Select MaSach,TenSach,SoTrang,NgayXB,TheLoai.MaTL,TenTL
from Sach ,TheLoai
where TheLoai.MaTL = Sach.MaTL
--c3
SELECT *
from Sach ,TheLoai
Where Sach.MaTL = TheLoai.MaTL

--2 Hiển thị 3 dòng thông tin của sách và dữ liệu 
SELECT top 3 s.MaSach ,s.TenSach,s.SoTrang ,tl.TenTL
From Sach s,TheLoai tl
Where s.MaTL = tl.MaTL
--3 phép toán tử so sánh =, <,>hoặc !=,>,>=,<=,<>
-- between value 1 and value 2
--like
-- Hiện thị nhưng sách  mà số trang lớn hơn 50 thông tin hiển thị gồm có masach , tensach ,tenxb
select s.MaSach,s.TenSach,xb.TenXBfrom Sach s,NhaXB xbwhere s.MaXB=xb.MaXB And s.SoTrang>50

 -- Hiện thị nhưng sách  mà số trang != 50 thông tin hiển thị gồm có masach , tensach ,tenxb
 select s.MaSach,s.TenSach,xb.TenXBfrom Sach s,NhaXB xbwhere s.MaXB=xb.MaXB And s.SoTrang<>50 -- Hiện thị những sách  mà số trang nằm trong đoạn từ 20-60 trang thông tin hiển thị gồm có masach , tensach ,tenxb, sotrangselect s.MaSach,s.TenSach,xb.TenXBfrom Sach s,NhaXB xbwhere s.MaXB=xb.MaXB And s.SoTrang between 20 AND 60  -- Hiện thị những sách  mà số trang nằm trong đoạn từ 20 và nhỏ hơn 60 trang thông tin hiển thị gồm có masach , tensach ,tenxb, sotrang SELECT s.MaSach, s.TenSach, s.SoTrang, xb.TenXB 
 FROM Sach s, NhaXB xb 
 WHERE s.MaXB = xb.MaXB AND s.SoTrang >= 20 AND s.SoTrang < 60;
 -- Hiển thị những cuốn sách mà số trang khồng nằm trong từ 20-60 hoặc thuộc nhà xuất bản giáo dục
 --trang thông tin hiển thị gồm có masach ,tensach,so trang
Select s.MaSach,s.TenSach,s.SoTrang, nxb.TenXBfrom sach s, nhaxb nxbwhere s.maXB = nxb.maXB or( (s.SoTrang not between 20 AND 60 )and nxb.maxb='NXBGD')

--like
-- dấu % thay thế cho một chuỗi 
--hiển thị tên sách mà bắt đầu bằng chữ T, thông tin hiển thị masach, tensach ,tenxb ,sotrang

select s.MaSach, s.TenSach, s.SoTrang,xb.TenXB
from sach s,NhaXB xb
where s.MaXB=xb.MaXB and s.TenSach like 'T%'
--hiển thị tên sách mà bắt đầu bằng chữ o, thông tin hiển thị masach, tensach ,tenxb ,sotrang

select s.MaSach, s.TenSach, s.SoTrang,xb.TenXB
from sach s,NhaXB xb
where s.MaXB=xb.MaXB and s.TenSach like '%o%'
-- hiển thị tên sách mà bắt đầu bằng chữ g, thông tin hiển thị masach, tensach ,tenxb ,sotrang
select * from sachselect s.masach,s.TenSach,s.SoTrang,xb.TenXBfrom sach s, NhaXB xbwhere s.MaXB=xb.MaXB and rtrim(s.TenSach) like N'%g'
--dấu - đại diện cho 1 kí tự
-- hiển thị ds mà có mã sách có  2 kí tự đầu TH ,kí tự thứ 3 là bất kì, hiển thị masach, tensach ,tenxb ,sotrang
select s.MaSach, s.TenSach, s.SoTrang,xb.TenXB
from sach s,NhaXB xb
where s.MaXB=xb.MaXB and s.MaSach like N'TH_%'
