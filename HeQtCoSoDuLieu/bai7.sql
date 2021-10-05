create function DoanhThu
(
	@quantity int,
	@price dec(10,2),
	@discount dec(10,2)
)
returns dec(10,2)
as
begin
	return @quantity*@price*(1 - @discount);
end

--Cách sử dụng hàm scalar
--100099988888
--5.10
select dbo.DoanhThu(2,10000,0.1) as doanhthu
create function DoanhThu1
(
	@quantity int,
	@price float,
	@discount float
)
returns float
as
begin
	return @quantity*@price*(1 - @discount);
end

select dbo.DoanhThu1(2,10000,0.1) as doanhthu

select * from ChiTietDonHang
select dbo.DoanhThu(Soluong,GiaTien,GiamGia) as doanhthu from ChiTietDonHang
--tính tổng doanh thu của từng đơn hàng 

select sodh,sum(dbo.DoanhThu(Soluong,GiaTien,GiamGia)) as tongtien
from ChiTietDonHang

group by sodh

--Cho biết tồng số tiền của các khách hàng mà đã đặt mua hàng của đơn 001
--hiển thị makh, tenkhach, tồng tiền mua
  select sodh,sum(dbo.DoanhThu(Soluong,GiaTien,GiamGia)) as tongtien
from ChiTietDonHang
where SoDH='001'
group by sodh

  --Bùi hữu đạt
 select kh.MaKH,(kh.hoKh+' '+kh.TenKH) as hovaten , sum(dbo.DoanhThu(SoLuong,GiaTien,GiamGia)) as doanhthu 
from ChiTietDonHang ct, KhachHang kh, DonDatHang ddh
where kh.MaKH = ddh.MaKH and ddh.SoDH=ct.SoDH and ddh.SoDH='001'
group by kh.makh,(kh.hoKh+' '+kh.TenKH) 

--Câu truy vấn con
--Hoa
select k.MaKH,k.HoKH,k.TenKH,s.TongtienKH
 from KhachHang k,(
	select d.MaKH,sum(dbo.DoanhThu(SoLuong,GiaTien,GiamGia)) as TongtienKH
	from DonDatHang d,ChiTietDonHang c
	where c.SoDH=d.SoDH  and c.SoDH=N'001'
	group by d.MaKH) as s
where k.MaKH=s.MaKH

select k.MaKH,k.HoKH,k.TenKH,s.TongtienKH
 from DonDatHang ddh ,KhachHang k,(
					select sodh,sum(dbo.DoanhThu(Soluong,GiaTien,GiamGia)) as TongtienKH
					from ChiTietDonHang
					where SoDH='001'
					group by sodh) as s
where ddh.SoDH=s.SoDH and k.MaKH=ddh.MaKH 

select k.MaKH,k.HoKH,k.TenKH,s.TongtienKH
 from DonDatHang ddh ,KhachHang k,(
					select sodh,sum(dbo.DoanhThu1(Soluong,GiaTien,GiamGia,0.1)) as TongtienKH
					from ChiTietDonHang
					where SoDH='001'
					group by sodh) as s
where ddh.SoDH=s.SoDH and k.MaKH=ddh.MaKH 
/*
select MaKH,HoKH + ' ' + TenKH as 'HoTen',
	(select sum(dbo.DoanhThu(c.SoLuong,c.GiaTien,c.GiamGia))  from DonDatHang d, ChiTietDonHang c 
	where d.SoDH = c.SoDH  and k.MaKH = d.MaKH and d.SoDH='001') as 'TongTien' 
from KhachHang k
*/
alter function DoanhThu1
(
	@quantity int,
	@price float,
	@discount float,
	@tax float
)
returns float
as
begin
	return (@quantity*@price*(1 - @discount))*0.9;
end

drop function DoanhThu

create procedure tinhDoanhThuTheoDonHang(@sodh nvarchar(10))
as
begin
select k.MaKH,k.HoKH,k.TenKH,s.TongtienKH
 from DonDatHang ddh ,KhachHang k,(
					select sodh,sum(dbo.DoanhThu1(Soluong,GiaTien,GiamGia,0.1)) as TongtienKH
					from ChiTietDonHang
					where SoDH=@sodh
					group by sodh) as s
where ddh.SoDH=s.SoDH and k.MaKH=ddh.MaKH 
end

tinhDoanhThuTheoDonHang '001'

--Khai báo biến kiểu table
declare @sach_table table
(
	TenSach nchar(100) null,
	Sotrang int,
	GiaSach float
);

insert  into @sach_table
select tensach,sotrang,giasach
from sach
where sotrang>=40;

--
select * from @sach_table;

--int a=10,b=20; int c=a+b;  cout<<c;

--hàm trả về kiểu table
create function List_sach
(
@sotrang int
)
returns table
as return 

		select * from sach
		where sotrang=@sotrang;

--liệt kê danh sach các loại sách mà thỏa diều kei65n là sotrang
select * from List_sach(40)

create procedure locSach
(
   @sotrang int
)as
begin
select * from List_sach(@sotrang);
end

exec locSach 40

alter function List_sach
(
@sotrangbegin int,
@sotrangend int

)
returns table
as return 

		select * from sach
		where sotrang>=@sotrangbegin and sotrang<=@sotrangend;


select * from List_sach(40,100)

---Đa câu lệnh(truy vấn trong SQL server)
create function List_Contact()
returns @contact table(
	ma nvarchar(10),
	KieuLH varchar(20)
)as 
begin
	insert into @contact
	select manv,N'Nhân Viên'
	from NhanVien

	insert into @contact
	select MaKH,N'Khách hàng'
	from KhachHang
	return;
end

select * from List_Contact()

drop function List_Contact
/*
 IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'function_name') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION function_name
GO
*/
IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'List_Contact') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION List_Contact

--cách xóa thứ 2 có kiểm tra điều kiện xóa
IF object_id(N'DoanhThu1', N'FN') IS NOT NULL
    DROP FUNCTION DoanhThu1
GO
