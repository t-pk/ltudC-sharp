use QL_thuvien

select * from [TAI LIEU]

if OBJECT_ID('usp_XemAllTaiLieu') is not null
 Drop proc usp_XemAllTaiLieu

go
create proc usp_XemAllTaiLieu
as
begin
	select * from [TAI LIEU]
end

go
if OBJECT_ID('usp_TimMaTLTiepTheo') is not null
 Drop proc usp_TimMaTLTiepTheo

go
create proc usp_TimMaTLTiepTheo @MaTaiLieu varchar(10) out
as
begin
	declare @MaTL nchar(10) = 'TL001'	
	declare @idx int 
	set @idx = 1
	while exists (select MaTaiLieu from [TAI LIEU] Where MaTaiLieu = @MaTL)
	begin
		set @idx = @idx + 1
		set @MaTL = 'TL' + REPLICATE('0', 3 - len(cast(@idx as varchar))) + cast(@idx as varchar)
	end
	Set @MaTaiLieu = @MaTL
end

go
if OBJECT_ID('usp_SearchTaiLieuTheoMa') is not null
 Drop proc usp_SearchTaiLieuTheoMa

go
create proc usp_SearchTaiLieuTheoMa @MaTaiLieu char(15)
as
begin
	select * from [TAI LIEU]
	where MaTaiLieu = @MaTaiLieu
end
go

if OBJECT_ID('usp_SearchTaiLieuTheoTen') is not null
 Drop proc usp_SearchTaiLieuTheoTen

go
create proc usp_SearchTaiLieuTheoTen @TenTaiLieu nvarchar(50)
as
begin
	select * from [TAI LIEU]
	where TenTaiLieu like '%' + @TenTaiLieu + '%'
end
go


if OBJECT_ID('usp_SearchTaiLieuTheoLoai') is not null
 Drop proc usp_SearchTaiLieuTheoLoai

go
create proc usp_SearchTaiLieuTheoLoai @LoaiTaiLieu nvarchar(50)
as
begin
	select * from [TAI LIEU]
	where LoaiTaiLieu = @LoaiTaiLieu
end
go

if OBJECT_ID('usp_DeleteTaiLieu') is not null
 Drop proc usp_DeleteTaiLieu

go
create proc usp_DeleteTaiLieu @MaTaiLieu nvarchar(50)
as
begin
	delete from [TAI LIEU]
	where MaTaiLieu = @MaTaiLieu
end
go

if OBJECT_ID('usp_UpdateTaiLieu') is not null
 Drop proc usp_UpdateTaiLieu

go
create proc usp_UpdateTaiLieu @MaTaiLieu char(20), @TenTaiLieu nvarchar(50), @HienTrang char(20), @LoaiTaiLieu nvarchar(30), @SoLuong char(5)
as
begin
	update [TAI LIEU]
	set TenTaiLieu = @TenTaiLieu, HienTrang = @HienTrang, LoaiTaiLieu = @LoaiTaiLieu, SoLuong = @SoLuong
	where MaTaiLieu = @MaTaiLieu
end
go

if OBJECT_ID('usp_InsertTaiLieu') is not null
 Drop proc usp_InsertTaiLieu

go
create proc usp_InsertTaiLieu @TenTaiLieu nvarchar(50), @HienTrang char(20), @LoaiTaiLieu nvarchar(30), @SoLuong char(5)
as
begin
	Declare @MaTaiLieu char(20)
	exec usp_TimMaTLTiepTheo @MaTaiLieu out
	insert into [TAI LIEU]
	values( @MaTaiLieu, @TenTaiLieu, @HienTrang, @LoaiTaiLieu, @SoLuong)
end




------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
go

if OBJECT_ID('usp_XemNhanVien') is not null
 Drop proc usp_XemNhanVien

go
create proc usp_XemNhanVien
as
begin
	select * from [NHAN VIEN]
end
go

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
go

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
go

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
go
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


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
go
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


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
go
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
go

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

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
go


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
go

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
go

