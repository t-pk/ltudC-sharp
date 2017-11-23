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
create proc usp_ThemNhanVien @CaTruc nvarchar(40), @TenDangNhap nvarchar(20), @HoTen nvarchar(100), @MatKhau char(20), @LoaiNV nvarchar(20)
as
begin
	Declare @MaNV nchar(10)
	exec usp_TimMaNVTiepTheo @MaNV out
	insert into [NHAN VIEN]
	values(@MaNV, @CaTruc ,@TenDangNhap, @MatKhau, @HoTen, GETDATE(), @LoaiNV)
end


if OBJECT_ID('usp_CapNhatNhanVien') is not null
 Drop proc usp_CapNhatNhanVien
 go
create proc usp_CapNhatNhanVien @MaNV nvarchar(10), @CaTruc nvarchar(40), @TenDangNhap nvarchar(20), @MatKhau char(20), @HoTen nvarchar(100), @LoaiNV nvarchar(20)
as
begin
	update [NHAN VIEN]
	set	CaTruc = @CaTruc, TenDangNhap = @TenDangNhap, MatKhau = @MatKhau, HoTen = @HoTen, LoaiNV = @LoaiNV
	where MaNV = @MaNV
end


if OBJECT_ID('usp_Login') is not null
 Drop proc usp_Login

go
create proc usp_Login @username nchar(40), @password nchar(40), @result int out
as
begin
	if exists (select * from [NHAN VIEN]
	where TenDangNhap = @username and MatKhau = @password)
	begin
		Set @result = 1;
		update [NHAN VIEN]
		set LoginGanNhat = GETDATE()
		where TenDangNhap = @username and MatKhau = @password
	end
end


if OBJECT_ID('usp_LayTenNhanVien') is not null
 Drop proc usp_LayTenNhanVien

go
create proc usp_LayTenNhanVien @UserName char(40), @Pass char(20), @TenNV nvarchar(50) out
as
begin
	select @TenNV =  nv.HoTen
	from [NHAN VIEN] nv
	where nv.TenDangNhap = @UserName and nv.MatKhau = @Pass
end

if OBJECT_ID('usp_LayQuyenNhanVien') is not null
 Drop proc usp_LayQuyenNhanVien

