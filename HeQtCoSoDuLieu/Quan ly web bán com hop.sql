use master
go
create database QuanLyWebBanComHop
On
(
Name= QuanLyWebBanComHop_Data,

Filename='E:\Temp\QuanLyWebBanComHop_Data.mdf',
size = 10MB,
MaxSize=100MB,
FileGrowth=10%
)
Log On
(
Name= QuanLyWebBanComHop_Log,
size = 2MB,
MaxSize=unlimited,
FileGrowth=10%
)
use QuanLyWebBanComHop
/*tạo bảng Khách Hàng*/
create table KH
(
	MaKH nchar(10) not null primary key,
	DiaChiKH nchar(200),
	TenKH nchar(100),
	sdtKH nchar(11),
)
/*tạo bảng hóa đơn*/
create table HoaDon
(
	MaHoaDon nchar(10) not null primary key,
	TenMonAn nchar(100),
	SoLuong int,
	ThanhToan int,
	NgayLapHoaDon date,
	MaKH nchar(10),
	foreign key(MaKH) references KH(MaKH)
)
/*tạo bảng Phiếu Hẹn */
create table PhieuHen
(
	MaPhieuHen nchar(10) not null primary key,
	NgaylapPhieu date,
	NgayGiaoCom date,
	MaKH nchar(10),
	foreign key(MaKH) references KH(MaKH)
)
/*tạo bảng Cửa Hàng bán cơm */
create table CuaHang
(
	MaCuaHang nchar(10) not null primary key,
	TenCuaHang nchar(100),
	DiaChiCuaHang nchar(200),
	sdt nchar(11),
)
/*tạo bảng Đơn đặt hàng */
create table DonDatHang
(
	MaDatHang nchar(10) not null primary key,
	NgayDatHang date,
	MaCuaHang nchar(10),
	foreign key (MaCuaHang) references CuaHang(MaCuaHang)
)
/*tạo bảng Phiếu Giao hàng */
create table PhieuGiaoHang
(
	MaPhieuGiaoHang nchar(10) not null primary key,
	MaDatHang nchar(10),
	NgayGiaoHang date,
	TG time,
	DiaChiKH nchar(200),
	foreign key (MaDatHang) references DonDatHang(MaDatHang)
)
/*tạo bảng NV Giao hàng */
create table NV_GH
(
	MaPhieuGiaoHang nchar(10) not null,
	MaPhieuHen nchar(10) not null,
	TenNV nchar(100),
	sdt nchar(11),
	constraint PK_NV_GH primary key (MaPhieuGiaoHang, MaPhieuHen)
);
alter table NV_GH
 add constraint FK_NVGH_PhieuGiaoHang foreign key (MaPhieuGiaoHang)
	references PhieuGiaoHang(MaPhieuGiaoHang)
go

alter table NV_GH
 add constraint FK_NVGH_PhieuHen foreign key (MaPhieuHen)
	references PhieuHen(MaPhieuHen)
go
/*tạo bảng loại món ăn */
create table LoaiMonAn
(
	MaLoaiMonAn nchar(10) not null primary key,
	MaCuaHang nchar(10),
	TenLoai nchar(100),
	foreign key (MaCuaHang) references CuaHang(MaCuaHang)
)
/*tạo bảng món ăn */
create table MonAn
(
	MaMonAn nchar(100) not null primary key,
	MaLoaiMonAn nchar(10),
	TenMonAn nchar(100),
	ThongTinMonAn nchar(200),
	foreign key (MaLoaiMonAn) references LoaiMonAn(MaLoaiMonAn)
);
/*tạo bảng ComBo món ăn*/
create table ComBo
(	
	MaComBo nchar(10) not null primary key,
	MaCuaHang nchar(10),
	GiaKhuyenMai int,
	MonPhuAnKem nchar(200),
	SoLuong int,
	foreign key (MaCuaHang) references CuaHang(MaCuaHang)
);
alter table KH
add constraint sdt_duynhat unique(sdt);

