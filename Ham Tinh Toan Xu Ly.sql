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

select * from [DANG NHAP NV]