if OBJECT_ID('usp_XoaDocGia') is not null
 Drop proc usp_XoaDocGia
 go

 create proc usp_XoaDocGia @MaDG char(15)
 as
 begin
	delete from [DOC GIA]
	where MaDocGia = @MaDG
 end
 go

 if OBJECT_ID('usp_TimKiemTatCaDocGia') is not null
 Drop proc usp_TimKiemTatCaDocGia
 go

 create proc usp_TimKiemTatCaDocGia
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon'
	from [DOC GIA] dg
 end
 go

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
 go

 if OBJECT_ID('usp_TimKiemDocGiaTheoMaDocGia') is not null
 Drop proc usp_TimKiemDocGiaTheoMaDocGia
 go

 create proc usp_TimKiemDocGiaTheoMaDocGia @MaDG char(15)
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and dg1.MaDocGia = @MaDG and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon'
	from [DOC GIA] dg
	where dg.MaDocGia = @MaDG
 end
 go


  if OBJECT_ID('usp_TimKiemDocGiaTheoMSSV') is not null
 Drop proc usp_TimKiemDocGiaTheoMSSV
 go

 create proc usp_TimKiemDocGiaTheoMSSV @MSSV char(15)
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and dg1.MSSV = @MSSV and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon'
	from [DOC GIA] dg
	where dg.MSSV = @MSSV
 end
 go

   if OBJECT_ID('usp_TimKiemDocGiaTheoMSCB') is not null
 Drop proc usp_TimKiemDocGiaTheoMSCB
 go

 create proc usp_TimKiemDocGiaTheoMSCB @MSCB char(15)
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and dg1.MCB = @MSCB and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon'
	from [DOC GIA] dg
	where dg.MCB = @MSCB
 end
 go



   if OBJECT_ID('usp_TimKiemDocGiaTheoCMND') is not null
 Drop proc usp_TimKiemDocGiaTheoCMND
 go

 create proc usp_TimKiemDocGiaTheoCMND @CMND char(15)
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and dg1.CMND = @CMND and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon'
	from [DOC GIA] dg
	where dg.CMND = @CMND
 end
 go



  if OBJECT_ID('usp_TimKiemDocGiaTheoHoTen') is not null
 Drop proc usp_TimKiemDocGiaTheoHoTen
 go

 create proc usp_TimKiemDocGiaTheoHoTen @HoTen nvarchar(100)
 as
 begin
	select dg.MaDocGia, dg.HoTen, dg.CMND, dg.LoaiDG, (select sum(ctpm.SoLuongMuon) from [PHIEU MUON] pm, [PHIEU TRA] pt, [DOC GIA] dg1, [CHI TIET PHIEU MUON] ctpm where dg1.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon <> pt.MaPhieuMuon and dg1.HoTen like @HoTen and ctpm.MaPhieuMuon = pm.MaPhieuMuon) as 'So Sach Dang Muon'
	from [DOC GIA] dg
	where dg.HoTen like @HoTen
 end
 ----------------------------------------------------------------------------------
 ----------------------pktai---------------------------------------
 -----------------------------------------------------------------------------------
go
if OBJECT_ID('usp_xemPhieuMuon') is not null
 Drop proc usp_xemPhieuMuon

go
create proc usp_xemPhieuMuon
as
begin
	select pm.MaDocGia,pm.MaNVLapPhieuMuon,pm.MaPhieuMuon,pm.NgayLapPhieuMuon,ct.HanTra,ct.MaTaiLieu,ct.SoLuongMuon,ct.STTMuon
	 from [PHIEU MUON] pm,[CHI TIET PHIEU MUON] ct
	where pm.MaPhieuMuon=ct.MaPhieuMuon
end
go
exec usp_xemPhieuMuon
---------------
if OBJECT_ID('usp_XemPhieuTra') is not null
 Drop proc usp_XemPhieuTra

go
create proc usp_XemPhieuTra
as
begin
	select pt.MaNVLapPhieuTra,pt.MaPhieuMuon,pt.MaPhieuTra,pt.NgayLapPhieuTra,ct.MaDocGia,ct.NgayTra,ct.STTPhieuTra 
	 from [PHIEU TRA] pt,[CHI TIET PHIEU TRA] ct
	where pt.MaPhieuTra=ct.MaPhieuTra