/*thêm dữ liệu bảng khách hàng*/
insert into KH (MaKH,DiaChiKH,TenKH,sdtKH) values (N'0001',N'38/7 Đình phong phú Q9',N'Nguyễn Xuân Hương',N'0123456789');
insert into KH (MaKH,DiaChiKH,TenKH,sdtKH) values (N'0002',N'02/7 Đặng Thùy Trâm Q.BThạnh',N'Nguyễn Thị Diệu',N'0213654987');
insert into KH (MaKH,DiaChiKH,TenKH,sdtKH) values (N'0003',N'151/33 Tam Bình TP.Thủ Đức',N'Nguyễn Hữu Mỹ',N'0321456987');
insert into KH (MaKH,DiaChiKH,TenKH,sdtKH) values (N'0004',N'80/9 Đình phong phú Q9',N'Bùi Thị bé Tiên',N'04123567889');
insert into KH (MaKH,DiaChiKH,TenKH,sdtKH) values (N'0005',N'49/13 Tam Phú TP.Thủ Đức',N'Trần Quang Huy',N'0532164987');
/*thêm dữ liệu bảng Hóa Đơn*/
SET DATEFORMAT dmy;
insert into HoaDon values(N'0258',N'Sườn nướng mật ong,ba rọi nướng, canh rong biển','1','80000','01/02/2021',N'0001');
insert into HoaDon values(N'0259',N'Sườn nướng mật ong,bì,chả, canh rong biển,sprite,khăn','3','276000','02/02/2021',N'0002');
insert into HoaDon values(N'0260',N'Sườn nướng mật ong,ba rọi nướng','1','60000','03/02/2021',N'0003');
insert into HoaDon values(N'0261',N'Sườn nướng mật ong,Trứng Chiên,Chả,Sâm bí đao, canh rong biển,Khăn Lạnh','2','174000','10/02/2021',N'0004');
insert into HoaDon values(N'0262',N'Sườn nướng mật ong,Bì,coca','1','60000','15/02/2021',N'0005');
/*thêm dữ liệu bảng Phiếu hẹn */
SET DATEFORMAT dmy;
insert into PhieuHen values(N'MPH5','01/02/2021','02/02/2021',N'0001')
insert into PhieuHen values(N'MPH6','02/02/2021','03/02/2021',N'0002')
insert into PhieuHen values(N'MPH7','03/02/2021','04/02/2021',N'0003')
insert into PhieuHen values(N'MPH8','10/02/2021','12/02/2021',N'0004')
insert into PhieuHen values(N'MPH9','15/02/2021','16/02/2021',N'0005')
/*thêm dữ liệu bảng cửa hàng bán cơm*/
insert into CuaHang values (N'CTKD1',N'Cơm Tấm kì duyên chi nhánh 1',N'50/100 Tô ngọc vân ,tp Thủ Đức',N'0255477688')
insert into CuaHang values (N'CTHP2',N'Cơm Tấm Hạnh Phúc chi nhánh 2',N'33/25 Kha Vạn Cân ,tp Thủ Đức',N'0155677988')
insert into CuaHang values (N'CTPH3',N'Cơm Tấm Phúc Hữu chi nhánh 3',N'66/10 Nguyễn hữu cảnh ,tp Thủ Đức',N'0355177888')
/*thêm dữ liệu bảng Đơn đặt hàng*/
insert into DonDatHang values (N'MDH15','01/02/2021',N'CTKD1');
insert into DonDatHang values (N'MDH16','02/02/2021',N'CTHP2');
insert into DonDatHang values (N'MDH17','03/02/2021',N'CTPH3');
insert into DonDatHang values (N'MDH18','10/02/2021',N'CTHP2');
insert into DonDatHang values (N'MDH19','15/02/2021',N'CTKD1');
/*thêm dữ liệu bảng Phiếu giao hàng*/
insert into PhieuGiaoHang values (N'MPGH1',N'MDH15','02/02/2021','10:30:05','38/7 Đình phong phú Q9');
insert into PhieuGiaoHang values (N'MPGH2',N'MDH16','02/02/2021','14:30:15','02/7 Đặng Thùy Trâm Q.BThạnh');
insert into PhieuGiaoHang values (N'MPGH3',N'MDH17','02/02/2021','11:45:05','151/33 Tam Bình TP.Thủ Đức');
insert into PhieuGiaoHang values (N'MPGH4',N'MDH18','02/02/2021','15:59:30','80/9 Đình phong phú Q9');
insert into PhieuGiaoHang values (N'MPGH5',N'MDH19','02/02/2021','07:30:40','49/13 Tam Phú TP.Thủ Đức');
/*thêm dữ liệu bảng Nhân viên giao hàng*/
insert into NV_GH values (N'MPGH1',N'MPH5',N'Lê hoài Long',N'0155498762')
insert into NV_GH values (N'MPGH2',N'MPH6',N'Lê hoài Long',N'0155498762')
insert into NV_GH values (N'MPGH3',N'MPH7',N'Lê hoài Long',N'0155498762')
insert into NV_GH values (N'MPGH4',N'MPH8',N'Trương Băng Băng ',N'0155498762')
insert into NV_GH values (N'MPGH5',N'MPH9',N'Trương Băng Băng',N'0156558651')
/*thêm dữ liệu bảng loại món ăn*/
insert into LoaiMonAn values(N'MONCHINH1',N'CTKD1',N'món chính (nướng)');
insert into LoaiMonAn values(N'MONCHINH2',N'CTHP2',N'món chính (nướng)');
insert into LoaiMonAn values(N'MONCHINH3',N'CTPH3',N'món chính (nướng)');
insert into LoaiMonAn values(N'MONCANH1',N'CTKD1',N'món phụ(canh)');
insert into LoaiMonAn values(N'MONCANH2',N'CTHP2',N'món phụ(canh)');
insert into LoaiMonAn values(N'MONCANH3',N'CTPH3',N'món phụ(canh)');
insert into LoaiMonAn values(N'MONANKEM1',N'CTKD1',N'món phụ ăn kèm');
insert into LoaiMonAn values(N'MONANKEM2',N'CTHP2',N'món phụ ăn kèm');
insert into LoaiMonAn values(N'MONANKEM3',N'CTPH3',N'món phụ ăn kèm');
insert into LoaiMonAn values(N'GIAIKHAT1',N'CTKD1',N'giải khát');
insert into LoaiMonAn values(N'GIAIKHAT2',N'CTHP2',N'giải khát');
insert into LoaiMonAn values(N'GIAIKHAT3',N'CTPH3',N'giải khát');
insert into LoaiMonAn values(N'VESINH1',N'CTKD1',N'vệ sinh sau khi ăn');
insert into LoaiMonAn values(N'VESINH2',N'CTHP2',N'vệ sinh sau khi ăn');
insert into LoaiMonAn values(N'VESINH3',N'CTPH3',N'vệ sinh sau khi ăn');
/*thêm dữ liệu bảng món ăn*/
insert into MonAn values (N'1000',N'MONCHINH1',N'Sường Nướng Mật ong mềm',N'30000/1phan');
insert into MonAn values (N'2000',N'MONCHINH2',N'Sường Nướng Mật ong mềm',N'30000/1phan');
insert into MonAn values (N'3000',N'MONCHINH3',N'Sường Nướng Mật ong mềm',N'30000/1phan');
insert into MonAn values (N'1001',N'MONCHINH1',N'Ba rọi nướng mật ong',N'30000/1phan');
insert into MonAn values (N'2001',N'MONCHINH2',N'Ba rọi nướng mật ong',N'30000/1phan');
insert into MonAn values (N'3001',N'MONCHINH3',N'Ba rọi nướng mật ong',N'30000/1phan');
insert into MonAn values (N'1002',N'MONCANH1',N'Canh rong biển',N'15000/1phan');
insert into MonAn values (N'2002',N'MONCANH2',N'Canh rong biển',N'15000/1phan');
insert into MonAn values (N'3002',N'MONCANH3',N'Canh rong biển',N'15000/1phan');
insert into MonAn values (N'1003',N'MONANKEM1',N'Trứng chiên',N'10000/1phan');
insert into MonAn values (N'2003',N'MONANKEM2',N'Trứng chiên',N'10000/1phan');
insert into MonAn values (N'3003',N'MONANKEM3',N'Trứng chiên',N'10000/1phan');
insert into MonAn values (N'1004',N'MONANKEM1',N'Chả',N'15000/1phan');
insert into MonAn values (N'2004',N'MONANKEM2',N'Chả',N'15000/1phan');
insert into MonAn values (N'3004',N'MONANKEM3',N'Chả',N'15000/1phan');
insert into MonAn values (N'1005',N'MONANKEM1',N'Bì',N'15000/1phan');
insert into MonAn values (N'2005',N'MONANKEM2',N'Bì',N'15000/1phan');
insert into MonAn values (N'3005',N'MONANKEM3',N'Bì',N'15000/1phan');
insert into MonAn values (N'1006',N'GIAIKHAT1',N'coca',N'15000/1phan');
insert into MonAn values (N'2006',N'GIAIKHAT2',N'coca',N'15000/1phan');
insert into MonAn values (N'3006',N'GIAIKHAT3',N'coca',N'15000/1phan');
insert into MonAn values(N'1007',N'GIAIKHAT1',N'Sprite',N'15000/1phan');
insert into MonAn values(N'2007',N'GIAIKHAT2',N'Sprite',N'15000/1phan');
insert into MonAn values(N'3007',N'GIAIKHAT3',N'Sprite',N'15000/1phan');
insert into MonAn values(N'1008',N'GIAIKHAT1',N'Sâm bí đao',N'10000/1phan');
insert into MonAn values(N'2008',N'GIAIKHAT2',N'Sâm bí đao',N'10000/1phan');
insert into MonAn values(N'3008',N'GIAIKHAT3',N'Sâm bí đao',N'10000/1phan');
insert into MonAn values(N'1009',N'VESINH1',N'Khăn lạnh',N'2000/1cai');
insert into MonAn values(N'2009',N'VESINH2',N'Khăn lạnh',N'2000/1cai');
insert into MonAn values(N'3009',N'VESINH3',N'Khăn lạnh',N'2000/1cai');
/*thêm dữ liệu bảng  Combo món ăn*/
insert into ComBo values(N'COMBOSUON',N'CTKD1',N'55000',N'Sườn nướng,Canh rong biển,Khăn lạnh,coca',N'1')
insert into ComBo values(N'CBMOTNGUOI',N'CTKD1',N'67000',N'Sườn(ba rọi),trứng(bì,chả),Canh rong biển,Khăn lạnh,coca(suprite,sâm bí đao)',N'1')
insert into ComBo(MaComBo,MaCuaHang,GiaKhuyenMai,MonPhuAnKem,SoLuong) values(N'CBHAINGUOI',N'CTKD1',N'154000',N'Sườn(ba rọi),trứng(bì,chả),Canh rong biển,Khăn lạnh,coca(sâm,sprite)',N'2')
insert into ComBo values(N'COMBOSUON2',N'CTHP2',N'55000',N'Sườn nướng,Canh rong biển,Khăn lạnh,coca',N'1')
insert into ComBo values(N'CBMOTNGUO2',N'CTHP2',N'67000',N'Sườn(ba rọi),trứng(bì,chả),Canh rong biển,Khăn lạnh,coca(suprite,sâm bí đao)',N'1')
insert into ComBo(MaComBo,MaCuaHang,GiaKhuyenMai,MonPhuAnKem,SoLuong) values(N'CBHAINGUO2',N'CTHP2',N'154000',N'Sườn(ba rọi),trứng(bì,chả),Canh rong biển,Khăn lạnh,coca(sâm,sprite)',N'2')
insert into ComBo values(N'COMBOSUON3',N'CTPH3',N'55000',N'Sườn nướng,Canh rong biển,Khăn lạnh,coca',N'1')
insert into ComBo values(N'CBMOTNGUO3',N'CTPH3',N'67000',N'Sườn(ba rọi),trứng(bì,chả),Canh rong biển,Khăn lạnh,coca(suprite,sâm bí đao)',N'1')
insert into ComBo(MaComBo,MaCuaHang,GiaKhuyenMai,MonPhuAnKem,SoLuong) values(N'CBHAINGUO3',N'CTPH3',N'154000',N'Sườn(ba rọi),trứng(bì,chả),Canh rong biển,Khăn lạnh,coca(sâm,sprite)',N'2')
/*Xem Lại thông tin của từng bảng */
select * from PhieuHen
select * from ComBo
select * from DonDatHang
select * from HoaDon
select * from KH
select * from LoaiMonAn
select * from CuaHang
select * from MonAn
select * from NV_GH
select * from PhieuGiaoHang
/*Cập nhật dữ liệu trên bảng */
Update KH
	Set TenKH=N'Trần Huy Quang'
	where MaKH=N'0005'
