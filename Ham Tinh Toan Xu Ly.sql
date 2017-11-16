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