end
go
------------------
if OBJECT_ID('usp_XemPhieuPhat') is not null
 Drop proc usp_XemPhieuPhat

go
create proc usp_XemPhieuPhat
as
begin
	select * from [PHIEU PHAT]
end
exec usp_XemPhieuPhat
go
-----------------
if OBJECT_ID('usp_XemPhieuNhacNho') is not null
 Drop proc usp_XemPhieuNhacNho

go
create proc usp_XemPhieuNhacNho
as
begin
	select * from [PHIEU NHAC NHO]
end
go
--------------------------------------------------------------------------------------------
if OBJECT_ID('usp_TimMaPhieuMuonTiepTheo') is not null
drop proc usp_TimMaPhieuMuonTiepTheo
go
create proc usp_TimMaPhieuMuonTiepTheo @Maphieumuon nchar(10) out
as 
begin
declare @mapm nchar(10)='PM001'
declare @idx int 
	set @idx = 1
	while exists (select MaPhieuMuon from [PHIEU MUON] Where MaPhieuMuon = @Mapm)
	begin
		set @idx = @idx + 1
		set @Mapm= 'PM' + REPLICATE('0', 3 - len(cast(@idx as varchar))) + cast(@idx as varchar)
	end
	Set  @Maphieumuon=@Mapm
end
go
if OBJECT_ID('usp_ThemPhieuMuon') is not null
 Drop proc usp_ThemPhieuMuon
go
create proc usp_ThemPhieuMuon @MaNVLapPhieuMuon nchar(10), @Madocgia nchar(10), @ngaylapphieumuon date
as
begin
	Declare @Mapm nchar(10)
	if exists (select MaDocGia from [DOC GIA] Where MaDocGia = @Madocgia)
	begin
	exec usp_TimMaPhieuMuonTiepTheo @Mapm out
	--if exists (select MaDocGia from [DOC GIA] Where MaDocGia = @Madocgia)

	insert into [PHIEU MUON]

	values(@Mapm,@MaNVLapPhieuMuon ,@Madocgia,@ngaylapphieumuon)
	end
end
go
------------------------------------------------------------
if OBJECT_ID('usp_TimMaPhieuTraTiepTheo') is not null
drop proc usp_TimMaPhieuTraTiepTheo
go
create proc usp_TimMaPhieuTraTiepTheo @Maphieutra nchar(10) out
as 
begin
declare @mapt nchar(10)='PT001'
declare @idx int 
	set @idx = 1
	while exists (select MaPhieuTra from [PHIEU Tra] Where MaPhieuTra = @Mapt)
	begin
		set @idx = @idx + 1
		set @Maphieutra= 'PT' + REPLICATE('0', 3 - len(cast(@idx as varchar))) + cast(@idx as varchar)
	end
	Set  @Maphieutra=@Mapt
end
go
-------------------------------------------------
if OBJECT_ID('usp_ThemPhieuTra') is not null
 Drop proc usp_ThemPhieuTra
go
create proc usp_ThemPhieuTra @MaPhieuTra nchar(10), @MaNVLapPhieuTra nchar(10), @ngaylapphieutra date
as
begin
	Declare @Mapt nchar(10)
	if exists (select MaPhieuTra from [PHIEU TRA] Where MaPhieuTra = @MaPhieuTra)
	begin
	exec usp_TimMaPhieuTraTiepTheo @Mapt out
	--if exists (select MaDocGia from [DOC GIA] Where MaDocGia = @Madocgia)

	insert into [PHIEU TRA]

	values(@Mapt,@MaPhieuTra, @MaNVLapPhieuTra, @ngaylapphieutra)
	end
end
go

if OBJECT_ID('usp_XoaNhanVien') is not null
 Drop proc usp_XoaNhanVien

go
create proc usp_XoaNhanVien @MaNV nvarchar(50)
as
begin
	delete from [NHAN VIEN]
	where MaNV = @MaNV
end
 ---------------------------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------------------------------------

 select * from [dbo].[TAI LIEU]
 --son