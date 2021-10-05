sp_who @loginame="sa"

sp_databases

use QLSACHTH1
sp_server_info

sp_stored_procedures
--void ThongBao(): c,++
create procedure ThongBao
as
	print N'Xin chào các bạn';

exec ThongBao
sp_stored_procedures

sp_tables Sach

sp_helptext ThongBao

sp_help all_sach_view

--Viết sp insert thể loại với mã thể loại và tên thể loại được đưa từ ngoài 

create procedure vidu1(@matl nchar(10),@tentl nchar(100))
as
begin
	insert into TheLoai(matl,TenTL) values(@matl,@tentl);
end

exec vidu1 'LG',N'Logistic'
select * from TheLoai

--Viết sp cho biết các sách mà có thông tin của tác giả, thông tin chỉ mã sách

--áp dụng phép toán giao 
create procedure info_sach_tg
as
begin
	select s.masach
	from sach s
	intersect
	select stg.masach
	from sach_tacgia stg
end

exec info_sach_tg
--Viết sp cho biết các sách mà có thông tin của tác giả, thông tin chỉ mã sách
--Hiển thị lên thông tin masach, tensach, sotrang
--Gắn vào truy cấn con
create procedure info_sach1
as
begin
	select s.masach, s.tensach, s.sotrang
	from sach s
	where s.masach in (select s.masach
		intersect
		select stg.masach
		from sach_tacgia stg)
end

info_sach1

--Viết 1 thủ Cho biết danh sách các sách mà có số số trang và mã thể loại đầu vào 
create procedure info_sach_tloai(@sotrang int, @matl nchar(100))
as
begin
	select s.masach, s.tensach, s.sotrang, tl.tentl
	from sach s, TheLoai tl
	where s.matl=tl.matl and  s.sotrang = @sotrang and tl.matl = @matl
end
select * from sach
info_sach_tloai 50, 'TH'

--Viết thủ tục cập nhật lại tất các sách thuộc nhà xuất bản giáo dục thêm mỗi cuốn 20 trang
create procedure update_sotrang
as
begin
	UPDATE Sach set sotrang=sotrang+20 WHERE MaXB ='NXBGD';
end

--viết 1 thủ tục xóa 1 dòng dữ thể loại , với tham số đầu vào matl
create procedure del_theloai(@matl nchar(10))
as
begin
 delete from TheLoai where matl=@matl;
end

exec del_theloai 'LG'

--Viết 1 câu lệnh kiểm tra sự tồn tại của 1 sp trong database 
--cụ thể là del_theloai
if(exists(select * from sys.procedures where name='del_theloai'))
	drop procedure del_theloai;



create procedure del_theloai(@matl nchar(10))
as
begin
 delete from TheLoai where matl=@matl;
end

--Tham số đầu ra được output
--Viết sp đếm số số sách thỏa mãn điều kiện mà số trang >40 trang
 create procedure demsosachtheosotrang(@sotrang int, @dem int output)
 as
 begin
	select * from sach where sotrang>@sotrang;
	select @dem=@@rowcount;
	print 'So luong='+CAST(@@rowcount as nchar) ; 
	 

 end

 --gọi thủ tục có tham số đầu ra
 declare @count int;
 exec demsosachtheosotrang 20,@count output;

 select @count as 'Số lượng sách'

 --insert dữ liệu mà kiểm tra xem có trùng khóa hay
 create procedure Insert_data_TheLoai(@matl nchar(10),@tentl nchar(100))
 as
  if(exists(select * from TheLoai where matl=@matl))
	print N'Đã trùng khóa mã thể loại';
  else
  begin
	 insert into TheLoai(matl,TenTL) values(@matl,@tentl);
	 print N'Đã trùng khóa mã thể loại';
  end


  Insert_data_TheLoai 'LG','Logistic cơ bản'

   create procedure Insert_data_TheLoai_out(@matl nchar(10),@tentl nchar(100),@kq int output)
 as
  if(exists(select * from TheLoai where matl=@matl))
  begin
	print N'Đã trùng khóa mã thể loại';
	select @kq=0;
	end
  else
	begin
	 insert into TheLoai(matl,TenTL) values(@matl,@tentl);
	 print N' Thành công';
	 select @kq=1;
	end

  declare @kq int;
  exec Insert_data_TheLoai_out 'LG2','Logistic2', @kq output;

	print @kq;	
	if(@kq=0)
		print N'Trùng khóa';
	else
		print N'Thành công';