select * from KH
Update KH
	set sdt=N'0123456666'
	where MaKH=N'0001'
select * from KH
/*Viết ít nhất 2 câu lệnh xóa dữ liệu trên các bảng */
insert into LoaiMonAn values (N'SUONNON',N'CTKD1',N'Sườn non nướng mật ong')

delete from LoaiMonAn where (MaLoaiMonAn=N'SUONNON'and MaCuaHang=N'CTKD1' and TenLoai=N'Sườn non nướng mật ong');

alter table LoaiMonAn
add Gia int 

alter table LoaiMonAn
drop column Gia

/*Viết ít nhất 2 câu lệnh truy vấn điều kiện where  */

select *
from KH a , HoaDon b
where a.MaKH=b.MaKH
/*Hiển thị Combo của từng chi nhánh và lớn hơn 55.000 ngàn */

select C.MaComBo ,C.GiaKhuyenMai,C.MonPhuAnKem,C.SoLuong,CH.TenCuaHang,CH.DiaChiCuaHang
from ComBo C, CuaHang CH
where C.MaCuaHang=CH.MaCuaHang and C.GiaKhuyenMai>55000
/*Hiển thị Combo của từng chi nhánh và trong Combo có thể được chọn trứng */
select C.MaComBo ,C.GiaKhuyenMai,C.MonPhuAnKem,C.SoLuong,CH.TenCuaHang,CH.DiaChiCuaHang
from ComBo C, CuaHang CH
where C.MaCuaHang=CH.MaCuaHang and (C.MonPhuAnKem like N'%trứng%')

