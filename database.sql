/***  REMEMBER: THÊM STATUS = TRUE OR FALSE CHO MỖI BẢNG NẾU CÓ TRẠNG THÁI XÓA ( DELETE), THÊM 1TABLE LOẠI TÀI LIỆU ĐỂ PHÂN BIỆT LOẠI TẠI LIỆU NỮA, CHỈNH SỬA THÊM MẤY HÀM XÓA CHỈ CẨN UPDATE STATUS = FALSE LÀ HIDE NÓ ĐI ****/
USE [master]
GO
/****** Object:  Database [QL_thuvien]    Script Date: 1/3/2018 5:38:41 PM ******/
CREATE DATABASE [QL_thuvien]
 CONTAINMENT = NONE
ALTER DATABASE [QL_thuvien] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QL_thuvien].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QL_thuvien] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QL_thuvien] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QL_thuvien] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QL_thuvien] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QL_thuvien] SET ARITHABORT OFF 
GO
ALTER DATABASE [QL_thuvien] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QL_thuvien] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QL_thuvien] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QL_thuvien] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QL_thuvien] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QL_thuvien] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QL_thuvien] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QL_thuvien] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QL_thuvien] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QL_thuvien] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QL_thuvien] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QL_thuvien] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QL_thuvien] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QL_thuvien] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QL_thuvien] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QL_thuvien] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QL_thuvien] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QL_thuvien] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QL_thuvien] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QL_thuvien] SET  MULTI_USER 
GO
ALTER DATABASE [QL_thuvien] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QL_thuvien] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QL_thuvien] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QL_thuvien] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QL_thuvien]
GO
/****** Object:  StoredProcedure [dbo].[usp_AD_Add_LDG]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_AD_Add_LDG] @MaLoaiDG char(10), @SoNgayMuonToiDa int, @SoSachMuonToiDa int, @TenLoaiDG nvarchar(50), @PhiThuongNien int, @TaiLieuDB bit
as
begin
	if not exists(select * from [LOAI DOC GIA] where MaLoaiDG = @MaLoaiDG)
	begin
		insert into [LOAI DOC GIA]
		values(@MaLoaiDG, @SoNgayMuonToiDa, @SoSachMuonToiDa, @TenLoaiDG, @PhiThuongNien, @TaiLieuDB)
	end
end



GO
/****** Object:  StoredProcedure [dbo].[usp_AD_UP_LDG]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_AD_UP_LDG] @MaLoaiDG char(10), @SoNgayMuonToiDa int, @SoSachMuonToiDa int, @TenLoaiDG nvarchar(50), @PhiThuongNien int, @TaiLieuDB bit
as
begin
	if exists (select * from [LOAI DOC GIA] where MaLoaiDG = @MaLoaiDG)
	begin
		update [LOAI DOC GIA]
		set SoNgayMuonToiDa = @SoNgayMuonToiDa, SoSachMuonToiDa = @SoSachMuonToiDa, TenLoaiDG = @TenLoaiDG, PhiThuongNien= @PhiThuongNien, TaiKieuDB = @TaiLieuDB
		where MaLoaiDG= @MaLoaiDG
	end
end



GO
/****** Object:  StoredProcedure [dbo].[usp_CapNhatDocGia]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_CapNhatDocGia] @MaDG nvarchar(10), @TenDG nvarchar(40), @NgaySinhDG nvarchar(20), @DiaChiDG nvarchar(100), @SDTDG nvarchar(20), @EmailDG nvarchar(30), @CMNDDG nvarchar(20),@MSSVDG nvarchar(20), @MCBDG nvarchar(20), @LoaiDG nvarchar(20)
as
begin
	update [DOC GIA]
	set HoTen = @TenDG, NgaySinh = @NgaySinhDG, DiaChi = @DiaChiDG, Sdt = @SDTDG, Email = @EmailDG, CMND = @CMNDDG, MSSV = @MSSVDG, MCB = @MCBDG, LoaiDG = @LoaiDG
	where MaDocGia = @MaDG
end









GO
/****** Object:  StoredProcedure [dbo].[usp_CapNhatNhanVien]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_CapNhatNhanVien] @MaNV nvarchar(10), @CaTruc nvarchar(40), @TenDangNhap nvarchar(20), @MatKhau nchar(200), @HoTen nvarchar(100), @LoaiNV nvarchar(20), @Result int out
as
begin
	set @Result = 0
	if exists (Select * from [NHAN VIEN] where TenDangNhap = @TenDangNhap)
	begin
		update [NHAN VIEN]
		set	CaTruc = @CaTruc, TenDangNhap = @TenDangNhap, MatKhau = @MatKhau, HoTen = @HoTen, LoaiNV = @LoaiNV
		where MaNV = @MaNV
		set @Result = 1
	end
end



GO
/****** Object:  StoredProcedure [dbo].[usp_CapNhatPhieuMuon]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_CapNhatPhieuMuon] @MaCTPM char(10), @MaTaiLieu char(10), @MaTaiLieuCu char(10), @MaPhieuMuon char(10)
as
begin
	if exists (select * from [CHI TIET PHIEU MUON] where @MaCTPM = MaCTPM)
	begin
		update [CHI TIET PHIEU MUON]
		set MaTaiLieu = @MaTaiLieu
		where MaCTPM = @MaCTPM and MaPhieuMuon = @MaPhieuMuon and MaTaiLieu = @MaTaiLieuCu
	end
end
GO
/****** Object:  StoredProcedure [dbo].[usp_ChinhSuaPhieuTra]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ChinhSuaPhieuTra] @MaCTPT char(10), @MaPhieuTra char(10), @MaPhieuMuon char(10), @MaTaiLieu char(10)
as
begin
	if exists (Select * from [CHI TIET PHIEU TRA] where MaCTPT = @MaCTPT)
	begin
		update [CHI TIET PHIEU TRA]
		set MaPhieuTra = @MaPhieuTra, MaPhieuMuon = @MaPhieuMuon, MaTaiLieu = @MaTaiLieu
		where MaCTPT = @MaCTPT
	end
end	




GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteTaiLieu]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_DeleteTaiLieu] @MaTaiLieu nvarchar(50), @result int out
as
begin
	delete from [CHI TIET PHIEU TRA]
	where MaTaiLieu = @MaTaiLieu
	delete from [CHI TIET PHIEU MUON]
	where MaTaiLieu = @MaTaiLieu
	delete from [TAI LIEU]
	where MaTaiLieu = @MaTaiLieu
	set @result = 1
end


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertTaiLieu]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_InsertTaiLieu] @TenTaiLieu nvarchar(50), @LoaiTaiLieu nvarchar(30), @SoLuong int, @DacBiet bit
as
begin
	Declare @MaTaiLieu char(20)
	exec usp_TimMaTLTiepTheo @MaTaiLieu out
	insert into [TAI LIEU]
	values( @MaTaiLieu, @TenTaiLieu, @LoaiTaiLieu, @SoLuong, @DacBiet)
end
GO
/****** Object:  StoredProcedure [dbo].[usp_KiemTraMuonTaiLieuDacBiet]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_KiemTraMuonTaiLieuDacBiet] @MaDocGia char(10), @MaTaiLieu char(10), @result int out
as
begin
	Declare @TLDB bit
	Select @TLDB = ldg.TaiKieuDB from [DOC GIA] dg, [LOAI DOC GIA] ldg where dg.MaDocGia = @MaDocGia and dg.LoaiDG = ldg.MaLoaiDG
	Declare @DB bit
	Select @DB = DacBiet from [TAI LIEU] where MaTaiLieu = @MaTaiLieu
	print @TLDB
	print @DB
	if (@TLDB = @DB)
	begin
		set @result = 1
	end
	else set @result = 0
end

GO
/****** Object:  StoredProcedure [dbo].[usp_LayDanhSachDocGia]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LayDanhSachDocGia]
as
begin
	Select MaDocGia, HoTen From [DOC GIA]
end




GO
/****** Object:  StoredProcedure [dbo].[usp_LayDanhSachTaiLieu]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_LayDanhSachTaiLieu]
as
begin
	select MaTaiLieu, TenTaiLieu from [TAI LIEU] where SoLuong > 0
end




GO
/****** Object:  StoredProcedure [dbo].[usp_LayMaDocGiaDePhat]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_LayMaDocGiaDePhat] @MaPhieuMuon char(10), @MaDocGia char(10) out
as
begin
	select @MaDocGia = MaDocGia from [PHIEU MUON] where MaPhieuMuon = @MaPhieuMuon
end

GO
/****** Object:  StoredProcedure [dbo].[usp_LayMaNhanVienHienTai]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LayMaNhanVienHienTai] @UserName char(40), @MaNV nvarchar(10) out
as
begin
	select @MaNV =  nv.MaNV
	from [NHAN VIEN] nv
	where nv.HoTen = @UserName
end









GO
/****** Object:  StoredProcedure [dbo].[usp_LayMaTLCuaPM]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LayMaTLCuaPM] @MaPhieuMuon nchar(10)
as
begin
	select tl.MaTaiLieu, tl.TenTaiLieu from [PHIEU MUON] pm, [CHI TIET PHIEU MUON] ctpm, [TAI LIEU] tl
	where ctpm.MaPhieuMuon = pm.MaPhieuMuon and pm.MaPhieuMuon = @MaPhieuMuon and tl.MaTaiLieu = ctpm.MaTaiLieu
end








GO
/****** Object:  StoredProcedure [dbo].[usp_LayQuyenNhanVien]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LayQuyenNhanVien] @UserName char(40), @Pass nchar(200), @QuyenNV nvarchar(50) out
as
begin
	select @QuyenNV =  l.TenLoaiNV
	from [NHAN VIEN] nv, [LOAI NHANVIEN] l
	where nv.TenDangNhap = @UserName and nv.MatKhau = @Pass and l.MaLoaiNV = nv.LoaiNV
end










GO
/****** Object:  StoredProcedure [dbo].[usp_LaySoLanViPhamCuaPhieuMuon]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_LaySoLanViPhamCuaPhieuMuon] @MaPhieuMuon char(10), @SLVP int out
as
begin
	set @SLVP = 0
	if exists (select * from [PHIEU NHAC NHO] pnn , [PHIEU MUON] pm, [DOC GIA] dg where dg.MaDocGia = pnn.MaDocGia and dg.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon = @MaPhieuMuon)
	begin
	select @SLVP = pnn.SoLanViPham
	from [PHIEU NHAC NHO] pnn , [PHIEU MUON] pm, [DOC GIA] dg 
	where dg.MaDocGia = pnn.MaDocGia and dg.MaDocGia = pm.MaDocGia and pm.MaPhieuMuon = @MaPhieuMuon
	end
end

GO
/****** Object:  StoredProcedure [dbo].[usp_LaySoNgayQuaHan]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LaySoNgayQuaHan] @MaPhieuMuon char(10),  @NQH int out
as
begin
	select @NQH = datediff(day, NgayLapPhieuMuon, GETDATE()) 
	from [PHIEU MUON] 
	where MaPhieuMuon = @MaPhieuMuon
end

GO
/****** Object:  StoredProcedure [dbo].[usp_LaySoSachCuaPM]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LaySoSachCuaPM] @MaPhieuMuon char(10), @SoSach int out
as
begin
	select @SoSach = COUNT(ctpm.MaTaiLieu)
	from [PHIEU MUON] pm, [CHI TIET PHIEU MUON] ctpm
	where ctpm.MaPhieuMuon = pm.MaPhieuMuon and pm.MaPhieuMuon = @MaPhieuMuon
end

GO
/****** Object:  StoredProcedure [dbo].[usp_LaySoSachMuonToiDa]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LaySoSachMuonToiDa] @MaDocGia char (10), @Result int out
as
begin 
	select @Result = ldg.SoSachMuonToiDa from [DOC GIA] dg, [LOAI DOC GIA] ldg where dg.MaDocGia = @MaDocGia and dg.LoaiDG =  ldg.MaLoaiDG
end




GO
/****** Object:  StoredProcedure [dbo].[usp_LayTenNhanVien]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LayTenNhanVien] @UserName char(40), @Pass nchar(200), @TenNV nvarchar(50) out
as
begin
	select @TenNV =  nv.HoTen
	from [NHAN VIEN] nv
	where nv.TenDangNhap = @UserName and nv.MatKhau = @Pass
end









GO
/****** Object:  StoredProcedure [dbo].[usp_LoadLoaiDocGia]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LoadLoaiDocGia]
as
begin
	select * from [LOAI DOC GIA]
end



GO
/****** Object:  StoredProcedure [dbo].[usp_LoadMaPhieuMuon]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LoadMaPhieuMuon]
as
begin
	select MaPhieuMuon from [PHIEU MUON]
end

if OBJECT_ID('usp_LoadMaTLCuaPM') is not null
drop proc usp_LoadMaTLCuaPM









GO
/****** Object:  StoredProcedure [dbo].[usp_LoadTheLoaiTaiLieu]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LoadTheLoaiTaiLieu]
as
begin
	select distinct LoaiTaiLieu from [TAI LIEU]
end




GO
/****** Object:  StoredProcedure [dbo].[usp_Login]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Login] @username nchar(40), @password nchar(40), @result int out
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


GO
/****** Object:  StoredProcedure [dbo].[usp_SearchDocGia]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[usp_SearchDocGia] @MaDG char(15)
 as
 begin
	select *
	from [DOC GIA]
	where MaDocGia = @MaDG
 end










GO
/****** Object:  StoredProcedure [dbo].[usp_SearchPPTheoMaDG]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_SearchPPTheoMaDG] @MaDocGia char(10)
as
begin
	select pp.MaPhieuPhat, pp.MaNVLapPhieuPhat, pp.MaPhieuMuon, pp.SoSachQuaHan, pp.SoNgayQuaHan, pp.SoTienPhat from [PHIEU PHAT] pp, [PHIEU MUON] pm where pp.MaPhieuMuon = pm.MaPhieuMuon and pm.MaDocGia = @MaDocGia
end



GO
/****** Object:  StoredProcedure [dbo].[usp_SearchPPTheoMaPM]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_SearchPPTheoMaPM] @MaPhieuMuon char(10)
as
begin
	select * from [PHIEU PHAT] where MaPhieuMuon = @MaPhieuMuon
end



GO
/****** Object:  StoredProcedure [dbo].[usp_SearchPPTheoMaPP]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_SearchPPTheoMaPP] @MaPhieuPhat char(10)
as
begin
	select * from [PHIEU PHAT] where MaPhieuPhat = @MaPhieuPhat
end



GO
/****** Object:  StoredProcedure [dbo].[usp_SearchPhieuMuonTheoMaDocGia]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[usp_SearchPhieuMuonTheoMaDocGia] @MaDocGia char(10)
 as
 begin
	select *
	from [PHIEU MUON]
	where MaDocGia = @MaDocGia
 end









GO
/****** Object:  StoredProcedure [dbo].[usp_SearchPhieuMuonTheoMaPM]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[usp_SearchPhieuMuonTheoMaPM] @MaPhieuMuon char(10)
 as
 begin
	select * from [PHIEU MUON] where MaPhieuMuon = @MaPhieuMuon
 end









GO
/****** Object:  StoredProcedure [dbo].[usp_SearchPhieuNN]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[usp_SearchPhieuNN] @MaDocGia char(10)
as
begin
	select * from [PHIEU NHAC NHO] where MaDocGia = @MaDocGia
end



GO
/****** Object:  StoredProcedure [dbo].[usp_SearchPhieuTratheoMaDG]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[usp_SearchPhieuTratheoMaDG] @MaDocGia char(15)
 as
 begin
	select pt.MaPhieuTra, pt.MaNVLapPhieuTra
	from [PHIEU MUON] pm, [PHIEU TRA] pt, [CHI TIET PHIEU TRA]  ctpt
	where pm.MaPhieuMuon = ctpt.MaPhieuMuon and pt.MaPhieuTra = ctpt.MaPhieuTra and pm.MaDocGia = @MaDocGia
 end




GO
/****** Object:  StoredProcedure [dbo].[usp_SearchPhieuTratheoMaPM]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[usp_SearchPhieuTratheoMaPM] @Maphieumuon char(15)
 as
 begin
	select pt.MaPhieuTra, pt.MaNVLapPhieuTra
	from [CHI TIET PHIEU TRA] ctpt, [PHIEU TRA] pt
	where pt.MaPhieuTra = ctpt.MaPhieuTra and ctpt.MaPhieuMuon = @Maphieumuon
 end



GO
/****** Object:  StoredProcedure [dbo].[usp_SearchPhieuTratheoMaPT]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[usp_SearchPhieuTratheoMaPT] @Maphieutra char(15)
 as
 begin
	select *
	from  [PHIEU TRA] pt
	where pt.MaPhieuTra= @Maphieutra
 end



GO
/****** Object:  StoredProcedure [dbo].[usp_SearchTaiLieuTheoLoai]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_SearchTaiLieuTheoLoai] @LoaiTaiLieu nvarchar(50)
as
begin
	select * from [TAI LIEU]
	where LoaiTaiLieu = @LoaiTaiLieu
end










GO
/****** Object:  StoredProcedure [dbo].[usp_SearchTaiLieuTheoMa]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_SearchTaiLieuTheoMa] @MaTaiLieu char(15)
as
begin
	select * from [TAI LIEU]
	where MaTaiLieu = @MaTaiLieu
end










GO
/****** Object:  StoredProcedure [dbo].[usp_SearchTaiLieuTheoTen]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_SearchTaiLieuTheoTen] @TenTaiLieu nvarchar(50)
as
begin
	select * from [TAI LIEU]
	where TenTaiLieu like '%' + @TenTaiLieu + '%'
end









GO
/****** Object:  StoredProcedure [dbo].[usp_SoLanViPham]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_SoLanViPham] @MaDocGia char(10), @SoLanViPham int out
as
begin
	set @SoLanViPham = 0
	if exists (Select * from [PHIEU NHAC NHO] where MaDocGia = @MaDocGia)
	begin
		select @SoLanViPham = SoLanViPham from [PHIEU NHAC NHO] where MaDocGia = @MaDocGia
	end
end



GO
/****** Object:  StoredProcedure [dbo].[usp_SoSachDangMuon]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[usp_SoSachDangMuon] @MaDocGia char(10), @SoSachDangMuon int out
 as
 begin
	Declare @SoSachMuon int
	select @SoSachMuon = COUNT(distinct ctpm.MaTaiLieu)
	from [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg
	where ctpm.MaPhieuMuon = pm.MaPhieuMuon and pm.MaDocGia = dg.MaDocGia and dg.MaDocGia = @MaDocGia

	Declare @SoSachTra int
	select @SoSachTra = COUNT(distinct ctpt.MaTaiLieu)
	from [CHI TIET PHIEU TRA] ctpt, [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg
	where ctpt.MaPhieuMuon = pm.MaPhieuMuon and pm.MaPhieuMuon = ctpm.MaPhieuMuon and dg.MaDocGia = pm.MaDocGia and dg.MaDocGia = @MaDocGia
	set @SoSachDangMuon = @SoSachMuon - @SoSachTra
end

GO
/****** Object:  StoredProcedure [dbo].[usp_soTaiLieuMuonNhieuNhat]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_soTaiLieuMuonNhieuNhat]
as
begin
	SELECT 
  Top 10 tl.TenTaiLieu, ct.MaTaiLieu,tl.LoaiTaiLieu, COUNT(ct.MaTaiLieu) as 'SốLầnMượn' 
  FROM [CHI TIET PHIEU MUON] ct ,[TAI LIEU] tl
   where tl.MaTaiLieu = ct.MaTaiLieu
   GROUP BY 
   ct.MaTaiLieu ,tl.TenTaiLieu,tl.LoaiTaiLieu
   ORDER BY SốLầnMượn DESC
end



GO
/****** Object:  StoredProcedure [dbo].[usp_TimKiemDocGiaTheoCMND]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[usp_TimKiemDocGiaTheoCMND] @CMND char(15)
 as
 begin
	begin
		select MaDocGia, HoTen, CMND, LoaiDG, ((select COUNT(distinct ctpm.MaTaiLieu)
		from [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
		where ctpm.MaPhieuMuon = pm.MaPhieuMuon and pm.MaDocGia = dg1.MaDocGia and dg1.MaDocGia = dg.MaDocGia)
		-
		(select COUNT(distinct ctpt.MaTaiLieu)
		from [CHI TIET PHIEU TRA] ctpt, [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
		where ctpt.MaPhieuMuon = pm.MaPhieuMuon and pm.MaPhieuMuon = ctpm.MaPhieuMuon and dg1.MaDocGia = pm.MaDocGia and dg1.MaDocGia = dg.MaDocGia)) as N'Số Sách Đang Mượn', (select sum(pp.SoSachQuaHan)*1 from [PHIEU MUON] pm, [PHIEU PHAT] pp where pm.MaDocGia = dg.MaDocGia and pm.MaPhieuMuon = pp.MaPhieuMuon) as N'Số Sách Quá Hạn', dg.NgayHetHan
		from [DOC GIA] dg where dg.CMND = @CMND
	end
 end
GO
/****** Object:  StoredProcedure [dbo].[usp_TimKiemDocGiaTheoHoTen]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[usp_TimKiemDocGiaTheoHoTen] @HoTen nvarchar(100)
 as
 begin
		 begin
		select MaDocGia, HoTen, CMND, LoaiDG, ((select COUNT(distinct ctpm.MaTaiLieu)
		from [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
		where ctpm.MaPhieuMuon = pm.MaPhieuMuon and pm.MaDocGia = dg1.MaDocGia and dg1.MaDocGia = dg.MaDocGia)
		-
		(select COUNT(distinct ctpt.MaTaiLieu)
		from [CHI TIET PHIEU TRA] ctpt, [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
		where ctpt.MaPhieuMuon = pm.MaPhieuMuon and pm.MaPhieuMuon = ctpm.MaPhieuMuon and dg1.MaDocGia = pm.MaDocGia and dg1.MaDocGia = dg.MaDocGia)) as N'Số Sách Đang Mượn', (select sum(pp.SoSachQuaHan)*1 from [PHIEU MUON] pm, [PHIEU PHAT] pp where pm.MaDocGia = dg.MaDocGia and pm.MaPhieuMuon = pp.MaPhieuMuon) as N'Số Sách Quá Hạn'
		from [DOC GIA] dg where dg.HoTen like '%' + @HoTen + '%'
	end
 end
GO
/****** Object:  StoredProcedure [dbo].[usp_TimKiemDocGiaTheoMaDocGia]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_TimKiemDocGiaTheoMaDocGia] @MaDG char(15)
 as
 begin
	 begin
		select MaDocGia, HoTen, CMND, LoaiDG, ((select COUNT(distinct ctpm.MaTaiLieu)
		from [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
		where ctpm.MaPhieuMuon = pm.MaPhieuMuon and pm.MaDocGia = dg1.MaDocGia and dg1.MaDocGia = dg.MaDocGia)
		-
		(select COUNT(distinct ctpt.MaTaiLieu)
		from [CHI TIET PHIEU TRA] ctpt, [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
		where ctpt.MaPhieuMuon = pm.MaPhieuMuon and pm.MaPhieuMuon = ctpm.MaPhieuMuon and dg1.MaDocGia = pm.MaDocGia and dg1.MaDocGia = dg.MaDocGia)) as N'Số Sách Đang Mượn', (select sum(pp.SoSachQuaHan)*1 from [PHIEU MUON] pm, [PHIEU PHAT] pp where pm.MaDocGia = dg.MaDocGia and pm.MaPhieuMuon = pp.MaPhieuMuon) as N'Số Sách Quá Hạn'
		from [DOC GIA] dg where dg.MaDocGia = @MaDG
	end
 end
GO
/****** Object:  StoredProcedure [dbo].[usp_TimKiemDocGiaTheoMSCB]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[usp_TimKiemDocGiaTheoMSCB] @MSCB char(15)
 as
 begin
	 begin
		select MaDocGia, HoTen, CMND, LoaiDG, ((select COUNT(distinct ctpm.MaTaiLieu)
		from [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
		where ctpm.MaPhieuMuon = pm.MaPhieuMuon and pm.MaDocGia = dg1.MaDocGia and dg1.MaDocGia = dg.MaDocGia)
		-
		(select COUNT(distinct ctpt.MaTaiLieu)
		from [CHI TIET PHIEU TRA] ctpt, [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
		where ctpt.MaPhieuMuon = pm.MaPhieuMuon and pm.MaPhieuMuon = ctpm.MaPhieuMuon and dg1.MaDocGia = pm.MaDocGia and dg1.MaDocGia = dg.MaDocGia)) as N'Số Sách Đang Mượn', (select sum(pp.SoSachQuaHan)*1 from [PHIEU MUON] pm, [PHIEU PHAT] pp where pm.MaDocGia = dg.MaDocGia and pm.MaPhieuMuon = pp.MaPhieuMuon) as N'Số Sách Quá Hạn'
		from [DOC GIA] dg where dg.MCB =  @MSCB
	end
 end
GO
/****** Object:  StoredProcedure [dbo].[usp_TimKiemDocGiaTheoMSSV]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[usp_TimKiemDocGiaTheoMSSV] @MSSV char(15)
 as
 begin
	 begin
		select MaDocGia, HoTen, CMND, LoaiDG, ((select COUNT(distinct ctpm.MaTaiLieu)
		from [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
		where ctpm.MaPhieuMuon = pm.MaPhieuMuon and pm.MaDocGia = dg1.MaDocGia and dg1.MaDocGia = dg.MaDocGia)
		-
		(select COUNT(distinct ctpt.MaTaiLieu)
		from [CHI TIET PHIEU TRA] ctpt, [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
		where ctpt.MaPhieuMuon = pm.MaPhieuMuon and pm.MaPhieuMuon = ctpm.MaPhieuMuon and dg1.MaDocGia = pm.MaDocGia and dg1.MaDocGia = dg.MaDocGia)) as N'Số Sách Đang Mượn', (select sum(pp.SoSachQuaHan)*1 from [PHIEU MUON] pm, [PHIEU PHAT] pp where pm.MaDocGia = dg.MaDocGia and pm.MaPhieuMuon = pp.MaPhieuMuon) as N'Số Sách Quá Hạn'
		from [DOC GIA] dg where dg.MSSV =  @MSSV
	end
 end
GO
/****** Object:  StoredProcedure [dbo].[usp_TimKiemTatCaDocGia]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[usp_TimKiemTatCaDocGia]
 as
 begin
	Declare @SoSachDangMuon int
	select MaDocGia, HoTen, CMND, LoaiDG, ((select COUNT(distinct ctpm.MaTaiLieu)
	from [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
	where ctpm.MaPhieuMuon = pm.MaPhieuMuon and pm.MaDocGia = dg1.MaDocGia and dg1.MaDocGia = dg.MaDocGia)
	-
	(select COUNT(distinct ctpt.MaTaiLieu)
	from [CHI TIET PHIEU TRA] ctpt, [CHI TIET PHIEU MUON] ctpm, [PHIEU MUON] pm, [DOC GIA] dg1
	where ctpt.MaPhieuMuon = pm.MaPhieuMuon and pm.MaPhieuMuon = ctpm.MaPhieuMuon and dg1.MaDocGia = pm.MaDocGia and dg1.MaDocGia = dg.MaDocGia)) as N'Số Sách Đang Mượn', (select sum(pp.SoSachQuaHan)*1 from [PHIEU MUON] pm, [PHIEU PHAT] pp where pm.MaDocGia = dg.MaDocGia and pm.MaPhieuMuon = pp.MaPhieuMuon) as N'Số Sách Quá Hạn'
	from [DOC GIA] dg
 end


GO
/****** Object:  StoredProcedure [dbo].[usp_TimMaCTPTTiepTheo]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_TimMaCTPTTiepTheo] @MaCTPT nchar(10) out
as 
begin
declare @ctpt nchar(10)='CTPT001'
declare @idx int 
	set @idx = 1
	while exists (select MaPhieuTra from [PHIEU Tra] Where MaPhieuTra = @ctpt)
	begin
		set @idx = @idx + 1
		set @ctpt= 'CTPT' + REPLICATE('0', 3 - len(cast(@idx as varchar))) + cast(@idx as varchar)
	end
	Set  @MaCTPT=@ctpt
end









GO
/****** Object:  StoredProcedure [dbo].[usp_TimMaChiTietPhieuMuonTiepTheo]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_TimMaChiTietPhieuMuonTiepTheo] @MaCTPM nchar(10) out
as 
begin
	declare @mactpm1 nchar(10) = 'CTPM001'
	declare @idx int 
	set @idx = 1
	while exists (select MaCTPM from [CHI TIET PHIEU MUON] Where MaCTPM = @mactpm1)
	begin
		set @idx = @idx + 1
		set @mactpm1= 'CTPM' + REPLICATE('0', 3 - len(cast(@idx as varchar))) + cast(@idx as varchar)
	end
	Set  @MaCTPM = @mactpm1
end


if OBJECT_ID('usp_ThemCTietPhieuMuon') is not null
 Drop proc usp_ThemCTietPhieuMuon









GO
/****** Object:  StoredProcedure [dbo].[usp_TimMaDGTiepTheo]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_TimMaDGTiepTheo] @MaDocGia varchar(10) out
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










GO
/****** Object:  StoredProcedure [dbo].[usp_TimMaNVTiepTheo]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_TimMaNVTiepTheo] @MaNV varchar(10) out
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










GO
/****** Object:  StoredProcedure [dbo].[usp_TimMaPhieuMuonTiepTheo]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_TimMaPhieuMuonTiepTheo] @Maphieumuon nchar(10) out
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









GO
/****** Object:  StoredProcedure [dbo].[usp_TimMaPhieuPhatTiepTheo]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_TimMaPhieuPhatTiepTheo] @MaPhieuPhat nchar(10) out
as 
begin
	declare @pp nchar(10)='PP001'
	declare @idx int 
	set @idx = 1
	while exists (select MaPhieuPhat from [PHIEU PHAT] Where MaPhieuPhat = @pp)
	begin
		set @idx = @idx + 1
		set @pp= 'PP' + REPLICATE('0', 3 - len(cast(@idx as varchar))) + cast(@idx as varchar)
	end
	Set  @MaPhieuPhat= @pp
end





GO
/****** Object:  StoredProcedure [dbo].[usp_TimMaPhieuTraTiepTheo]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_TimMaPhieuTraTiepTheo] @MaPhieuTra nchar(10) out
as 
begin
declare @mapt nchar(10)='PT001'
declare @idx int 
	set @idx = 1
	while exists (select MaPhieuTra from [PHIEU Tra] Where MaPhieuTra = @Mapt)
	begin
		set @idx = @idx + 1
		set @mapt= 'PT' + REPLICATE('0', 3 - len(cast(@idx as varchar))) + cast(@idx as varchar)
	end
	Set  @MaPhieuTra=@Mapt
end










GO
/****** Object:  StoredProcedure [dbo].[usp_TimMaTLTiepTheo]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_TimMaTLTiepTheo] @MaTaiLieu varchar(10) out
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









GO
/****** Object:  StoredProcedure [dbo].[usp_ThemChiTietPhieuMuon]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ThemChiTietPhieuMuon] @MaCTPM char(10), @MaTaiLieu nchar(10), @MaPhieuMuon nchar(10)
as
begin
	insert into [CHI TIET PHIEU MUON]
	values(@MaCTPM,@MaTaiLieu , @MaPhieuMuon)
	update [TAI LIEU]
	set SoLuong -= 1
	where MaTaiLieu = @MaTaiLieu
end






GO
/****** Object:  StoredProcedure [dbo].[usp_ThemChiTietPhieuTra]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ThemChiTietPhieuTra] @MaCTPT nchar(10), @MaPhieuTra nchar(10), @MaPhieuMuon nchar(10), @MaTaiLieu nchar(10)
as
begin
	if exists (select * from [PHIEU TRA] pt, [TAI LIEU] tl where pt.MaPhieuTra = @MaPhieuTra and tl.MaTaiLieu = @MaTaiLieu)
	begin
	insert into [CHI TIET PHIEU TRA]
	values(@MaCTPT, @MaPhieuTra, @MaPhieuMuon ,@MaTaiLieu)
	update [TAI LIEU]
	set SoLuong += 1
	where MaTaiLieu = @MaTaiLieu
	end
end






GO
/****** Object:  StoredProcedure [dbo].[usp_ThemDocGia]    Script Date: 1/3/2018 11:27:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ThemDocGia] @TenDG nvarchar(40), @NgaySinhDG nvarchar(20), @DiaChiDG nvarchar(100), @SDTDG nvarchar(20), @EmailDG nvarchar(30), @CMNDDG nvarchar(20),@MSSVDG nvarchar(20), @MCBDG nvarchar(20), @LoaiDG nvarchar(20)
as
begin
	Declare @MaDG nchar(10)
	exec usp_TimMaDGTiepTheo @MaDG out
	Declare @NgayHetHan date

	 if exists( select * from [DOC GIA] where LoaiDG= 'SV')
	begin
	set @NgayHetHan=DATEADD(day,300,GETDATE())
	end
	else if exists( select * from [DOC GIA] where LoaiDG='K')
	begin
		set @NgayHetHan=DATEADD(day,200,GETDATE())
	end
	else if exists(select * from [DOC GIA] where loaidg='CBNV')
	begin 
	set @NgayHetHan=DATEADD(day,250,GETDATE())
	end	
	insert into [DOC GIA]
	values(@MaDG, @TenDG,@NgaySinhDG, @DiaChiDG, @SDTDG, @EmailDG, @CMNDDG, @MSSVDG, @MCBDG, @LoaiDG,@NgayHetHan)
end

go
create proc sp_KiemtraHetHan @madg nchar(10),@thongbao nvarchar(10) out
 as 
 begin
	if exists( select * from [DOC GIA] where  @madg=MaDocGia and DATEDIFF(day,NgayHetHan,GETDATE())<0)
	  begin set @thongbao='1'
	  end
	else
		set @thongbao = '0'
  end
  go
 create proc sp_NgayHetHan @loaidg nchar(10), @madg nchar(10)
 as
 begin
 declare @ngayHH date
  if exists( select * from [DOC GIA] where LoaiDG= 'SV')
  begin
	update  [DOC GIA] set NgayHetHan=DATEADD(day,300,GETDATE()) where @madg=MaDocGia
	end
	else if exists( select * from [DOC GIA] where LoaiDG='K')
	begin
		update [DOC GIA] set NgayHetHan=DATEADD(day,200,GETDATE()) where @madg=MaDocGia
		end
	else if exists(select * from [DOC GIA] where loaidg='CBNV')
	begin 
	update [DOC GIA] set NgayHetHan=DATEADD(day,250,GETDATE()) where @madg=MaDocGia
	end

end

GO
/****** Object:  StoredProcedure [dbo].[usp_ThemNhanVien]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ThemNhanVien] @CaTruc nvarchar(40), @TenDangNhap nvarchar(20), @HoTen nvarchar(100), @MatKhau nchar(200), @LoaiNV nvarchar(20),@result int out
as
begin
	Declare @MaNV nchar(10)
	exec usp_TimMaNVTiepTheo @MaNV out
	if not exists (select * from  [NHAN VIEN] nv
	where nv.TenDangNhap = @TenDangNhap)
	begin
	insert into [NHAN VIEN]
	values(@MaNV, @CaTruc ,@TenDangNhap, @MatKhau, @HoTen, GETDATE(), @LoaiNV)
	end
	else
	begin
	set @result = 0;
	end
end


GO
/****** Object:  StoredProcedure [dbo].[usp_ThemPhieuMuon]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ThemPhieuMuon] @MaNVLapPhieuMuon nchar(10), @MaDocGia nchar(10), @result int out
as
begin
	set @result = 0
	Declare @SoLanViPham int = 0
	if exists ( select * from [PHIEU NHAC NHO] where MaDocGia = @MaDocGia)
	begin
		Select @SoLanViPham = pnn.SoLanViPham from [PHIEU NHAC NHO] pnn where pnn.MaDocGia = @MaDocGia
	end
	print @SoLanViPham
	if(@SoLanViPham < 5)
	begin
		Declare @Mapm nchar(10)
		exec usp_TimMaPhieuMuonTiepTheo @Mapm out
		insert into [PHIEU MUON]
		values(@Mapm,@MaNVLapPhieuMuon ,@MaDocGia,GETDATE())
		set @result = 1
	end
end



GO
/****** Object:  StoredProcedure [dbo].[usp_ThemPhieuNhacNho]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ThemPhieuNhacNho] @MaDocGia char(10)
as
begin
	if exists (select * from [PHIEU NHAC NHO] where MaDocGia = @MaDocGia)
	begin
		update [PHIEU NHAC NHO]
		set SoLanViPham += 1
		where MaDocGia = @MaDocGia
	end
	else
	begin
		insert into [PHIEU NHAC NHO]
		values(@MaDocGia, 1)
	end
end


GO
/****** Object:  StoredProcedure [dbo].[usp_ThemPhieuPhat]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ThemPhieuPhat] @MaPhieuMuon nchar(10), @MaNVLapPhieuPhat nchar(10), @Result int out
as
begin
	set @Result = 0
	Declare @MaPP char(10)
	exec [usp_TimMaPhieuPhatTiepTheo] @MaPP out
	Declare @SoSachQuaHan int
	Declare @SoSachMuon int
	select @SoSachMuon = COUNT(ctpm.MaTaiLieu)
	from [CHI TIET PHIEU MUON] ctpm
	where ctpm.MaPhieuMuon = @MaPhieuMuon
	Declare @SoSachTra int
	select @SoSachTra = COUNT(ctpt.MaTaiLieu)
	from [CHI TIET PHIEU TRA] ctpt
	where ctpt.MaPhieuMuon = @MaPhieuMuon
	set @SoSachQuaHan = @SoSachMuon - @SoSachTra
	Declare @SoNgayQuaHan int
	select @SoNgayQuaHan = DATEDIFF(DAY, pm.NgayLapPhieuMuon, GETDATE()) - ldg.SoNgayMuonToiDa from [PHIEU MUON] pm , [DOC GIA] dg, [LOAI DOC GIA] ldg where pm.MaPhieuMuon = @MaPhieuMuon and pm.MaDocGia = dg.MaDocGia and dg.LoaiDG = ldg.MaLoaiDG
	
	Declare @SoTienPhat int
	Set @SoTienPhat = (@SoNgayQuaHan*5000) + (@SoSachQuaHan * 50000)

	Declare @SoLanViPham int
	Select @SoLanViPham = pnn.SoLanViPham from [PHIEU NHAC NHO] pnn, [PHIEU MUON] pm, [DOC GIA] dg
	where pnn.MaDocGia = dg.MaDocGia and pm.MaDocGia = pnn.MaDocGia and pm.MaPhieuMuon = @MaPhieuMuon
	if(@SoLanViPham >= 2 and @SoNgayQuaHan > 0)
	begin
		insert into [PHIEU PHAT]
		values(@MaPP,  @MaNVLapPhieuPhat, @MaPhieuMuon, @SoSachQuaHan, @SoNgayQuaHan, @SoTienPhat)
		set @Result = 1
		update [PHIEU NHAC NHO]
		set SoLanViPham += 1
		where MaDocGia = (Select dg.MaDocGia from [PHIEU NHAC NHO] pnn, [PHIEU MUON] pm, [DOC GIA] dg
	where pnn.MaDocGia = dg.MaDocGia and pm.MaDocGia = pnn.MaDocGia and pm.MaPhieuMuon = @MaPhieuMuon)
	end
end

GO
/****** Object:  StoredProcedure [dbo].[usp_ThemPhieuTra]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ThemPhieuTra] @MaPhieuTra char(10), @MaNVLapPhieuTra nchar(10)
as
begin
	insert into [PHIEU TRA]
	values(@MaPhieuTra, @MaNVLapPhieuTra)
end






GO
/****** Object:  StoredProcedure [dbo].[usp_ThemYeuCauTaiLieu]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ThemYeuCauTaiLieu]  @TenTLYeuCau nvarchar(200), @result int out
as
begin
	set @result = 0
	if not exists(select * from [YEU CAU TAI LIEU] where TenTaiLieu = @TenTLYeuCau)
	begin
		declare @seed int = (select count(*) from [YEU CAU TAI LIEU])
		if (@seed = 1)
			set @seed = 1;
		else
			set @seed = @seed - 1;
		DBCC CHECKIDENT ([YEU CAU TAI LIEU], RESEED, @seed)	
		insert into [YEU CAU TAI LIEU] values(@TenTLYeuCau)
		set @result = 1
		
	end
end
--------------------------------------------======================================







GO
/****** Object:  StoredProcedure [dbo].[usp_UpdatePNN]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_UpdatePNN] @MaDocGia char(10), @SLVP int
as
begin
	if exists (select * from [PHIEU NHAC NHO] where MaDocGia = @MaDocGia)
	begin
		update [PHIEU NHAC NHO]
		set SoLanViPham = @SLVP
		where MaDocGia = @MaDocGia
	end
end



GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateTaiLieu]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_UpdateTaiLieu] @MaTaiLieu char(20), @TenTaiLieu nvarchar(50), @LoaiTaiLieu nvarchar(30), @SoLuong int, @DacBiet bit
as
begin
	update [TAI LIEU]
	set TenTaiLieu = @TenTaiLieu, LoaiTaiLieu = @LoaiTaiLieu, SoLuong = @SoLuong, DacBiet = @DacBiet
	where MaTaiLieu = @MaTaiLieu
end
GO
/****** Object:  StoredProcedure [dbo].[usp_XemAllTaiLieu]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XemAllTaiLieu]
as
begin
	select * from [TAI LIEU]
end









GO
/****** Object:  StoredProcedure [dbo].[usp_XemCTPhieuTra]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XemCTPhieuTra] @MaPhieuTra nchar(10)
as
begin
	select * from [CHI TIET PHIEU TRA] where MaPhieuTra = @MaPhieuTra
end









GO
/****** Object:  StoredProcedure [dbo].[usp_xemChiTietPhieuMuon]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_xemChiTietPhieuMuon] @MaPhieuMuon char(10)
as
begin
	select * from [CHI TIET PHIEU MUON] where MaPhieuMuon = @MaPhieuMuon
end









GO
/****** Object:  StoredProcedure [dbo].[usp_XemDocGia]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XemDocGia]
as
begin
	select * from [DOC GIA]
end











GO
/****** Object:  StoredProcedure [dbo].[usp_XemNhanVien]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_XemNhanVien]
as
begin
	select * from [NHAN VIEN]
end


GO
/****** Object:  StoredProcedure [dbo].[usp_xemPhieuMuon]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_xemPhieuMuon]
as
begin
	select * from [PHIEU MUON]
end









GO
/****** Object:  StoredProcedure [dbo].[usp_XemPhieuNhacNho]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XemPhieuNhacNho]
as
begin
	select * from [PHIEU NHAC NHO]
end









GO
/****** Object:  StoredProcedure [dbo].[usp_XemPhieuPhat]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XemPhieuPhat]
as
begin
	select * from [PHIEU PHAT]
end
exec usp_XemPhieuPhat









GO
/****** Object:  StoredProcedure [dbo].[usp_XemPhieuTra]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XemPhieuTra]
as
begin
	select * from [PHIEU TRA]
end









GO
/****** Object:  StoredProcedure [dbo].[usp_XemYeuCauTaiLieu]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XemYeuCauTaiLieu]  
as
begin
	select * from [YEU CAU TAI LIEU]
end
--===============------------------------------







GO
/****** Object:  StoredProcedure [dbo].[usp_XoaDocGia]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_XoaDocGia] @MaDocGia char(10)
as
begin
	declare @MaPM char(10)
	declare @MaDG char(10)
	declare cur cursor
	for select MaPhieuMuon, MaDocGia from [PHIEU MUON] where MaDocGia = @MaDocGia
	open cur
	fetch next from cur into @MaPM, @MaDG
	while(@@FETCH_STATUS = 0)
	begin
		Declare @MaPHIEUTRA char(10)
		declare cur2 cursor
		for select distinct pt.MaPhieuTra from [PHIEU TRA] pt, [CHI TIET PHIEU TRA] ctpt where pt.MaPhieuTra = ctpt.MaPhieuTra and ctpt.MaPhieuMuon = @MaPM
		open cur2
		fetch next from cur2 into @MaPHIEUTRA
		
		while(@@FETCH_STATUS = 0)
		begin
			delete from [CHI TIET PHIEU TRA]
			where MaPhieuTra = @MaPHIEUTRA
			delete from [PHIEU TRA]
			where MaPhieuTra  = @MaPHIEUTRA
			fetch next from cur2 into @MaPHIEUTRA
		end
		close cur2
		deallocate cur2

		delete from [PHIEU NHAC NHO]
		where MaDocGia = @MaDG
		delete from [PHIEU PHAT]
		where MaPhieuMuon = @MaPM
		delete from [CHI TIET PHIEU MUON]
		where MaPhieuMuon = @MaPM
		delete from [PHIEU MUON]
		where MaPhieuMuon = @MaPM
		fetch next from cur into @MaPM, @MaDG
	end
	close cur
	deallocate cur
	delete from [PHIEU NHAC NHO]
	where MaDocGia = @MaDocGia
	delete from [DOC GIA]
	where MaDocGia = @MaDocGia
end


GO
/****** Object:  StoredProcedure [dbo].[usp_XoaNhanVien]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_XoaNhanVien] @MaNV nvarchar(50)
as
begin
	delete from [PHIEU PHAT]
	where MaNVLapPhieuPhat = @MaNV
	delete from [PHIEU TRA]
	where MaNVLapPhieuTra = @MaNV
	delete from [PHIEU MUON]
	where MaNVLapPhieuMuon = @MaNV
	delete from [NHAN VIEN]
	where MaNV = @MaNV
end


GO
/****** Object:  StoredProcedure [dbo].[usp_XoaPhieuMuon]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[usp_XoaPhieuMuon] @MaPhieuMuon char(10)
 as
 begin
	delete from [PHIEU PHAT]
	where MaPhieuMuon= @MaPhieuMuon
	delete from [CHI TIET PHIEU TRA]
	where MaPhieuMuon= @MaPhieuMuon
	delete from [PHIEU TRA]
	where MaPhieuTra = (select pt.MaPhieuTra from [PHIEU TRA] pt, [CHI TIET PHIEU TRA] ctpt where ctpt.MaPhieuTra =  pt.MaPhieuTra and ctpt.MaPhieuMuon = @MaPhieuMuon)
	delete from [CHI TIET PHIEU MUON]
	where MaPhieuMuon= @MaPhieuMuon
	delete from [PHIEU MUON]
	where MaPhieuMuon= @MaPhieuMuon
 end


GO
/****** Object:  StoredProcedure [dbo].[usp_XoaPhieuNhacNho]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XoaPhieuNhacNho] @MaDocGia char(10)
as
begin
	delete from [PHIEU NHAC NHO]
	where MaDocGia = @MaDocGia
end




GO
/****** Object:  StoredProcedure [dbo].[usp_XoaPhieuPhat]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XoaPhieuPhat] @MaPhieuPhat char(10)
as
begin
	delete from [PHIEU PHAT]
	where MaPhieuPhat = @MaPhieuPhat
end





GO
/****** Object:  StoredProcedure [dbo].[usp_Xoaphieutra]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[usp_Xoaphieutra] @Maphieutra char(15)
 as
 begin
	delete from [CHI TIET PHIEU TRA]
	where MaPhieuTra= @Maphieutra
	delete from [PHIEU TRA] 
	where MaPhieuTra= @Maphieutra
 end










GO
/****** Object:  StoredProcedure [dbo].[usp_XoaYeuCauTaiLieuMoi]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XoaYeuCauTaiLieuMoi]  @TenTLYeuCau nvarchar(200)
as
begin		
	delete from [YEU CAU TAI LIEU] where TenTaiLieu = @TenTLYeuCau
	declare @seed int = (select count(*) from [YEU CAU TAI LIEU])
	if (@seed = 1)
		set @seed = 1;
	else
		set @seed = @seed - 1;
	DBCC CHECKIDENT ([YEU CAU TAI LIEU], RESEED, @seed)	
end







GO
/****** Object:  Table [dbo].[CHI TIET PHIEU MUON]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHI TIET PHIEU MUON](
	[MaCTPM] [nchar](10) NOT NULL,
	[MaTaiLieu] [nchar](10) NOT NULL,
	[MaPhieuMuon] [nchar](10) NOT NULL,
 CONSTRAINT [PK_CHI TIET PHIEU MUON] PRIMARY KEY CLUSTERED 
(
	[MaCTPM] ASC,
	[MaTaiLieu] ASC,
	[MaPhieuMuon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CHI TIET PHIEU TRA]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHI TIET PHIEU TRA](
	[MaCTPT] [nchar](10) NOT NULL,
	[MaPhieuTra] [nchar](10) NOT NULL,
	[MaPhieuMuon] [nchar](10) NOT NULL,
	[MaTaiLieu] [nchar](10) NOT NULL,
 CONSTRAINT [PK_CHI TIET PHIEU TRA] PRIMARY KEY CLUSTERED 
(
	[MaCTPT] ASC,
	[MaPhieuTra] ASC,
	[MaPhieuMuon] ASC,
	[MaTaiLieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DOC GIA]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOC GIA](
	[MaDocGia] [nchar](10) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[DiaChi] [nvarchar](100) NULL,
	[Sdt] [nchar](20) NULL,
	[Email] [nvarchar](50) NULL,
	[CMND] [nchar](12) NULL,
	[MSSV] [nchar](10) NULL,
	[MCB] [nchar](10) NULL,
	[LoaiDG] [nchar](10) NULL,
	[NgayHetHan][date] Null,
 CONSTRAINT [PK_DOC GIA] PRIMARY KEY CLUSTERED 
(
	[MaDocGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LOAI DOC GIA]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAI DOC GIA](
	[MaLoaiDG] [nchar](10) NOT NULL,
	[SoNgayMuonToiDa] [int] NULL,
	[SoSachMuonToiDa] [int] NULL,
	[TenLoaiDG] [nvarchar](50) NULL,
	[PhiThuongNien] [int] NULL,
	[TaiKieuDB] [bit] NULL,
 CONSTRAINT [PK_LOAI DOC GIA] PRIMARY KEY CLUSTERED 
(
	[MaLoaiDG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LOAI NHANVIEN]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAI NHANVIEN](
	[MaLoaiNV] [nchar](10) NOT NULL,
	[TenLoaiNV] [nvarchar](50) NULL,
 CONSTRAINT [PK_LOAI NHANVIEN] PRIMARY KEY CLUSTERED 
(
	[MaLoaiNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LOGIN REMEMBER]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOGIN REMEMBER](
	[Username] [nchar](30) NOT NULL,
	[Password] [nchar](30) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NHAN VIEN]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHAN VIEN](
	[MaNV] [nchar](10) NOT NULL,
	[CaTruc] [int] NULL,
	[TenDangNhap] [nchar](10) NULL,
	[MatKhau] [nchar](200) NULL,
	[HoTen] [nvarchar](50) NULL,
	[LoginGanNhat] [date] NULL,
	[LoaiNV] [nchar](10) NULL,
 CONSTRAINT [PK_NHAN VIEN] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NHAP TAI LIEU]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHAP TAI LIEU](
	[MaTLNhap] [nchar](10) NOT NULL,
	[SoLuong] [int] NULL,
	[NgayNhap] [date] NOT NULL,
 CONSTRAINT [PK_NHAP TAI LIEU_1] PRIMARY KEY CLUSTERED 
(
	[MaTLNhap] ASC,
	[NgayNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PHIEU MUON]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEU MUON](
	[MaPhieuMuon] [nchar](10) NOT NULL,
	[MaNVLapPhieuMuon] [nchar](10) NULL,
	[MaDocGia] [nchar](10) NULL,
	[NgayLapPhieuMuon] [date] NULL,
 CONSTRAINT [PK_PHIEU MUON] PRIMARY KEY CLUSTERED 
(
	[MaPhieuMuon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PHIEU NHAC NHO]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEU NHAC NHO](
	[MaDocGia] [nchar](10) NOT NULL,
	[SoLanViPham] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PHIEU PHAT]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEU PHAT](
	[MaPhieuPhat] [nchar](10) NOT NULL,
	[MaNVLapPhieuPhat] [nchar](10) NULL,
	[MaPhieuMuon] [nchar](10) NULL,
	[SoSachQuaHan] [int] NULL,
	[SoNgayQuaHan] [int] NULL,
	[SoTienPhat] [int] NULL,
 CONSTRAINT [PK_PHIEU PHAT] PRIMARY KEY CLUSTERED 
(
	[MaPhieuPhat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PHIEU TRA]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEU TRA](
	[MaPhieuTra] [nchar](10) NOT NULL,
	[MaNVLapPhieuTra] [nchar](10) NULL,
 CONSTRAINT [PK_PHIEU TRA_1] PRIMARY KEY CLUSTERED 
(
	[MaPhieuTra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TAI LIEU]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TAI LIEU](
	[MaTaiLieu] [nchar](10) NOT NULL,
	[TenTaiLieu] [nvarchar](200) NULL,
	[LoaiTaiLieu] [nvarchar](50) NULL,
	[SoLuong] [int] NULL,
	[DacBiet] [bit] NULL,
 CONSTRAINT [PK_SACH] PRIMARY KEY CLUSTERED 
(
	[MaTaiLieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[YEU CAU TAI LIEU]    Script Date: 1/3/2018 5:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YEU CAU TAI LIEU](
	[STT] [int] IDENTITY(1,1) NOT NULL,
	[TenTaiLieu] [nvarchar](200) NULL
) ON [PRIMARY]

GO
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00001   ', N'NGUYỄN THỊ THÚY KIỀU
', CAST(0xFA1C0B00 AS Date), N'241/213 LÍ THÁI TỔ, Q3, TP HCM', N'01649824548
       ', N'thuykieu@gmail.com', N'023177128
 ', N'1560286
 ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00002   ', N'Nguyễn Duy Quyết', CAST(0x553B0B00 AS Date), N'Quận Tân Phú, HCM', N'01689957265         ', N'quyetdakmil@gmail.com', N'245260278   ', N'1560454   ', N'245260278 ', N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00003   ', N'HOÀNG ĐÌNH TUẤN KIỆT
', CAST(0x50170B00 AS Date), N'12/42 NGUYỄN VĂN CỪ,Q5,TPHCM', N'0908420792
        ', N'tuankiet1@gmail.com', N'250533628
 ', N'1560288   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00004   ', N'NGUYỄN TUẤN KIỆT
', CAST(0xEF1E0B00 AS Date), N'317 đường Tây Thanh, Q. Tân Phú tp HCM
', N'01666646895
       ', N'ngkiet@gmail.com', N'334166032
 ', N'1560289   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00005   ', N'NGUYỄN THỊ THANH LAN
', CAST(0xC2220B00 AS Date), N'451 Bình Đông P13 Q8 HCM
', N'0974105576
        ', N'thanhlan@gmail.com', N'182116400
 ', N'1560290   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00006   ', N'NGUYỄN HOÀNG LÂM
', CAST(0x38210B00 AS Date), N'978 Hậu Giang, P11, Q6
', N'0979235435
        ', N'hoanglam1@gmail.com', N'022106702
 ', N'1560291   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00007   ', N'TĂNG TRƯỜNG LÂM
', CAST(0x6B210B00 AS Date), N'44 Phan Ngữ, Q1,TP HCM
', N'0913120233
        ', N'truonglam@gmail.com', N'363633920
 ', N'1560292   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00008   ', N'VÕ SONG LÂM
', CAST(0x521E0B00 AS Date), N'1127/12 Trần Bình Trọng, P2, Q5, TPHCM
', N'0983058335
        ', N'binhlieu@yahoo.com', N'191514084
 ', N'1560293   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00009   ', N'TRẦN BÌNH LIÊU
', CAST(0x6B1F0B00 AS Date), N'28 CAM ĐÀO MỘC, P4 Q8 TPHCM
', N'0988807188
        ', N'hieplinh1@yahoo.com', N'023369993
 ', N'1560294   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00010   ', N'NGUYỄN HIỆP LINH
', CAST(0x311C0B00 AS Date), N'1221/2 nguyễn kiệm, gò vấp
', N'0977412102
        ', N'hieplinh@gmail.com', N'023436305
 ', N'1560295   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00011   ', N'HOÀNG ĐÌNH LONG
', CAST(0xD7E30A00 AS Date), N'6/12 Nguyễn Siêu-p.Bến Nghé-HCM 
', N'0907201996
        ', N'dinhlong2@yahoo.com', N'334408858
 ', NULL, N'CB100000  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00012   ', N'TẠ NGỌC LONG
', CAST(0xA7F80A00 AS Date), N' 321 Trương Định, Q3 TP HCM
', N'0914010406
        ', N'ngoclong@gmail.com', N'022337240
 ', NULL, N'CB100001  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00013   ', N'LÊ PHÁT LỘC
', CAST(0x60050B00 AS Date), N'385 Trường Chinh, F7, Q11.HCM', N'0955248056
        ', N'phatloc21@yahoo.com', N'351915554
 ', NULL, N'CB100002  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00014   ', N'LỢI PHÚC LỘC
', CAST(0xDFEA0A00 AS Date), N' 24-24 Phó Đức Chính, p.Nguyễn Thái Bình, q1
', N'0918206680
        ', N'phuclocc@yahoo.com', N'191514021   ', NULL, N'CB100003  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00015   ', N'NGUYỄN THẾ LỢI
', CAST(0x6DFD0A00 AS Date), N'PHAN XÍCH LONG, P16, Q11, TPHCM
', N'0975371451
        ', N'theloi@yahoo.com', N'212144786
 ', NULL, N'CB100004  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00016   ', N'ĐINH CÔNG LUÂN
', CAST(0x64E30A00 AS Date), N'427/28 Minh Phụng, P10, Q10, HCM
', N'0977694677
        ', N'dinhluan21@yahoo.com', N'142027604
 ', NULL, N'CB100005  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00017   ', N'PHẠM ĐÌNH LUÂN
', CAST(0x2E1F0B00 AS Date), N'225 Tô Hiến Thành, p13, Q10, TPHCM
', N'0903113887
        ', N'dinhluan@gmail.com', N'260558757
 ', NULL, N'CB100006  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00018   ', N'HUỲNH VĂN MINH
', CAST(0x6A1A0B00 AS Date), N'312/14 Phạm Hữu Lầu, Q7, TPHCM
', N'0983777391
        ', N'vankinu@yahoo.com', N'221095383
 ', NULL, N'CB100007  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00019   ', N'TRẦN HOÀNG NHẬT MINH
', CAST(0xC01D0B00 AS Date), N'Âu Cơ, F10, Q. Tân Bình,Tp HCM
', N'0978480299
        ', N'nhatminh@yahoo.com', N'312171141
 ', NULL, N'CB100008  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00020   ', N'NGUYỄN TRUNG NAM
', CAST(0xFB180B00 AS Date), N'241/9/23 Bến Vân Đồn P5, Q4, tp HCM

', N'01226991223
       ', N'trungnam@yahoo.com', N'020716108
 ', NULL, N'CB100009  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00021   ', N'PHÙNG THỊ KIM NGÂN
', CAST(0xD4120B00 AS Date), N'212/16 Trường Chinh, Q.Tân Bình-TP HCM
', N'0907647247
        ', N'kimngan@yahoo.com', N'301534719
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00022   ', N'BÙI HỮU NGHĨA
', CAST(0xABF80A00 AS Date), N'274/12 Phạm Thế Hiển, P.2, Q.8, tp HCM
', N'0907799849
        ', N'huunghua22@yahoo.com', N'162416916
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00023   ', N'TÔ ANH NGHĨA
', CAST(0x33150B00 AS Date), N'209/12 Nguyễn Tri Phương, HCM
', N'01294486767
       ', N'huunghia@gmail.com', N'331593997
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00024   ', N'TRƯƠNG TIẾN NGỌC
', CAST(0xAF230B00 AS Date), N'102/8 Hồng Lạc, P11, Tân BÌnh, HCM
', N'0955399405
        ', N'tienngoc@yahoo.com', N'365522943
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00025   ', N'LÊ VŨ NGUYÊN
', CAST(0xE0220B00 AS Date), N'83 Bùi Hữu Nghĩa, P.5, Q.5, tp HCM
', N'0913323333
        ', N'vunguyen@yahoo.com', N'022271725
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00026   ', N'PHẠM ÁNH NGUYỆT
', CAST(0x54210B00 AS Date), N'51/26 Nguyễn Trãi, F2, Q5, TPHCM
', N'0984127631
        ', N'anhnguyet@gmail.com', N'017060239
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00027   ', N'ĐINH NGHĨA NHÂN
', CAST(0x71E40A00 AS Date), N'9621/12 Hậu Giang, P11, Q6
', N'0918418012
        ', N'nghiangan21@yahoo.com', N'361751029
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00028   ', N'LƯU DANH NHÂN
', CAST(0x651F0B00 AS Date), N'46 Nguyễn Thái Học, Q1, Tp HCM
', N'0909011885
        ', N'danhnhanhvc@yahoo.com', N'264257126
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00029   ', N'KIỀU KHA NHI
', CAST(0x8A1C0B00 AS Date), N'128b/ 13 Tân Hòa Đông, p14, q6
', N'0909741388
        ', N'khanhi@gmail.com', N'023525677
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00030   ', N'PHAN CÔNG PHÁT
', CAST(0x1A1E0B00 AS Date), N'83/5 Trương Đăng Qué, Gò Vấp, TP HCM
', N'0985558015
        ', N'congphat@yahoo.com', N'025076520
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00031   ', N'LÊ BÁ HUY
', CAST(0xAC170B00 AS Date), N'961/1 Hậu Giang, P11, Q6
', N'0908499502
        ', N'bah1uy@gmail.com', N'215075654
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00032   ', N'NGUYỄN TƯỜNG VI
', CAST(0x36E90A00 AS Date), N'Chung cư Ngô Quyền, HCM
', N'0909539401
        ', N'bahuy@gmail.com', N'023282148
 ', NULL, N'CB111111  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00033   ', N'NGUYỄN VĂN KHÁNH
', CAST(0xC3F80A00 AS Date), N'30 Hoàng Việt P4 Tân Bình TPHCM
', N'0989064954
        ', N'vankhanh2@gmail.com', N'191514012   ', NULL, N'CB142522  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00034   ', N' LƯU THỊ HỒNG HẠNH
', CAST(0x74ED0A00 AS Date), N'357 LÊ VĂN LƯƠNG P TÂN QUY Q7 HCM
', N'0902471168
        ', N'honghanh2@gmail.com', N'191634624
 ', NULL, N'CB141422  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00035   ', N'NGUYỄN HỮU PHƯƠNG
', CAST(0x31EB0A00 AS Date), N'32/17 đường Tây Thanh, Q. Tân Phú tp HCM
', N'0933521098
        ', N'huuphuongq@gmail.com', N'024444724
 ', NULL, N'CB763625  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00036   ', N'VŨ VĂN LỰC
', CAST(0x1EE80A00 AS Date), N'451/32 Bình Đông P13 Q8 HCM
', N'0985801126
        ', N'vanluct@gmail.com', N'171287757
 ', NULL, N'CB252522  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00037   ', N'NGUYỄN THỊ THÙY GIANG
', CAST(0xDC020B00 AS Date), N'1232/124 Hậu Giang, P11, Q6
', N'0978401734
        ', N'thuygiangl@gmail.com', N'150417010
 ', NULL, N'CB252253  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00038   ', N'NGUYỄN THỊ THU HÀ
', CAST(0x9AEA0A00 AS Date), N'T268 Hoàng Diệu P8 Q4 
', N'0981776726
        ', N'thuhal@gmail.com', N'022618000
 ', NULL, N'CB642522  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00039   ', N'NGUYỄN THANH HẰNG
', CAST(0x7FFB0A00 AS Date), N'10 Phan Ngữ, Q1,TP HCM
', N'0918149342          ', N'thuhaqw@gmail.com', N'173071944
 ', NULL, N'CB252552  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00040   ', N'CAO ĐỨC TRUNG', CAST(0xACFA0A00 AS Date), N'161D/106/22 Lạc Long Quân, P3,Q11,HCM', N'01266860171         ', N'ductrungs@gmail.com', N'225083822
 ', NULL, N'CB252211  ', N'CBNV      ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00041   ', N'NGUYỄN VĂN HÒA', CAST(0xC5FD0A00 AS Date), N'117 Trần Bình Trọng, P2, Q5, TPHCM
', N'0904773782
        ', N'vanhoaa@gmail.com', N'063023802
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00042   ', N'TRẦN THỊ KIM VÂN', CAST(0x50E90A00 AS Date), N'86/11 Xô Viết Nghệ Tĩnh, Bình Thạnh
', N'0989075703
        ', N'kimnganfs@gmail.com', N'141971951
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00043   ', N'PHẠM THẾ HƯNG', CAST(0x26EA0A00 AS Date), N'961, Hậu Giang, F11, Q6
', N'0988568786
        ', N'thehungasf@gmail.com', N'022040896
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00044   ', N'PHAN THÀNH LUẬN', CAST(0xF3E30A00 AS Date), N'315 lô Ec/cửa hàng LTK , P7, Q11
', N'0979669686
        ', N'thanfhlun@gmail.com', N'264250628
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00045   ', N'NGUYỄN NGỌC THANH THẢO', CAST(0xF8E80A00 AS Date), N'108 CAM ĐÀO MỘC, P4 Q8 TPHCM
', N'0933813440
        ', N'ngocthanhsa@gmail.com', N'320965914
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00046   ', N'NGUYỄN XUÂN VIỆT', CAST(0x19E60A00 AS Date), N' q79A5/2 nguyễn kiệm, gò vấp
', N'0912959524
        ', N'xuanviet@gmail.com', N'225083260
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00047   ', N'PHẠM VĂN THƯỞNG', CAST(0xDFEC0A00 AS Date), N'61/12 Nguyễn Siêu-p.Bến Nghé-HCM 
', N'01648432175
       ', N'phamthuongqw@yahoo.com', N'212089860
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00048   ', N'NGUYỄN THỊ HUỆ', CAST(0x01F40A00 AS Date), N' 32 Trương Định, Q3 TP HCM
', N'0988482673
        ', N'thihueas@yahoo.com', N'321243532
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00049   ', N'TRẦN HỮU PHÙNG', CAST(0x2CF80A00 AS Date), N'P5, Q8, HCM
', N'0914120096
        ', N'huuphungaw@yahoo.com', N'191571246
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00050   ', N'VÕ THỊ NHUNG', CAST(0x09220B00 AS Date), N'427/8 Minh Phụng, P10, Q10, HCM
', N'0908441898
        ', N'vonnhungas@yahoo.com', N'321203061
 ', NULL, NULL, N'K         ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00051   ', N'HOÀNG VĂN OANH', CAST(0x42200B00 AS Date), N'225/123 Tô Hiến Thành, p13, Q10, TPHCM
', N'01673586537
       ', N'hoafnganh@yahoo.com', N'182242416
 ', N'1531555   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00052   ', N'ĐOÀN THỊ HẠNH', CAST(0xE81F0B00 AS Date), N'314 Phạm Hữu Lầu, Q7, TPHCM
', N'0916181072
        ', N'doanhanhsa@yahoo.com', N'270844435
 ', N'1125225   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00053   ', N'NGUYỄN TRỌNG HẬU', CAST(0xB9220B00 AS Date), N' 12/22 Âu Cơ, F10, Q. Tân Bình,Tp HCM
', N'0913750577
        ', N'tronghauww@yahoo.com', N'121680232
 ', N'1635333   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00054   ', N'TRỊNH DUY ANH', CAST(0xC51F0B00 AS Date), N'277/16 Trường Chinh, Q.Tân Bình-TP HCM
', N'0939161579
        ', N'duyanhp@yahoo.com', N'162292326
 ', N'1622345   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00055   ', N'PHAN TẤN BÌNH', CAST(0xDF1F0B00 AS Date), N'241/9/23 Bến Vân Đồn P5, Q4, tp HCM
', N'01282593698
       ', N'tanbinhsa@yahoo.com', N'010266941
 ', N'1532522   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00056   ', N'PHẠM NGỌC BÍCH', CAST(0xF7220B00 AS Date), N'5/15/2 Hồ Văn Long, p. Bình Hưng Hòa B, Bình Tân, tp HCM
', N'0919915870
        ', N'nogcjbias@yahoo.com', N'022465275
 ', N'1522511   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00057   ', N'NGUUYỄN ĐĂNG TRỌNG', CAST(0xA5220B00 AS Date), N'114 Ký Con ( lầu 4) P Nguyễn Thái Bình Q1
', N'0911328186
        ', N'dangtrongas@yahoo.com', N'225083860
 ', N'1633522   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00058   ', N'TRẦN THỊ YẾN NHI', CAST(0xC11F0B00 AS Date), N'47 Nguyễn Du, Gò Vấp, TP HCM
', N'0909235372
        ', N'tyennhi@yahoo.com', N'23784580
  ', N'1525313   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00059   ', N'NGUYỄN KIM NGÂN', CAST(0xC3220B00 AS Date), N'R23/1/8 cư xá P.Lâm A, P12 Q6 TPHCM
', N'0933011287
        ', N'kimnganw@yahoo.com', N'370851588
 ', N'1523621   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00060   ', N'TRẦN VĂN LIỆT', CAST(0xB4200B00 AS Date), N'500-502 Huỳnh Tấn Phát, Bình Thuận, q.7, tp HCM
', N'0977100155
        ', N'vanlietp@yahoo.com', N'020668015
 ', N'1874322   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00061   ', N'NGUYỄN HOÀNG LONG', CAST(0xDA200B00 AS Date), N'176/3/2 Hậu Giang-P6-Q6-TP HCM
', N'01626633379
       ', N'hoanglongwq@yahoo.com', N'023149069
 ', N'1734653   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00062   ', N'VÕ THÁI SƠN', CAST(0x3E190B00 AS Date), N'722/18 đường 4 KP3 p.Tam Phú, Thủ Đức, TPHCM
', N'01681063073
       ', N'thaison@yahoo.com', N'111553057
 ', N'1531353   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00063   ', N'NGUYỄN THỊ TUYẾT MAI', CAST(0xC5180B00 AS Date), N'249C Trần Phú, Q5,TPHCM
', N'0902774893
        ', N'tuyetmaio@yahoo.com', N'290465896
 ', N'1736432   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00064   ', N'VỤ THỊ THÚY', CAST(0x41160B00 AS Date), N'274 Phạm Thế Hiển, P.2, Q.8, tp HCM
', N'0903619986
        ', N'vuthuyb@yahoo.com', N'162681091
 ', N'1533623   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00065   ', N'ĐOÀN THỊ DUYÊN', CAST(0xE81C0B00 AS Date), N'209 Nguyễn Tri Phương, HCM
', N'01666246895
       ', N'thiduyenc@yahoo.com', N'201608227
 ', N'1533251   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00066   ', N'NGUYỄN THỊ KIM NGÂN', CAST(0x02160B00 AS Date), N'69/45 Hồ Thị Kỹ P1 Q10
', N'0901855505

      ', N'kimngans@yahoo.com', N'012991246
 ', N'1533225   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00067   ', N'TRẦN THANH VÂN', CAST(0xFB1B0B00 AS Date), N'72/18 đường 4 KP3 p.Tam Phú, Thủ Đức, TPHCM
', N'0974102576
        ', N'thanhvanp@yahoo.com', N'024287299
 ', N'1733332   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00068   ', N'TRẦN HUY ĐỨC', CAST(0xE2150B00 AS Date), N'168 ĐINH TIÊN HOÀNG, TP HCM
', N'0913110233
        ', N'tranhuyducs@yahoo.com', N'273132339
 ', N'1627363   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00069   ', N'TRẦN HUY DŨNG', CAST(0x5E200B00 AS Date), N'108/8 Hồng Lạc, P11, Tân Bình, HCM
', N'0983158335
        ', N'tranhuydunga@yahoo.com', N'022347286
 ', N'1314142   ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00070   ', N'TRẦN QUANG HƯƠNG', CAST(0xB21E0B00 AS Date), N'8-10 đường số 34, P.Bình Trị Đông B, Q.Bình Tân
', N'0933058335
        ', N'quanghuongas@yahoo.com', N'125302562
 ', N'1411221   ', NULL, N'SV        ')
INSERT [dbo].[LOAI DOC GIA] ([MaLoaiDG], [SoNgayMuonToiDa], [SoSachMuonToiDa], [TenLoaiDG], [PhiThuongNien], [TaiKieuDB]) VALUES (N'CBNV      ', 14, 10, N'Cán Bộ Nhân Viên', 70000, 1)
INSERT [dbo].[LOAI DOC GIA] ([MaLoaiDG], [SoNgayMuonToiDa], [SoSachMuonToiDa], [TenLoaiDG], [PhiThuongNien], [TaiKieuDB]) VALUES (N'K         ', 10, 5, N'Khác', 150000, 0)
INSERT [dbo].[LOAI DOC GIA] ([MaLoaiDG], [SoNgayMuonToiDa], [SoSachMuonToiDa], [TenLoaiDG], [PhiThuongNien], [TaiKieuDB]) VALUES (N'SV        ', 10, 5, N'Sinh Vien', 90000, 0)
INSERT [dbo].[LOAI NHANVIEN] ([MaLoaiNV], [TenLoaiNV]) VALUES (N'AD        ', N'Admin')
INSERT [dbo].[LOAI NHANVIEN] ([MaLoaiNV], [TenLoaiNV]) VALUES (N'TT        ', N'Thủ Thư')
INSERT [dbo].[NHAN VIEN] ([MaNV], [CaTruc], [TenDangNhap], [MatKhau], [HoTen], [LoginGanNhat], [LoaiNV]) VALUES (N'NV0001    ', 1, N'a         ', N'44f3b9f9f92f252f2aea97644ec88acce83245fc                                                                                                                                                                ', N'PKTÀI', CAST(0xB83D0B00 AS Date), N'AD        ')
INSERT [dbo].[NHAN VIEN] ([MaNV], [CaTruc], [TenDangNhap], [MatKhau], [HoTen], [LoginGanNhat], [LoaiNV]) VALUES (N'NV0002    ', 2, N'B         ', N'ae4f281df5a5d0ff3cad6371f76d5c29b6d953ec                                                                                                                                                                ', N'HTTAI', CAST(0x523C0B00 AS Date), N'TT        ')
INSERT [dbo].[NHAN VIEN] ([MaNV], [CaTruc], [TenDangNhap], [MatKhau], [HoTen], [LoginGanNhat], [LoaiNV]) VALUES (N'NV0003    ', 0, N'x         ', N'a43a71a83dc5cf63bd4b4d4c880aec09a1c18cd                                                                                                                                                                 ', N'X', CAST(0xB83D0B00 AS Date), N'AD        ')
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL021     ', 10, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL022     ', 5, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL023     ', 15, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL053     ', 15, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL054     ', 15, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL055     ', 10, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL056     ', 5, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL057     ', 5, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL058     ', 5, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL059     ', 5, CAST(0x953D0B00 AS Date))
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL001     ', N'NHẬP MÔN LẬP TRÌNH', N'SÁCH', 39, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL002     ', N'KĨ THUẬT LẬP TRÌNH', N'TẠP CHÍ', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL003     ', N'MẠNG MÁY TÍNH', N'SÁCH', 13, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL004     ', N'CẤU TRÚC DỮ LIỆU', N'SÁCH', 3, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL005     ', N'CÁC THUẬT TOÁN THÔNG MINH', N'SÁCH', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL006     ', N'LINUX ALL-IN-ONE FOR DUMMIES - 5TH EDITION', N'SÁCH', 8, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL007     ', N'Php, Mysql, Javascript & Html5 All-In-One For Dummies', N'SÁCH', 9, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL008     ', N'Ba Người Lính Ngự Lâm', N'SÁCH', 9, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL009     ', N'CUỐN THEO CHIỀU GIÓ', N'SÁCH', 6, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL010     ', N'NGƯỜI HOBBIT', N'SÁCH', 11, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL011     ', N'LỊCH SỬ THỜI GIAN', N'SÁCH', 11, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL012     ', N'NGUỒN GỐC CÁC LOÀI', N'SÁCH', 9, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL013     ', N'VŨ TRỤ', N'SÁCH', 14, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL014     ', N'THE GRAND DESIGN', N'SÁCH', 9, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL015     ', N'Nghiên cứu thiết kế chi tiết và ứng dụng công nghệ để chế tạo, lắp ráp và hạ thủy giàn khoan tự nâng ở độ sâu 90m nước phù hợp với điều kiện Việt Nam.', N'CÔNG TRÌNH NGHIÊN CỨU', 9, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL016     ', N'Xây dựng đồng bộ hệ thống hạ tầng kỹ thuật đô thị, nông thôn, bảo vệ môi trường, phòng chống thiên tai và ứng phó với biến đổi khí hậu.', N'CÔNG TRÌNH NGHIÊN CỨU', 10, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL017     ', N'Nghiên cứu ứng dụng khoa học công nghệ nhằm đảm bảo an toàn truyền máu, phục vụ cho cấp cứu và đảm bảo đủ máu dự trữ cho điều trị.', N'CÔNG TRÌNH NGHIÊN CỨU', 9, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL018     ', N'QUẢN TRỊ CƠ SỞ DỮ LIỆU', N'SÁCH', 20, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL019     ', N'Ứng dụng các kỹ thuật tiên tiến trong chẩn đoán, điều trị một số bệnh lý mạch não bằng Điện quang can thiệp nội mạch.', N'CÔNG TRÌNH NGHIÊN CỨU', 10, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL020     ', N'Nghiên cứu ứng dụng kỹ thuật hiện đại về bức xạ ion hóa trong chẩn đoán, điều trị ung thư và một số bệnh lý khác.', N'CÔNG TRÌNH NGHIÊN CỨU', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL021     ', N'CÁC BẤT BIẾN VÀ CẤU TRÚC CỦA VÀNH ĐỊA PHƯƠNG VÀ VÀ', N'CÔNG TRÌNH NGHIÊN CỨU', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL022     ', N'Nghiên cứu ứng dụng các kỹ thuật lọc máu hiện đại trong hồi sức cấp cứu bệnh nhân nặng và ứng phó với một số dịch bệnh nguy hiểm.', N'CÔNG TRÌNH NGHIÊN CỨU ', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL023     ', N'Nghiên cứu cơ bản và định hướng ứng dụng các vật liệu từ liên kim loại đất hiếm - kim loại chuyển tiếp.', N'CÔNG TRÌNH NGHIÊN CỨU', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL024     ', N'Science in Action: How to Follow Scientists and Engineers Through Society', N'SÁCH', 9, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL025     ', N'The Science of Interstellar', N'SÁCH', 10, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL026     ', N'Những Lựa Chọn Thay Đổi Cuộc Đời', N'SÁCH', 10, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL027     ', N'Ăn, Cầu Nguyện, Yêu', N'SÁCH', 9, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL028     ', N'TỶ PHÚ BÁN GIÀY', N'LUẬN VĂN', 9, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL029     ', N'Phớt Lờ Tất Cả Và Bơ Đi Mà Sống', N'SÁCH', 10, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL030     ', N'10 Điều Khác Biệt Nhất Giữa Kẻ Làm Chủ và Người Làm Thuê', N'SÁCH', 10, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL031     ', N'Asia research network', N'TẠP CHÍ', 20, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL032     ', N'Châu Mỹ ngày nay', N'TẠP CHÍ', 20, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL033     ', N'Nghiên cứu con người', N'TẠP CHÍ', 21, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL034     ', N'Khoa học & giáo dục', N'TẠP CHÍ', 20, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL035     ', N'Nghiên cứu phát triển bền vững', N'TẠP CHÍ', 20, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL036     ', N'Nucb Journal of language culture and communication', N'TẠP CHÍ', 20, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL037     ', N'	Nghiên cứu thành phần hóa học và tác dụng bảo vệ gan của cao chiết nước và cao chiết cồn từ cây An xoa (Helicteres hirsuta L.) trên mô hình chuột /', N'LUẬN VĂN', 10, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL038     ', N'	Khảo sát thành phần hóa học của cây An Điền hoa nhỏ Hedyotis tenelliflora Blume , Họ cà phê (Rubiaceae) ', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL039     ', N'	Study on chamical constituents of Hedyotis lindleyana Hook.', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL040     ', N'	Study of alkaloids from roots of Eurycoma longifolia Jack (Simarubaceae) growing in Phu Yen province /', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL041     ', N'	Khảo sát thành phần hóa học cao chloroform của lá cây bàng biển (Calotropis gigantea L.) họ thiên lý (Asclepiadaceace)', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL042     ', N'	Khảo sát thành phần hóa học cao eter dầu hỏa vỏ trái Bòn bon (Lansium domesticum) ', N'LUẬN VĂN', 5, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL043     ', N'Phân lập Terpenoid từ vỏ trái bòn bon (Lansium domesticum) ', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL044     ', N'	Nghiên cứu xây dựng hệ thống giao diện người dùng trên điện thoại di động theo hướng tiếp cận mô hình ', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL045     ', N'	Áp dụng kỹ thuật tập thô và tập mờ trong phân tích dữ liệu bảo hiểm ', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL046     ', N'	Áp dụng lý thuyết đồ thị trong thiết kế mạng thông tin số liệu', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL047     ', N'	Dùng một số thuật toán khai khoáng dữ liệu hỗ trợ quản lý truy xuất các địa chỉ Internet ở WebServer', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL048     ', N'Giải thuật di truyền trong một lớp bài toán lập lịch', N'LUẬN VĂN', 5, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL049     ', N'Hệ chẩn đoán sự cố truyền thông qua Modem ', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL050     ', N'Hệ chuyên gia quản lý trong kho bạc nhà nước- Một số vấn đề về thiết kế và cài đặt', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL051     ', N'Nghiên cứu tích hợp một số phương pháp phân lớp văn bản ', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL052     ', N'Phát triển một số phương pháp phân tích tế bào máu và ứng dụng ', N'LUẬN VĂN', 5, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL053     ', N'International journal of the computer, the internet and management', N'TẠP CHÍ', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL054     ', N'PC world VietNam - Thế giới vi tính : sêri A', N'TẠP CHÍ', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL055     ', N'Điện tử - Máy tính', N'TẠP CHÍ', 0, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL056     ', N'Thời báo vi tính Sài gòn', N'TẠP CHÍ', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL057     ', N'Thế giới số', N'TẠP CHÍ', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL058     ', N'BioTechniques', N'TẠP CHÍ', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL059     ', N'Công nghệ sinh học', N'TẠP CHÍ', 0, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL060     ', N'Tạp chí Dược học', N'TẠP CHÍ', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL061     ', N'Nonlinear functional analysis and applications', N'TẠP CHÍ', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL062     ', N'Vietnam journal of mechanics', N'TẠP CHÍ', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL063     ', N'	Hội nghị tổng kết hoạt động khoa học và công nghệ giai đoạn 2006 - 2007 phương hướng nhiệm vụ giai đoạn 2008 - 2010', N'HỘI NGHỊ-BÁO CÁO', 15, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL064     ', N'Kỷ yếu hội nghị khoa học sinh viên / Trường Đại học Tổng hợp TP. Hồ Chí Minh', N'HỘI NGHỊ-BÁO CÁO', 15, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL065     ', N'	Tóm tắt báo cáo hội nghị khoa học lần thứ II ', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL066     ', N'Tóm tắt nội dung báo cáo khoa học hội nghị khoa học & công nghệ lần 8 (25-26/4/2002)', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL067     ', N'Hội nghị tổng kết hoạt động khoa học và công nghệ giai đoạn 2001 - 2005 phương hướng nhiệm vụ giai đoạn 2006 - 2010 / Đại Học Quốc Gia TP.HCM', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL068     ', N'Tóm tắt báo cáo hội nghị khoa học : 1998 / Trường Đại học Khoa học Tự nhiên', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL069     ', N'Hội nghị khoa học lần thứ 20 : Kỷ niệm 50 năm thành lập Trường Đại học Bách khoa Hà Nội 1956 - 2006 : tuyển tập báo cáo tóm tắt / Trường Đại học Bách Khoa Hà Nội', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL070     ', N'Hội nghị khoa học lần thứ 5 Trường Đại học Bách Khoa Thành phố Hồ Chí Minh / Trường Đại học Bách Khoa Thành phố Hồ Chí Minh', N'HỘI NGHỊ-BÁO CÁO', 15, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL071     ', N'Tóm tắt báo cáo khoa học', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL072     ', N'Tóm tắt các báo cáo khoa học của Phân viện khoa học Việt Nam tại thành phố Hồ Chí Minh / Phân Viện Khoa học Việt Nam', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL073     ', N'Proceedings of the thirty-seventh SIGCSE Technical Symposium on Computer Science Education : SIGCSE 2006 : Houston, Tex., USA, March 1-5, 2006', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL074     ', N'Evolutionary programming VI : 6th international conference, EP97, Indianapolis, Indiana, USA, April 13-16, 1997', N'HỘI NGHỊ-BÁO CÁO', 15, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL075     ', N'Mathematical theory of automata', N'HỘI NGHỊ-BÁO CÁO', 15, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL076     ', N'The 4th seminar on environmental science and technology issues related to the sustainable development for urban and coastal areas', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL077     ', N'Hội nghị khoa học các khoa tự nhiên : 19-01-1995 / Trường Đại học Tổng hợp TP.HCM', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL078     ', N'	Hội nghị khoa học lần thứ IX : chương trình hội nghị, 21/11/2014', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL079     ', N'Hội nghị khoa học lần thứ VI : chương trình hội nghị, 14/11/2008 / Trường Đại học Khoa học Tự nhiên', N'HỘI NGHỊ-BÁO CÁO', 15, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL080     ', N'Hội nghị khoa học lần thứ VIII : chương trình hội nghị, 9/11/2012 / Trường Đại học Khoa học Tự nhiên', N'HỘI NGHỊ-BÁO CÁO', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL081     ', N'Hội nghị khoa học lần thứ X : chương trình hội nghị, 11/11/2016 / Trường Đại học Khoa học Tự nhiên', N'HỘI NGHỊ-BÁO CÁO', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL082     ', N'Tóm tắt báo cáo hội nghị khoa học lần III ', N'HỘI NGHỊ-BÁO CÁO', 0, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL083     ', N'Hội nghị khoa học lần thứ 4 : tóm tắt nội dung báo cáo khoa học ', N'HỘI NGHỊ-BÁO CÁO', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL084     ', N'	Hội nghị khoa học lần thứ 5 : tóm tắt nội dung báo cáo khoa học', N'HỘI NGHỊ-BÁO CÁO', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL085     ', N'PlayBoy', N'TẠP CHÍ', 10, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL086     ', N'Hội nghị khoa học sinh viên lần III : 28.12.1999 / Trường Đại học Khoa học Tự nhiên', N'HỘI NGHỊ-BÁO CÁO', 0, 1)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL087     ', N'Kỷ yếu hội nghị khoa học các công trình nghiên cứu trong năm học 1994 - 1995 của các CBGD trẻ, học viên cao học và nghiên cứu sinh / Trường Đại học Tổng hợp TP. Hồ Chí Minh', N'HỘI NGHỊ-BÁO CÁO', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL088     ', N'Kỷ yếu hội nghị khoa học trẻ 1994 (Khối Nghiên cứu sinh, Cán bộ giảng dạy) / Trường Đại học Tổng hợp TP.HCM', N'HỘI NGHỊ-BÁO CÁO', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL089     ', N'	The 21st century COE program "Towards a new basic science : depth and synthesis : Osaka university"', N'HỘI NGHỊ-BÁO CÁO', 0, 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [LoaiTaiLieu], [SoLuong], [DacBiet]) VALUES (N'TL090     ', N'	The 3rd academic conference on natural science for master and PhD students from ASEAN countries : proceedings, 11 - 15 November 2013 ', N'HỘI NGHỊ-BÁO CÁO', 0, 0)
ALTER TABLE [dbo].[CHI TIET PHIEU MUON]  WITH CHECK ADD  CONSTRAINT [FK_CHI TIET PHIEU MUON_PHIEU MUON] FOREIGN KEY([MaPhieuMuon])
REFERENCES [dbo].[PHIEU MUON] ([MaPhieuMuon])
GO
ALTER TABLE [dbo].[CHI TIET PHIEU MUON] CHECK CONSTRAINT [FK_CHI TIET PHIEU MUON_PHIEU MUON]
GO
ALTER TABLE [dbo].[CHI TIET PHIEU MUON]  WITH CHECK ADD  CONSTRAINT [FK_CHI TIET PHIEU MUON_TAI LIEU] FOREIGN KEY([MaTaiLieu])
REFERENCES [dbo].[TAI LIEU] ([MaTaiLieu])
GO
ALTER TABLE [dbo].[CHI TIET PHIEU MUON] CHECK CONSTRAINT [FK_CHI TIET PHIEU MUON_TAI LIEU]
GO
ALTER TABLE [dbo].[CHI TIET PHIEU TRA]  WITH CHECK ADD  CONSTRAINT [FK_CHI TIET PHIEU TRA_PHIEU MUON] FOREIGN KEY([MaPhieuMuon])
REFERENCES [dbo].[PHIEU MUON] ([MaPhieuMuon])
GO
ALTER TABLE [dbo].[CHI TIET PHIEU TRA] CHECK CONSTRAINT [FK_CHI TIET PHIEU TRA_PHIEU MUON]
GO
ALTER TABLE [dbo].[CHI TIET PHIEU TRA]  WITH CHECK ADD  CONSTRAINT [FK_CHI TIET PHIEU TRA_PHIEU TRA] FOREIGN KEY([MaPhieuTra])
REFERENCES [dbo].[PHIEU TRA] ([MaPhieuTra])
GO
ALTER TABLE [dbo].[CHI TIET PHIEU TRA] CHECK CONSTRAINT [FK_CHI TIET PHIEU TRA_PHIEU TRA]
GO
ALTER TABLE [dbo].[CHI TIET PHIEU TRA]  WITH CHECK ADD  CONSTRAINT [FK_CHI TIET PHIEU TRA_TAI LIEU] FOREIGN KEY([MaTaiLieu])
REFERENCES [dbo].[TAI LIEU] ([MaTaiLieu])
GO
ALTER TABLE [dbo].[CHI TIET PHIEU TRA] CHECK CONSTRAINT [FK_CHI TIET PHIEU TRA_TAI LIEU]
GO
ALTER TABLE [dbo].[DOC GIA]  WITH CHECK ADD  CONSTRAINT [FK_DOC GIA_LOAI DOC GIA] FOREIGN KEY([LoaiDG])
REFERENCES [dbo].[LOAI DOC GIA] ([MaLoaiDG])
GO
ALTER TABLE [dbo].[DOC GIA] CHECK CONSTRAINT [FK_DOC GIA_LOAI DOC GIA]
GO
ALTER TABLE [dbo].[NHAN VIEN]  WITH CHECK ADD  CONSTRAINT [FK_NHAN VIEN_LOAI NHANVIEN] FOREIGN KEY([LoaiNV])
REFERENCES [dbo].[LOAI NHANVIEN] ([MaLoaiNV])
GO
ALTER TABLE [dbo].[NHAN VIEN] CHECK CONSTRAINT [FK_NHAN VIEN_LOAI NHANVIEN]
GO
ALTER TABLE [dbo].[NHAP TAI LIEU]  WITH CHECK ADD  CONSTRAINT [FK_NHAP TAI LIEU_TAI LIEU] FOREIGN KEY([MaTLNhap])
REFERENCES [dbo].[TAI LIEU] ([MaTaiLieu])
GO
ALTER TABLE [dbo].[NHAP TAI LIEU] CHECK CONSTRAINT [FK_NHAP TAI LIEU_TAI LIEU]
GO
ALTER TABLE [dbo].[PHIEU MUON]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU MUON_DOC GIA] FOREIGN KEY([MaDocGia])
REFERENCES [dbo].[DOC GIA] ([MaDocGia])
GO
ALTER TABLE [dbo].[PHIEU MUON] CHECK CONSTRAINT [FK_PHIEU MUON_DOC GIA]
GO
ALTER TABLE [dbo].[PHIEU MUON]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU MUON_NHAN VIEN] FOREIGN KEY([MaNVLapPhieuMuon])
REFERENCES [dbo].[NHAN VIEN] ([MaNV])
GO
ALTER TABLE [dbo].[PHIEU MUON] CHECK CONSTRAINT [FK_PHIEU MUON_NHAN VIEN]
GO
ALTER TABLE [dbo].[PHIEU NHAC NHO]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU NHAC NHO_DOC GIA] FOREIGN KEY([MaDocGia])
REFERENCES [dbo].[DOC GIA] ([MaDocGia])
GO
ALTER TABLE [dbo].[PHIEU NHAC NHO] CHECK CONSTRAINT [FK_PHIEU NHAC NHO_DOC GIA]
GO
ALTER TABLE [dbo].[PHIEU PHAT]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU PHAT_NHAN VIEN] FOREIGN KEY([MaNVLapPhieuPhat])
REFERENCES [dbo].[NHAN VIEN] ([MaNV])
GO
ALTER TABLE [dbo].[PHIEU PHAT] CHECK CONSTRAINT [FK_PHIEU PHAT_NHAN VIEN]
GO
ALTER TABLE [dbo].[PHIEU PHAT]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU PHAT_PHIEU MUON] FOREIGN KEY([MaPhieuMuon])
REFERENCES [dbo].[PHIEU MUON] ([MaPhieuMuon])
GO
ALTER TABLE [dbo].[PHIEU PHAT] CHECK CONSTRAINT [FK_PHIEU PHAT_PHIEU MUON]
GO
ALTER TABLE [dbo].[PHIEU TRA]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU TRA_NHAN VIEN] FOREIGN KEY([MaNVLapPhieuTra])
REFERENCES [dbo].[NHAN VIEN] ([MaNV])
GO
ALTER TABLE [dbo].[PHIEU TRA] CHECK CONSTRAINT [FK_PHIEU TRA_NHAN VIEN]
GO
USE [master]
GO
ALTER DATABASE [QL_thuvien] SET  READ_WRITE 
GO