use QL_thuvien

go

if OBJECT_ID('usp_XemNhanVien') is not null
 Drop proc usp_XemNhanVien

go
create proc usp_XemNhanVien
as
begin
	select * from [NHAN VIEN]
end


if OBJECT_ID('usp_TimMaNVTiepTheo') is not null
 Drop proc usp_TimMaNVTiepTheo

go
create proc usp_TimMaNVTiepTheo @MaNV varchar(10) out
as
begin
	declare @MaNhanVien nchar(10) = 'NV0001'	
	declare @idx int 
	set @idx = 1
	while exists (select MaNV from [NHAN VIEN] Where MaNV = @MaNhanVien)
	begin
		set @idx = @idx + 1
		set @MaNhanVien = 'NV' + REPLICATE('0', 4 - len(cast(@idx as varchar))) + cast(@idx as varchar)
	end
	Set @MaNV = @MaNhanVien
end


if OBJECT_ID('usp_ThemNhanVien') is not null
 Drop proc usp_ThemNhanVien

go
create proc usp_ThemNhanVien @CaTruc nvarchar(40), @TenDangNhap nvarchar(20), @HoTen nvarchar(100), @LoginGanNhat nvarchar(20), @LoaiNV nvarchar(20)
as
begin
	Declare @MaNV nchar(10)
	exec usp_TimMaNVTiepTheo @MaNV out
	insert into [DOC GIA]
	values(@MaNV, @CaTruc ,@TenDangNhap, @HoTen, @LoginGanNhat, @LoaiNV)
end


if OBJECT_ID('usp_CapNhatNhanVien') is not null
 Drop proc usp_CapNhatNhanVien
 go
create proc usp_CapNhatNhanVien @MaNV nvarchar(10), @CaTruc nvarchar(40), @TenDangNhap nvarchar(20), @HoTen nvarchar(100), @LoginGanNhat nvarchar(20), @LoaiNV nvarchar(20)
as
begin
	update [NHAN VIEN]
	set	CaTruc = @CaTruc, TenDangNhap = @TenDangNhap, HoTen = @HoTen, LoginGanNhat = @LoginGanNhat, LoaiNV =@LoaiNV
	where MaNV = @MaNV
end


if OBJECT_ID('usp_Login') is not null
 Drop proc usp_Login

go
create proc usp_Login @username nchar(40), @password nchar(40), @result int out
as
begin
	if exists (select * from [DANG NHAP NV]
	where TenDangNhap = @username and matkhau = @password)
	begin
		Set @result = 1;
	end
end

if OBJECT_ID('usp_XemDocGia') is not null
 Drop proc usp_XemDocGia

go
create proc usp_XemDocGia
as
begin
	select * from [DOC GIA]
end


go


if OBJECT_ID('usp_TimMaDGTiepTheo') is not null
 Drop proc usp_TimMaDGTiepTheo

go
create proc usp_TimMaDGTiepTheo @MaDocGia varchar(10) out
as
begin
	declare @MaDG nchar(10) = 'DG00001'	
	declare @idx int 
	set @idx = 1
	while exists (select MaDocGia from [DOC GIA] Where MaDocGia = @MaDG)
	begin
		set @idx = @idx + 1
		set @MaDG = 'DG' + REPLICATE('0', 5 - len(cast(@idx as varchar))) + cast(@idx as varchar)
	end
	Set @MaDocGia = @MaDG
end



if OBJECT_ID('usp_ThemDocGia') is not null
 Drop proc usp_ThemDocGia

go
create proc usp_ThemDocGia @TenDG nvarchar(40), @NgaySinhDG nvarchar(20), @DiaChiDG nvarchar(100), @SDTDG nvarchar(20), @EmailDG nvarchar(30), @CMNDDG nvarchar(20),@MSSVDG nvarchar(20), @MCBDG nvarchar(20), @LoaiDG nvarchar(20)
as
begin
	Declare @MaDG nchar(10)
	exec usp_TimMaDGTiepTheo @MaDG out
	insert into [DOC GIA]
	values(@MaDG, @TenDG,@NgaySinhDG, @DiaChiDG, @SDTDG, @EmailDG, @CMNDDG, @MSSVDG, @CMNDDG, @LoaiDG)
end


if OBJECT_ID('usp_CapNhatDocGia') is not null
 Drop proc usp_CapNhatDocGia
 go
create proc usp_CapNhatDocGia @MaDG nvarchar(10), @TenDG nvarchar(40), @NgaySinhDG nvarchar(20), @DiaChiDG nvarchar(100), @SDTDG nvarchar(20), @EmailDG nvarchar(30), @CMNDDG nvarchar(20),@MSSVDG nvarchar(20), @MCBDG nvarchar(20), @LoaiDG nvarchar(20)
as
begin
	update [DOC GIA]
	set HoTen = @TenDG, NgaySinh = @NgaySinhDG, DiaChi = @DiaChiDG, Sdt = @SDTDG, Email = @EmailDG, CMND = @CMNDDG, MSSV = @MSSVDG, MCB = @MCBDG, LoaiDG = @LoaiDG
	where MaDocGia = @MaDG
end

if OBJECT_ID('usp_XoaDocGia') is not null
 Drop proc usp_XoaDocGia
 go

 create proc usp_XoaDocGia @MaDG char(15)
 as
 begin
	delete from [DOC GIA]
	where MaDocGia = @MaDG
 end