/*Viết ít nhất 2 câu lệnh truy vấn điều kiện where + gruop by */
/*Đếm số món ăn của mỗi chi nhánh */
select M.ThongTinMonAn,N.TenCuaHang, COUNT(M.TenMonAn) as SoMonAn
from MonAn M,LoaiMonAn L,CuaHang N
where M.MaLoaiMonAn=L.MaLoaiMonAn and L.MaCuaHang=N.MaCuaHang
Group By M.ThongTinMonAn,N.TenCuaHang

/*Đếm số Nhân viên giao hàng cho mỗi khách */
select c.TenKH,a.TenNV,COUNT(a.TenNV) as soNV
from NV_GH a, PhieuHen b,KH c
where a.MaPhieuHen=b.MaPhieuHen and b.MaKH=c.MaKH
group by c.TenKH ,a.TenNV

/*Đếm số MÓN ĂN trong từng loại lớn hơn hoặc bằng 6*/
select b.TenLoai,COUNT(a.TenMonAn) as soMon
from MonAn a,LoaiMonAn b
where a.MaLoaiMonAn=b.MaLoaiMonAn
group by b.TenLoai

/*-Viết ít nhất 2 câu truy vấn sử dụng đều kiện where + group by + order by*/
select b.TenLoai,COUNT(a.TenMonAn) as soMon
from MonAn a,LoaiMonAn b
where a.MaLoaiMonAn=b.MaLoaiMonAn
group by b.TenLoai
having COUNT(a.TenMonAn)>=1
order by soMon ASC;

