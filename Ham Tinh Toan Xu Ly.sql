use QL_thuvien

go

if OBJECT_ID('usp_AddUser') is not null
 Drop proc usp_AddUser

go

create proc usp_AddUser @username nchar(40), @email nchar(40), @password nchar(40)
as
begin
	insert into [DANG NHAP NV]
	values(@username, @email, @password)
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
create proc usp_ThemDocGia @MaDG nchar(10), @TenDG nvarchar(40), @NgaySinhDG date, @DiaChiDG nchar(100), @SDTDG as char(12), @EmailDG char(30), @CMNDDG char(20),@MSSVDG char(20), @MCBDG char(20), @LoaiDG char(20)
as
begin
	exec usp_TimMaDGTiepTheo @MaDG
	insert into [DOC GIA]
	values(@MaDG, @TenDG, @NgaySinhDG, @DiaChiDG, @SDTDG, @EmailDG, @CMNDDG, @MSSVDG, @CMNDDG, @LoaiDG)
end