go
create proc usp_LayQuyenNhanVien @UserName char(40), @Pass char(20), @QuyenNV nvarchar(50) out
as
begin
	select @QuyenNV =  l.TenLoaiNV
	from [NHAN VIEN] nv, [LOAI NHANVIEN] l
	where nv.TenDangNhap = @UserName and nv.MatKhau = @Pass and l.MaLoaiNV = nv.LoaiNV
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


 if OBJECT_ID('usp_TimKiemTatCaDocGia') is not null
 Drop proc usp_TimKiemTatCaDocGia
 go

 create proc usp_TimKiemTatCaDocGia
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon', (select sum(ctpp.SoSachQuaHan) from [DOC GIA] dg2, [PHIEU PHAT] pp, [CHI TIET PHIEU PHAT] ctpp, [PHIEU MUON] pm2 where dg2.MaDocGia = pm2.MaDocGia and pm2.MaPhieuMuon = pp.MaPhieuMuon and pp.MaPhieuPhat = ctpp.MaPhieuPhat) as 'So Sach Qua Han'
	from [DOC GIA] dg
 end



  if OBJECT_ID('usp_SearchDocGia') is not null
 Drop proc usp_SearchDocGia
 go

 create proc usp_SearchDocGia @MaDG char(15)
 as
 begin
	select *
	from [DOC GIA]
	where MaDocGia = @MaDG
 end


 if OBJECT_ID('usp_TimKiemDocGiaTheoMaDocGia') is not null
 Drop proc usp_TimKiemDocGiaTheoMaDocGia
 go

 create proc usp_TimKiemDocGiaTheoMaDocGia @MaDG char(15)
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and dg1.MaDocGia = @MaDG and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon', (select sum(ctpp.SoSachQuaHan) from [DOC GIA] dg2, [PHIEU PHAT] pp, [CHI TIET PHIEU PHAT] ctpp, [PHIEU MUON] pm2 where dg2.MaDocGia = pm2.MaDocGia and pm2.MaPhieuMuon = pp.MaPhieuMuon and pp.MaPhieuPhat = ctpp.MaPhieuPhat and dg2.MaDocGia = @MaDG) as 'So Sach Qua Han'
	from [DOC GIA] dg
	where dg.MaDocGia = @MaDG
 end



  if OBJECT_ID('usp_TimKiemDocGiaTheoMSSV') is not null
 Drop proc usp_TimKiemDocGiaTheoMSSV
 go

 create proc usp_TimKiemDocGiaTheoMSSV @MSSV char(15)
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and dg1.MSSV = @MSSV and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon', (select sum(ctpp.SoSachQuaHan) from [DOC GIA] dg2, [PHIEU PHAT] pp, [CHI TIET PHIEU PHAT] ctpp, [PHIEU MUON] pm2 where dg2.MaDocGia = pm2.MaDocGia and pm2.MaPhieuMuon = pp.MaPhieuMuon and pp.MaPhieuPhat = ctpp.MaPhieuPhat and dg2.MSSV = @MSSV) as 'So Sach Qua Han'
	from [DOC GIA] dg
	where dg.MSSV = @MSSV
 end


   if OBJECT_ID('usp_TimKiemDocGiaTheoMSCB') is not null
 Drop proc usp_TimKiemDocGiaTheoMSCB
 go

 create proc usp_TimKiemDocGiaTheoMSCB @MSCB char(15)
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and dg1.MCB = @MSCB and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon', (select sum(ctpp.SoSachQuaHan) from [DOC GIA] dg2, [PHIEU PHAT] pp, [CHI TIET PHIEU PHAT] ctpp, [PHIEU MUON] pm2 where dg2.MaDocGia = pm2.MaDocGia and pm2.MaPhieuMuon = pp.MaPhieuMuon and pp.MaPhieuPhat = ctpp.MaPhieuPhat and dg2.MCB = @MSCB) as 'So Sach Qua Han'
	from [DOC GIA] dg
	where dg.MCB = @MSCB
 end




   if OBJECT_ID('usp_TimKiemDocGiaTheoCMND') is not null
 Drop proc usp_TimKiemDocGiaTheoCMND
 go

 create proc usp_TimKiemDocGiaTheoCMND @CMND char(15)
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and dg1.CMND = @CMND and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon', (select sum(ctpp.SoSachQuaHan) from [DOC GIA] dg2, [PHIEU PHAT] pp, [CHI TIET PHIEU PHAT] ctpp, [PHIEU MUON] pm2 where dg2.MaDocGia = pm2.MaDocGia and pm2.MaPhieuMuon = pp.MaPhieuMuon and pp.MaPhieuPhat = ctpp.MaPhieuPhat and dg2.CMND = @CMND) as 'So Sach Qua Han'
	from [DOC GIA] dg
	where dg.CMND = @CMND
 end




  if OBJECT_ID('usp_TimKiemDocGiaTheoHoTen') is not null
 Drop proc usp_TimKiemDocGiaTheoHoTen
 go

 create proc usp_TimKiemDocGiaTheoHoTen @HoTen nvarchar(100)
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and dg1.HoTen = @HoTen and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon', (select sum(ctpp.SoSachQuaHan) from [DOC GIA] dg2, [PHIEU PHAT] pp, [CHI TIET PHIEU PHAT] ctpp, [PHIEU MUON] pm2 where dg2.MaDocGia = pm2.MaDocGia and pm2.MaPhieuMuon = pp.MaPhieuMuon and pp.MaPhieuPhat = ctpp.MaPhieuPhat and dg2.HoTen = @HoTen) as 'So Sach Qua Han'
	from [DOC GIA] dg
	where dg.HoTen = @HoTen
 end

 select * from [DOC GIA]


---------------------------------------------------------------------------

----------------------------------------------------------------------------

if OBJECT_ID('usp_xemPhieuMuon') is not null
drop proc usp_xemPhieuMuon
go
 create proc usp_xemPhieuMuon
 as
 begin
 select *from [PHIEU MUON]
  select *from [CHI TIET PHIEU MUON]
-------------------------------------------------------------
if OBJECT_ID('usp_xemPhieuTra') is not null
drop proc usp_xemPhieuTra
go
 create proc usp_xemPhieuTra
 as
 begin
 select *from [PHIEU TRA] 
 select *from [CHI TIET PHIEU TRA]
 end