/*Đếm tên loại món ăn của cửa hàng mỗi chi nhánh và sắp xếp giảm dần*/
select b.TenCuaHang,COUNT(a.TenLoai) as soloaimonan
from LoaiMonAn a,CuaHang b
where a.MaCuaHang=b.MaCuaHang
group by b.TenCuaHang
order by soloaimonan desc;

/*Viết ít nhất 2 câu truy vấn sử dụng đều kiện gom nhóm có đều kiện*/
/*Đếm số MÓN ĂN trong từng loại lớn hơn hoặc bằng 6*/
select b.TenLoai,COUNT(a.TenMonAn) as soMon
from MonAn a,LoaiMonAn b
where a.MaLoaiMonAn=b.MaLoaiMonAn
group by b.TenLoai
having COUNT(a.TenMonAn)>=6

/*Đếm số món ăn của mỗi chi nhánh > 0*/
select L.TenLoai,M.ThongTinMonAn,N.TenCuaHang, COUNT(M.TenMonAn) as SoMonAn
from MonAn M,LoaiMonAn L,CuaHang N
where M.MaLoaiMonAn=L.MaLoaiMonAn and L.MaCuaHang=N.MaCuaHang
Group By M.ThongTinMonAn,N.TenCuaHang,L.TenLoai
having count(M.TenMonAn)>0

/*- Viết ít nhất 2 câu truy vấn sử dụng đều kiện left join, full join, right join, full outer join*/
/*Viết ít nhất 2 câu truy vấn sử dụng đều kiện left join*/
select a.TenKH,b.NgayGiaoCom,b.MaKH,a.DiaChiKH
from KH a left outer join PhieuHen b on a.MaKH=b.MaKH;

select b.MaKH,a.TenKH,b.TenMonAn,b.ThanhToan
from KH a left outer join HoaDon b on a.MaKH=b.MaKH;

/*Viết ít nhất 2 câu truy vấn sử dụng đều kiện right join*/
select a.MaPhieuGiaoHang,a.TG,b.NgayDatHang
from PhieuGiaoHang a right outer join DonDatHang b on a.MaDatHang=b.MaDatHang

select a.MaHoaDon,a.SoLuong,a.TenMonAn,b.TenKH,b.DiaChiKH
from HoaDon a right outer join KH b on a.MaKH=b.MaKH
/*Viết ít nhất 2 câu truy vấn sử dụng đều kiện full join*/
select *
from MonAn a Full join LoaiMonAn b on a.MaLoaiMonAn=b.MaLoaiMonAn

select a.MaCuaHang,b.TenCuaHang,b.sdt
from DonDatHang a full join CuaHang b on a.MaCuaHang=b.MaCuaHang

/*Viết ít nhất 2 câu truy vấn sử dụng đều kiện full outer join*/
/*xuất hiện dữ liệu mà chưa có trong bảng CuaHang*/
insert into DonDatHang(MaDatHang,NgayDatHang) values (N'MDH20','2021-03-26')

select a.MaCuaHang,b.TenCuaHang,b.sdt,a.NgayDatHang
from DonDatHang a full outer join CuaHang b on a.MaCuaHang=b.MaCuaHang

select *
from MonAn a Full outer join LoaiMonAn b on a.MaLoaiMonAn=b.MaLoaiMonAn

/* viết 2 câu sử dụng câu lệnh theo dạng truy vấn con*/
SELECT m.MaMonAn,m.ThongTinMonAn,m.TenMonAn
FROM MonAn m
WHERE m.MaLoaiMonAn IN
 (SELECT l.MaLoaiMonAn
 FROM LoaiMonAn l
 WHERE l.TenLoai = N'giải khát');

select a.TenKH, timsoTong.Tonghoadon
from KH a,
	(select b.MaKH, Sum(b.ThanhToan) as Tonghoadon
	from HoaDon b
	group by b.MaKH) timsotong
where timsotong.MaKH = a.MaKH;
/*- Viết ít nhất 2 câu truy vấn sử dụng truy vấn phép toán trừ, hội, giao*/
