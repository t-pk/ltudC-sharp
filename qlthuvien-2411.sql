/****** Object:  Database [QL_thuvien]    Script Date: 11/24/2017 11:02:39 PM ******/
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QL_thuvien')
BEGIN

CREATE DATABASE [QL_thuvien]
END 
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
/****** Object:  StoredProcedure [dbo].[usp_CapNhatDocGia]    Script Date: 11/24/2017 11:02:39 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CapNhatNhanVien]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_CapNhatNhanVien] @MaNV nvarchar(10), @CaTruc nvarchar(40), @TenDangNhap nvarchar(20), @MatKhau char(20), @HoTen nvarchar(100), @LoaiNV nvarchar(20)
as
begin
	update [NHAN VIEN]
	set	CaTruc = @CaTruc, TenDangNhap = @TenDangNhap, MatKhau = @MatKhau, HoTen = @HoTen, LoaiNV = @LoaiNV
	where MaNV = @MaNV
end

GO
/****** Object:  StoredProcedure [dbo].[usp_LayQuyenNhanVien]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LayQuyenNhanVien] @UserName char(40), @Pass char(20), @QuyenNV nvarchar(50) out
as
begin
	select @QuyenNV =  l.TenLoaiNV
	from [NHAN VIEN] nv, [LOAI NHANVIEN] l
	where nv.TenDangNhap = @UserName and nv.MatKhau = @Pass and l.MaLoaiNV = nv.LoaiNV
end


GO
/****** Object:  StoredProcedure [dbo].[usp_LayTenNhanVien]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_LayTenNhanVien] @UserName char(40), @Pass char(20), @TenNV nvarchar(50) out
as
begin
	select @TenNV =  nv.HoTen
	from [NHAN VIEN] nv
	where nv.TenDangNhap = @UserName and nv.MatKhau = @Pass
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Login]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Login] @username nchar(40), @password nchar(40), @result int out
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
/****** Object:  StoredProcedure [dbo].[usp_ThemDocGia]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ThemDocGia] @TenDG nvarchar(40), @NgaySinhDG nvarchar(20), @DiaChiDG nvarchar(100), @SDTDG nvarchar(20), @EmailDG nvarchar(30), @CMNDDG nvarchar(20),@MSSVDG nvarchar(20), @MCBDG nvarchar(20), @LoaiDG nvarchar(20)
as
begin
	Declare @MaDG nchar(10)
	exec usp_TimMaDGTiepTheo @MaDG out
	insert into [DOC GIA]
	values(@MaDG, @TenDG,@NgaySinhDG, @DiaChiDG, @SDTDG, @EmailDG, @CMNDDG, @MSSVDG, @CMNDDG, @LoaiDG)
end

GO
/****** Object:  StoredProcedure [dbo].[usp_ThemNhanVien]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ThemNhanVien] @CaTruc nvarchar(40), @TenDangNhap nvarchar(20), @HoTen nvarchar(100), @MatKhau char(20), @LoaiNV nvarchar(20)
as
begin
	Declare @MaNV nchar(10)
	exec usp_TimMaNVTiepTheo @MaNV out
	insert into [NHAN VIEN]
	values(@MaNV, @CaTruc ,@TenDangNhap, @MatKhau, @HoTen, GETDATE(), @LoaiNV)
end


GO
/****** Object:  StoredProcedure [dbo].[usp_TimMaDGTiepTheo]    Script Date: 11/24/2017 11:02:39 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_TimMaNVTiepTheo]    Script Date: 11/24/2017 11:02:39 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_XemDocGia]    Script Date: 11/24/2017 11:02:39 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_XemNhanVien]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XemNhanVien]
as
begin
	select * from [NHAN VIEN]
end

GO
/****** Object:  StoredProcedure [dbo].[usp_xemPhieuMuon]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[usp_xemPhieuMuon]
 as
 begin
 select *from [PHIEU MUON]
  select *from [CHI TIET PHIEU TRA]
 end
GO
/****** Object:  StoredProcedure [dbo].[usp_xemPhieuTra]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[usp_xemPhieuTra]
 as
 begin
 select *from [PHIEU TRA] 
 select *from [CHI TIET PHIEU TRA]
 end
GO
/****** Object:  StoredProcedure [dbo].[usp_XoaDocGia]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[usp_XoaDocGia] @MaDG char(15)
 as
 begin
	delete from [DOC GIA]
	where MaDocGia = @MaDG
 end

GO
/****** Object:  Table [dbo].[CHI TIET PHIEU MUON]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHI TIET PHIEU MUON](
	[STTMuon] [nchar](10) NOT NULL,
	[MaTaiLieu] [nchar](10) NULL,
	[MaPhieuMuon] [nchar](10) NULL,
	[SoLuongMuon] [int] NULL,
	[HanTra] [date] NULL,
 CONSTRAINT [PK_CHI TIET PHIEU MUON_1] PRIMARY KEY CLUSTERED 
(
	[STTMuon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CHI TIET PHIEU PHAT]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHI TIET PHIEU PHAT](
	[STTPhieuPhat] [int] NOT NULL,
	[MaPhieuPhat] [nchar](10) NULL,
	[SoNgayQuaHan] [int] NULL,
	[SoTienPhat] [int] NULL,
 CONSTRAINT [PK_CHI TIET PHIEU PHAT] PRIMARY KEY CLUSTERED 
(
	[STTPhieuPhat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CHI TIET PHIEU TRA]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHI TIET PHIEU TRA](
	[STTPhieuTra] [nchar](10) NOT NULL,
	[MaPhieuTra] [nchar](10) NULL,
	[MaDocGia] [nchar](10) NULL,
	[NgayTra] [date] NULL,
 CONSTRAINT [PK_CHI TIET PHIEU TRA] PRIMARY KEY CLUSTERED 
(
	[STTPhieuTra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DOC GIA]    Script Date: 11/24/2017 11:02:39 PM ******/
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
 CONSTRAINT [PK_DOC GIA] PRIMARY KEY CLUSTERED 
(
	[MaDocGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LOAI DOC GIA]    Script Date: 11/24/2017 11:02:39 PM ******/
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
/****** Object:  Table [dbo].[LOAI NHANVIEN]    Script Date: 11/24/2017 11:02:39 PM ******/
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
/****** Object:  Table [dbo].[NHAN VIEN]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHAN VIEN](
	[MaNV] [nchar](10) NOT NULL,
	[CaTruc] [int] NULL,
	[TenDangNhap] [nchar](10) NULL,
	[MatKhau] [nchar](20) NULL,
	[HoTen] [nvarchar](50) NULL,
	[LoginGanNhat] [date] NULL,
	[LoaiNV] [nchar](10) NULL,
 CONSTRAINT [PK_NHAN VIEN] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NHAP TAI LIEU]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHAP TAI LIEU](
	[MaTLNhap] [nchar](10) NULL,
	[SttTLNhap] [nchar](10) NOT NULL,
	[SoLuong] [int] NULL,
	[NgayNhap] [date] NULL,
 CONSTRAINT [PK_NHAP TAI LIEU] PRIMARY KEY CLUSTERED 
(
	[SttTLNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PHIEU MUON]    Script Date: 11/24/2017 11:02:39 PM ******/
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
/****** Object:  Table [dbo].[PHIEU NHAC NHO]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEU NHAC NHO](
	[MaPhieuNN] [nchar](10) NOT NULL,
	[STTMuon] [nchar](10) NOT NULL,
	[ThoiGianConLai] [int] NULL,
 CONSTRAINT [PK_PHIEU NHAC NHO] PRIMARY KEY CLUSTERED 
(
	[MaPhieuNN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PHIEU PHAT]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEU PHAT](
	[MaPhieuPhat] [nchar](10) NOT NULL,
	[MaNVLapPhieuPhat] [nchar](10) NULL,
	[MaPhieuMuon] [nchar](10) NULL,
	[NgayLapPhieuPhat] [date] NULL,
 CONSTRAINT [PK_PHIEU PHAT] PRIMARY KEY CLUSTERED 
(
	[MaPhieuPhat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PHIEU TRA]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEU TRA](
	[MaPhieuTra] [nchar](10) NOT NULL,
	[MaPhieuMuon] [nchar](10) NULL,
	[NgayLapPhieuTra] [date] NULL,
	[MaNVLapPhieuTra] [nchar](10) NULL,
 CONSTRAINT [PK_PHIEU TRA] PRIMARY KEY CLUSTERED 
(
	[MaPhieuTra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TAI LIEU]    Script Date: 11/24/2017 11:02:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TAI LIEU](
	[MaTaiLieu] [nchar](10) NOT NULL,
	[TenTaiLieu] [nvarchar](200) NULL,
	[HienTrang] [bit] NULL,
	[LoaiTaiLieu] [nvarchar](50) NULL,
	[SoLuong] [int] NULL,
 CONSTRAINT [PK_SACH] PRIMARY KEY CLUSTERED 
(
	[MaTaiLieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM01     ', N'TL001     ', N'PM001     ', 1, CAST(0x873D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM02     ', N'TL002     ', N'PM001     ', 1, CAST(0x873D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM03     ', N'TL003     ', N'PM001     ', 1, CAST(0x873D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM04     ', N'TL004     ', N'PM002     ', 1, CAST(0x8C3D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM05     ', N'TL005     ', N'PM003     ', 1, CAST(0x8C3D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM06     ', N'TL006     ', N'PM003     ', 1, CAST(0x8C3D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM07     ', N'TL007     ', N'PM004     ', 2, CAST(0x8E3D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM08     ', N'TL008     ', N'PM005     ', 1, CAST(0x8E3D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM09     ', N'TL009     ', N'PM006     ', 2, CAST(0x8E3D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM10     ', N'TL010     ', N'PM007     ', 2, CAST(0x903D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM11     ', N'TL011     ', N'PM008     ', 2, CAST(0x903D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM12     ', N'TL012     ', N'PM009     ', 1, CAST(0x903D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM13     ', N'TL013     ', N'PM010     ', 2, CAST(0x903D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM14     ', N'TL014     ', N'PM011     ', 2, CAST(0x923D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM15     ', N'TL015     ', N'PM012     ', 2, CAST(0x923D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM16     ', N'TL016     ', N'PM013     ', 1, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM17     ', N'TL017     ', N'PM014     ', 1, CAST(0x963D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM18     ', N'TL024     ', N'PM015     ', 1, CAST(0x963D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM19     ', N'TL025     ', N'PM016     ', 2, CAST(0x963D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM20     ', N'TL026     ', N'PM017     ', 2, CAST(0x963D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM21     ', N'TL027     ', N'PM018     ', 4, CAST(0x973D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM22     ', N'TL028     ', N'PM019     ', 3, CAST(0x973D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM23     ', N'TL029     ', N'PM020     ', 1, CAST(0x973D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM24     ', N'TL063     ', N'PM021     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM25     ', N'TL064     ', N'PM022     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM26     ', N'TL065     ', N'PM023     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM27     ', N'TL066     ', N'PM024     ', 1, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM28     ', N'TL067     ', N'PM025     ', 3, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM29     ', N'TL068     ', N'PM026     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM30     ', N'TL069     ', N'PM027     ', 1, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM31     ', N'TL070     ', N'PM028     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM32     ', N'TL071     ', N'PM029     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM33     ', N'TL072     ', N'PM030     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM34     ', N'TL073     ', N'PM031     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM35     ', N'TL074     ', N'PM032     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM36     ', N'TL075     ', N'PM033     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM37     ', N'TL076     ', N'PM034     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM38     ', N'TL077     ', N'PM035     ', 1, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM39     ', N'TL078     ', N'PM036     ', 2, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU MUON] ([STTMuon], [MaTaiLieu], [MaPhieuMuon], [SoLuongMuon], [HanTra]) VALUES (N'CTM40     ', N'TL079     ', N'PM037     ', 3, CAST(0x943D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU TRA] ([STTPhieuTra], [MaPhieuTra], [MaDocGia], [NgayTra]) VALUES (N'CTT01     ', N'PT01      ', N'DG00041   ', CAST(0x923D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU TRA] ([STTPhieuTra], [MaPhieuTra], [MaDocGia], [NgayTra]) VALUES (N'CTT02     ', N'PT02      ', N'DG00042   ', CAST(0x923D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU TRA] ([STTPhieuTra], [MaPhieuTra], [MaDocGia], [NgayTra]) VALUES (N'CTT03     ', N'PT03      ', N'DG00043   ', CAST(0x923D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU TRA] ([STTPhieuTra], [MaPhieuTra], [MaDocGia], [NgayTra]) VALUES (N'CTT04     ', N'PT04      ', N'DG00044   ', CAST(0x923D0B00 AS Date))
INSERT [dbo].[CHI TIET PHIEU TRA] ([STTPhieuTra], [MaPhieuTra], [MaDocGia], [NgayTra]) VALUES (N'CTT05     ', N'PT05      ', N'DG00045   ', CAST(0x923D0B00 AS Date))
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00001   ', N'NGUYỄN THỊ THÚY KIỀU
', CAST(0xFA1C0B00 AS Date), N'241/213 LÍ THÁI TỔ, Q3, TP HCM', N'01649824548
       ', N'thuykieu@gmail.com', N'023177128
 ', N'1560286
 ', NULL, N'SV        ')
INSERT [dbo].[DOC GIA] ([MaDocGia], [HoTen], [NgaySinh], [DiaChi], [Sdt], [Email], [CMND], [MSSV], [MCB], [LoaiDG]) VALUES (N'DG00002   ', N'PHẠM TẤN KIỀU
', CAST(0x7D1E0B00 AS Date), N'123/21 CMT8,Q8, TP HCM', N'01267946246
       ', N'tankieu@gmail.com', N'145437733
 ', N'1560287   ', NULL, N'SV        ')
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
INSERT [dbo].[LOAI DOC GIA] ([MaLoaiDG], [SoNgayMuonToiDa], [SoSachMuonToiDa], [TenLoaiDG], [PhiThuongNien], [TaiKieuDB]) VALUES (N'SV        ', 10, 5, N'Sinh Vien', 100000, 1)
INSERT [dbo].[LOAI NHANVIEN] ([MaLoaiNV], [TenLoaiNV]) VALUES (N'AD        ', N'Admin')
INSERT [dbo].[LOAI NHANVIEN] ([MaLoaiNV], [TenLoaiNV]) VALUES (N'TT        ', N'Thủ Thư')
INSERT [dbo].[NHAN VIEN] ([MaNV], [CaTruc], [TenDangNhap], [MatKhau], [HoTen], [LoginGanNhat], [LoaiNV]) VALUES (N'NV0001    ', 1, N'a         ', N'a                   ', N'pktài', CAST(0x903D0B00 AS Date), N'AD        ')
INSERT [dbo].[NHAN VIEN] ([MaNV], [CaTruc], [TenDangNhap], [MatKhau], [HoTen], [LoginGanNhat], [LoaiNV]) VALUES (N'NV0002    ', 2, N'B         ', N'B                   ', N'HTTAI', CAST(0x523C0B00 AS Date), N'TT        ')
INSERT [dbo].[NHAN VIEN] ([MaNV], [CaTruc], [TenDangNhap], [MatKhau], [HoTen], [LoginGanNhat], [LoaiNV]) VALUES (N'NV0003    ', 2, N'C         ', N'C                   ', N'NDQUYET', CAST(0x443D0B00 AS Date), N'TT        ')
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SttTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL021     ', N'TLN01     ', 10, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SttTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL022     ', N'TLN02     ', 5, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SttTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL023     ', N'TLN03     ', 15, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SttTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL053     ', N'TLN04     ', 15, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SttTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL054     ', N'TLN05     ', 15, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SttTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL055     ', N'TLN06     ', 10, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SttTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL056     ', N'TLN07     ', 5, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SttTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL057     ', N'TLN08     ', 5, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SttTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL058     ', N'TLN09     ', 5, CAST(0x953D0B00 AS Date))
INSERT [dbo].[NHAP TAI LIEU] ([MaTLNhap], [SttTLNhap], [SoLuong], [NgayNhap]) VALUES (N'TL059     ', N'TLN10     ', 5, CAST(0x953D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM001     ', N'NV0002    ', N'DG00001   ', CAST(0x7D3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM002     ', N'NV0002    ', N'DG00001   ', CAST(0x7D3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM003     ', N'NV0002    ', N'DG00001   ', CAST(0x7D3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM004     ', N'NV0002    ', N'DG00002   ', CAST(0x823D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM005     ', N'NV0002    ', N'DG00003   ', CAST(0x823D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM006     ', N'NV0002    ', N'DG00003   ', CAST(0x823D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM007     ', N'NV0002    ', N'DG00004   ', CAST(0x843D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM008     ', N'NV0002    ', N'DG00005   ', CAST(0x843D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM009     ', N'NV0002    ', N'DG00006   ', CAST(0x843D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM010     ', N'NV0002    ', N'DG00007   ', CAST(0x863D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM011     ', N'NV0003    ', N'DG00008   ', CAST(0x863D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM012     ', N'NV0003    ', N'DG00009   ', CAST(0x863D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM013     ', N'NV0003    ', N'DG00010   ', CAST(0x863D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM014     ', N'NV0003    ', N'DG00011   ', CAST(0x883D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM015     ', N'NV0003    ', N'DG00012   ', CAST(0x883D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM016     ', N'NV0003    ', N'DG00013   ', CAST(0x883D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM017     ', N'NV0003    ', N'DG00014   ', CAST(0x883D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM018     ', N'NV0003    ', N'DG00015   ', CAST(0x893D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM019     ', N'NV0003    ', N'DG00016   ', CAST(0x893D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM020     ', N'NV0003    ', N'DG00017   ', CAST(0x893D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM021     ', N'NV0002    ', N'DG00018   ', CAST(0x893D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM022     ', N'NV0002    ', N'DG00019   ', CAST(0x8A3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM023     ', N'NV0002    ', N'DG00020   ', CAST(0x8A3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM024     ', N'NV0002    ', N'DG00021   ', CAST(0x8A3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM025     ', N'NV0002    ', N'DG00022   ', CAST(0x8A3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM026     ', N'NV0002    ', N'DG00023   ', CAST(0x8A3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM027     ', N'NV0002    ', N'DG00024   ', CAST(0x8A3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM028     ', N'NV0002    ', N'DG00025   ', CAST(0x8A3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM029     ', N'NV0002    ', N'DG00026   ', CAST(0x8B3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM030     ', N'NV0002    ', N'DG00027   ', CAST(0x8B3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM031     ', N'NV0002    ', N'DG00028   ', CAST(0x8B3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM032     ', N'NV0003    ', N'DG00028   ', CAST(0x8B3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM033     ', N'NV0003    ', N'DG00029   ', CAST(0x8B3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM034     ', N'NV0003    ', N'DG00029   ', CAST(0x8B3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM035     ', N'NV0003    ', N'DG00029   ', CAST(0x8B3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM036     ', N'NV0003    ', N'DG00030   ', CAST(0x8B3D0B00 AS Date))
INSERT [dbo].[PHIEU MUON] ([MaPhieuMuon], [MaNVLapPhieuMuon], [MaDocGia], [NgayLapPhieuMuon]) VALUES (N'PM037     ', N'NV0003    ', N'DG00030   ', CAST(0x8B3D0B00 AS Date))
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN001    ', N'CTM01     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN002    ', N'CTM02     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN003    ', N'CTM03     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN004    ', N'CTM04     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN005    ', N'CTM05     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN006    ', N'CTM06     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN007    ', N'CTM07     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN008    ', N'CTM08     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN009    ', N'CTM09     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN010    ', N'CTM10     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN011    ', N'CTM11     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN012    ', N'CTM12     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN013    ', N'CTM13     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN014    ', N'CTM14     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN015    ', N'CTM15     ', 0)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN016    ', N'CTM16     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN017    ', N'CTM17     ', 3)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN018    ', N'CTM18     ', 3)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN019    ', N'CTM19     ', 3)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN020    ', N'CTM20     ', 3)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN021    ', N'CTM21     ', 4)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN022    ', N'CTM22     ', 4)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN023    ', N'CTM23     ', 4)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN024    ', N'CTM24     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN025    ', N'CTM25     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN026    ', N'CTM26     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN027    ', N'CTM27     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN028    ', N'CTM28     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN029    ', N'CTM29     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN030    ', N'CTM30     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN031    ', N'CTM31     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN032    ', N'CTM32     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN033    ', N'CTM33     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN034    ', N'CTM34     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN035    ', N'CTM35     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN036    ', N'CTM36     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN037    ', N'CTM37     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN038    ', N'CTM38     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN039    ', N'CTM39     ', 1)
INSERT [dbo].[PHIEU NHAC NHO] ([MaPhieuNN], [STTMuon], [ThoiGianConLai]) VALUES (N'PNN040    ', N'CTM40     ', 1)
INSERT [dbo].[PHIEU PHAT] ([MaPhieuPhat], [MaNVLapPhieuPhat], [MaPhieuMuon], [NgayLapPhieuPhat]) VALUES (N'MPP01     ', N'NV0002    ', N'PM006     ', CAST(0x933D0B00 AS Date))
INSERT [dbo].[PHIEU PHAT] ([MaPhieuPhat], [MaNVLapPhieuPhat], [MaPhieuMuon], [NgayLapPhieuPhat]) VALUES (N'MPP02     ', N'NV0002    ', N'PM007     ', CAST(0x933D0B00 AS Date))
INSERT [dbo].[PHIEU PHAT] ([MaPhieuPhat], [MaNVLapPhieuPhat], [MaPhieuMuon], [NgayLapPhieuPhat]) VALUES (N'MPP03     ', N'NV0002    ', N'PM008     ', CAST(0x933D0B00 AS Date))
INSERT [dbo].[PHIEU PHAT] ([MaPhieuPhat], [MaNVLapPhieuPhat], [MaPhieuMuon], [NgayLapPhieuPhat]) VALUES (N'MPP04     ', N'NV0002    ', N'PM009     ', CAST(0x933D0B00 AS Date))
INSERT [dbo].[PHIEU PHAT] ([MaPhieuPhat], [MaNVLapPhieuPhat], [MaPhieuMuon], [NgayLapPhieuPhat]) VALUES (N'MPP05     ', N'NV0002    ', N'PM010     ', CAST(0x933D0B00 AS Date))
INSERT [dbo].[PHIEU PHAT] ([MaPhieuPhat], [MaNVLapPhieuPhat], [MaPhieuMuon], [NgayLapPhieuPhat]) VALUES (N'MPP06     ', N'NV0002    ', N'PM011     ', CAST(0x933D0B00 AS Date))
INSERT [dbo].[PHIEU PHAT] ([MaPhieuPhat], [MaNVLapPhieuPhat], [MaPhieuMuon], [NgayLapPhieuPhat]) VALUES (N'MPP07     ', N'NV0002    ', N'PM012     ', CAST(0x933D0B00 AS Date))
INSERT [dbo].[PHIEU PHAT] ([MaPhieuPhat], [MaNVLapPhieuPhat], [MaPhieuMuon], [NgayLapPhieuPhat]) VALUES (N'MPP08     ', N'NV0002    ', N'PM013     ', CAST(0x933D0B00 AS Date))
INSERT [dbo].[PHIEU PHAT] ([MaPhieuPhat], [MaNVLapPhieuPhat], [MaPhieuMuon], [NgayLapPhieuPhat]) VALUES (N'MPP09     ', N'NV0002    ', N'PM014     ', CAST(0x933D0B00 AS Date))
INSERT [dbo].[PHIEU PHAT] ([MaPhieuPhat], [MaNVLapPhieuPhat], [MaPhieuMuon], [NgayLapPhieuPhat]) VALUES (N'MPP10     ', N'NV0002    ', N'PM015     ', CAST(0x933D0B00 AS Date))
INSERT [dbo].[PHIEU TRA] ([MaPhieuTra], [MaPhieuMuon], [NgayLapPhieuTra], [MaNVLapPhieuTra]) VALUES (N'PT01      ', N'PM001     ', CAST(0x923D0B00 AS Date), N'NV0003    ')
INSERT [dbo].[PHIEU TRA] ([MaPhieuTra], [MaPhieuMuon], [NgayLapPhieuTra], [MaNVLapPhieuTra]) VALUES (N'PT02      ', N'PM002     ', CAST(0x923D0B00 AS Date), N'NV0003    ')
INSERT [dbo].[PHIEU TRA] ([MaPhieuTra], [MaPhieuMuon], [NgayLapPhieuTra], [MaNVLapPhieuTra]) VALUES (N'PT03      ', N'PM003     ', CAST(0x923D0B00 AS Date), N'NV0003    ')
INSERT [dbo].[PHIEU TRA] ([MaPhieuTra], [MaPhieuMuon], [NgayLapPhieuTra], [MaNVLapPhieuTra]) VALUES (N'PT04      ', N'PM004     ', CAST(0x923D0B00 AS Date), N'NV0003    ')
INSERT [dbo].[PHIEU TRA] ([MaPhieuTra], [MaPhieuMuon], [NgayLapPhieuTra], [MaNVLapPhieuTra]) VALUES (N'PT05      ', N'PM005     ', CAST(0x923D0B00 AS Date), N'NV0003    ')
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL001     ', N'NHẬP MÔN LẬP TRÌNH', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL002     ', N'KĨ THUẬT LẬP TRÌNH', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL003     ', N'MẠNG MÁY TÍNH', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL004     ', N'CẤU TRÚC DỮ LIỆU', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL005     ', N'CÁC THUẬT TOÁN THÔNG MINH', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL006     ', N'Linux All-In-One For Dummies - 5Th Edition', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL007     ', N'Php, Mysql, Javascript & Html5 All-In-One For Dummies', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL008     ', N'Ba Người Lính Ngự Lâm', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL009     ', N'CUỐN THEO CHIỀU GIÓ', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL010     ', N'NGƯỜI HOBBIT', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL011     ', N'LỊCH SỬ THỜI GIAN', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL012     ', N'NGUỒN GỐC CÁC LOÀI', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL013     ', N'VŨ TRỤ', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL014     ', N'THE GRAND DESIGN', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL015     ', N'Nghiên cứu thiết kế chi tiết và ứng dụng công nghệ để chế tạo, lắp ráp và hạ thủy giàn khoan tự nâng ở độ sâu 90m nước phù hợp với điều kiện Việt Nam.', 1, N'CÔNG TRÌNH NGHIÊN CỨU', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL016     ', N'Xây dựng đồng bộ hệ thống hạ tầng kỹ thuật đô thị, nông thôn, bảo vệ môi trường, phòng chống thiên tai và ứng phó với biến đổi khí hậu.', 1, N'CÔNG TRÌNH NGHIÊN CỨU', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL017     ', N'Nghiên cứu ứng dụng khoa học công nghệ nhằm đảm bảo an toàn truyền máu, phục vụ cho cấp cứu và đảm bảo đủ máu dự trữ cho điều trị.', 1, N'CÔNG TRÌNH NGHIÊN CỨU', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL019     ', N'Ứng dụng các kỹ thuật tiên tiến trong chẩn đoán, điều trị một số bệnh lý mạch não bằng Điện quang can thiệp nội mạch.', 1, N'CÔNG TRÌNH NGHIÊN CỨU', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL020     ', N'Nghiên cứu ứng dụng kỹ thuật hiện đại về bức xạ ion hóa trong chẩn đoán, điều trị ung thư và một số bệnh lý khác.', 0, N'CÔNG TRÌNH NGHIÊN CỨU', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL021     ', N'Các bất biến và cấu trúc của vành địa phương và vành phân bậc.', 0, N'CÔNG TRÌNH NGHIÊN  CỨU', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL022     ', N'Nghiên cứu ứng dụng các kỹ thuật lọc máu hiện đại trong hồi sức cấp cứu bệnh nhân nặng và ứng phó với một số dịch bệnh nguy hiểm.', 0, N'CÔNG TRÌNH NGHIÊN CỨU ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL023     ', N'Nghiên cứu cơ bản và định hướng ứng dụng các vật liệu từ liên kim loại đất hiếm - kim loại chuyển tiếp.', 0, N'CÔNG TRÌNH NGHIÊN CỨU', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL024     ', N'Science in Action: How to Follow Scientists and Engineers Through Society', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL025     ', N'The Science of Interstellar', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL026     ', N'Những Lựa Chọn Thay Đổi Cuộc Đời', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL027     ', N'Ăn, Cầu Nguyện, Yêu', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL028     ', N'Tỷ Phú Bán Giày', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL029     ', N'Phớt Lờ Tất Cả Và Bơ Đi Mà Sống', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL030     ', N'10 Điều Khác Biệt Nhất Giữa Kẻ Làm Chủ và Người Làm Thuê', 1, N'SÁCH', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL031     ', N'Asia research network', 1, N'TẠP CHÍ', 20)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL032     ', N'Châu Mỹ ngày nay', 1, N'TẠP CHÍ', 20)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL033     ', N'Nghiên cứu con người', 1, N'TẠP CHÍ', 20)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL034     ', N'Khoa học & giáo dục', 1, N'TẠP CHÍ', 20)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL035     ', N'Nghiên cứu phát triển bền vững', 1, N'TẠP CHÍ', 20)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL036     ', N'Nucb Journal of language culture and communication', 1, N'TẠP CHÍ', 20)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL037     ', N'	Nghiên cứu thành phần hóa học và tác dụng bảo vệ gan của cao chiết nước và cao chiết cồn từ cây An xoa (Helicteres hirsuta L.) trên mô hình chuột /', 1, N'LUẬN VĂN', 10)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL038     ', N'	Khảo sát thành phần hóa học của cây An Điền hoa nhỏ Hedyotis tenelliflora Blume , Họ cà phê (Rubiaceae) ', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL039     ', N'	Study on chamical constituents of Hedyotis lindleyana Hook.', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL040     ', N'	Study of alkaloids from roots of Eurycoma longifolia Jack (Simarubaceae) growing in Phu Yen province /', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL041     ', N'	Khảo sát thành phần hóa học cao chloroform của lá cây bàng biển (Calotropis gigantea L.) họ thiên lý (Asclepiadaceace)', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL042     ', N'	Khảo sát thành phần hóa học cao eter dầu hỏa vỏ trái Bòn bon (Lansium domesticum) ', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL043     ', N'Phân lập Terpenoid từ vỏ trái bòn bon (Lansium domesticum) ', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL044     ', N'	Nghiên cứu xây dựng hệ thống giao diện người dùng trên điện thoại di động theo hướng tiếp cận mô hình ', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL045     ', N'	Áp dụng kỹ thuật tập thô và tập mờ trong phân tích dữ liệu bảo hiểm ', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL046     ', N'	Áp dụng lý thuyết đồ thị trong thiết kế mạng thông tin số liệu', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL047     ', N'	Dùng một số thuật toán khai khoáng dữ liệu hỗ trợ quản lý truy xuất các địa chỉ Internet ở WebServer', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL048     ', N'Giải thuật di truyền trong một lớp bài toán lập lịch', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL049     ', N'Hệ chẩn đoán sự cố truyền thông qua Modem ', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL050     ', N'Hệ chuyên gia quản lý trong kho bạc nhà nước- Một số vấn đề về thiết kế và cài đặt', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL051     ', N'Nghiên cứu tích hợp một số phương pháp phân lớp văn bản ', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL052     ', N'Phát triển một số phương pháp phân tích tế bào máu và ứng dụng ', 1, N'LUẬN VĂN', 5)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL053     ', N'International journal of the computer, the internet and management', 0, N'TẠP CHÍ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL054     ', N'PC world VietNam - Thế giới vi tính : sêri A', 0, N'TẠP CHÍ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL055     ', N'Điện tử - Máy tính', 0, N'TẠP CHÍ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL056     ', N'Thời báo vi tính Sài gòn', 0, N'TẠP CHÍ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL057     ', N'Thế giới số', 0, N'TẠP CHÍ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL058     ', N'BioTechniques', 0, N'TẠP CHÍ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL059     ', N'Công nghệ sinh học', 0, N'TẠP CHÍ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL060     ', N'Tạp chí Dược học', 0, N'TẠP CHÍ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL061     ', N'Nonlinear functional analysis and applications', 0, N'TẠP CHÍ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL062     ', N'Vietnam journal of mechanics', 0, N'TẠP CHÍ', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL063     ', N'	Hội nghị tổng kết hoạt động khoa học và công nghệ giai đoạn 2006 - 2007 phương hướng nhiệm vụ giai đoạn 2008 - 2010', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL064     ', N'Kỷ yếu hội nghị khoa học sinh viên / Trường Đại học Tổng hợp TP. Hồ Chí Minh', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL065     ', N'	Tóm tắt báo cáo hội nghị khoa học lần thứ II ', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL066     ', N'Tóm tắt nội dung báo cáo khoa học hội nghị khoa học & công nghệ lần 8 (25-26/4/2002)', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL067     ', N'Hội nghị tổng kết hoạt động khoa học và công nghệ giai đoạn 2001 - 2005 phương hướng nhiệm vụ giai đoạn 2006 - 2010 / Đại Học Quốc Gia TP.HCM', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL068     ', N'Tóm tắt báo cáo hội nghị khoa học : 1998 / Trường Đại học Khoa học Tự nhiên', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL069     ', N'Hội nghị khoa học lần thứ 20 : Kỷ niệm 50 năm thành lập Trường Đại học Bách khoa Hà Nội 1956 - 2006 : tuyển tập báo cáo tóm tắt / Trường Đại học Bách Khoa Hà Nội', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL070     ', N'Hội nghị khoa học lần thứ 5 Trường Đại học Bách Khoa Thành phố Hồ Chí Minh / Trường Đại học Bách Khoa Thành phố Hồ Chí Minh', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL071     ', N'Tóm tắt báo cáo khoa học', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL072     ', N'Tóm tắt các báo cáo khoa học của Phân viện khoa học Việt Nam tại thành phố Hồ Chí Minh / Phân Viện Khoa học Việt Nam', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL073     ', N'Proceedings of the thirty-seventh SIGCSE Technical Symposium on Computer Science Education : SIGCSE 2006 : Houston, Tex., USA, March 1-5, 2006', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL074     ', N'Evolutionary programming VI : 6th international conference, EP97, Indianapolis, Indiana, USA, April 13-16, 1997', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL075     ', N'Mathematical theory of automata', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL076     ', N'The 4th seminar on environmental science and technology issues related to the sustainable development for urban and coastal areas', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL077     ', N'Hội nghị khoa học các khoa tự nhiên : 19-01-1995 / Trường Đại học Tổng hợp TP.HCM', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL078     ', N'	Hội nghị khoa học lần thứ IX : chương trình hội nghị, 21/11/2014', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL079     ', N'Hội nghị khoa học lần thứ VI : chương trình hội nghị, 14/11/2008 / Trường Đại học Khoa học Tự nhiên', 1, N'HỘI NGHỊ-BÁO CÁO', 15)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL080     ', N'Hội nghị khoa học lần thứ VIII : chương trình hội nghị, 9/11/2012 / Trường Đại học Khoa học Tự nhiên', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL081     ', N'Hội nghị khoa học lần thứ X : chương trình hội nghị, 11/11/2016 / Trường Đại học Khoa học Tự nhiên', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL082     ', N'Tóm tắt báo cáo hội nghị khoa học lần III ', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL083     ', N'Hội nghị khoa học lần thứ 4 : tóm tắt nội dung báo cáo khoa học ', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL084     ', N'	Hội nghị khoa học lần thứ 5 : tóm tắt nội dung báo cáo khoa học', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL085     ', N'Hội nghị khoa học lần thứ IX : kỷ yếu hội nghị, 21/11/2014 / Trường Đại học Khoa học Tự nhiên', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL086     ', N'Hội nghị khoa học sinh viên lần III : 28.12.1999 / Trường Đại học Khoa học Tự nhiên', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL087     ', N'Kỷ yếu hội nghị khoa học các công trình nghiên cứu trong năm học 1994 - 1995 của các CBGD trẻ, học viên cao học và nghiên cứu sinh / Trường Đại học Tổng hợp TP. Hồ Chí Minh', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL088     ', N'Kỷ yếu hội nghị khoa học trẻ 1994 (Khối Nghiên cứu sinh, Cán bộ giảng dạy) / Trường Đại học Tổng hợp TP.HCM', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL089     ', N'	The 21st century COE program "Towards a new basic science : depth and synthesis : Osaka university"', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
INSERT [dbo].[TAI LIEU] ([MaTaiLieu], [TenTaiLieu], [HienTrang], [LoaiTaiLieu], [SoLuong]) VALUES (N'TL090     ', N'	The 3rd academic conference on natural science for master and PhD students from ASEAN countries : proceedings, 11 - 15 November 2013 ', 0, N'HỘI NGHỊ-BÁO CÁO', 0)
ALTER TABLE [dbo].[CHI TIET PHIEU MUON]  WITH CHECK ADD  CONSTRAINT [FK_CHI TIET PHIEU MUON_PHIEU MUON1] FOREIGN KEY([MaPhieuMuon])
REFERENCES [dbo].[PHIEU MUON] ([MaPhieuMuon])
GO
ALTER TABLE [dbo].[CHI TIET PHIEU MUON] CHECK CONSTRAINT [FK_CHI TIET PHIEU MUON_PHIEU MUON1]
GO
ALTER TABLE [dbo].[CHI TIET PHIEU MUON]  WITH CHECK ADD  CONSTRAINT [FK_CHI TIET PHIEU MUON_TAI LIEU] FOREIGN KEY([MaTaiLieu])
REFERENCES [dbo].[TAI LIEU] ([MaTaiLieu])
GO
ALTER TABLE [dbo].[CHI TIET PHIEU MUON] CHECK CONSTRAINT [FK_CHI TIET PHIEU MUON_TAI LIEU]
GO
ALTER TABLE [dbo].[CHI TIET PHIEU PHAT]  WITH CHECK ADD  CONSTRAINT [FK_CHI TIET PHIEU PHAT_PHIEU PHAT] FOREIGN KEY([MaPhieuPhat])
REFERENCES [dbo].[PHIEU PHAT] ([MaPhieuPhat])
GO
ALTER TABLE [dbo].[CHI TIET PHIEU PHAT] CHECK CONSTRAINT [FK_CHI TIET PHIEU PHAT_PHIEU PHAT]
GO
ALTER TABLE [dbo].[CHI TIET PHIEU TRA]  WITH CHECK ADD  CONSTRAINT [FK_CHI TIET PHIEU TRA_DOC GIA] FOREIGN KEY([MaDocGia])
REFERENCES [dbo].[DOC GIA] ([MaDocGia])
GO
ALTER TABLE [dbo].[CHI TIET PHIEU TRA] CHECK CONSTRAINT [FK_CHI TIET PHIEU TRA_DOC GIA]
GO
ALTER TABLE [dbo].[CHI TIET PHIEU TRA]  WITH CHECK ADD  CONSTRAINT [FK_CHI TIET PHIEU TRA_PHIEU TRA] FOREIGN KEY([MaPhieuTra])
REFERENCES [dbo].[PHIEU TRA] ([MaPhieuTra])
GO
ALTER TABLE [dbo].[CHI TIET PHIEU TRA] CHECK CONSTRAINT [FK_CHI TIET PHIEU TRA_PHIEU TRA]
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
ALTER TABLE [dbo].[PHIEU MUON]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU MUON_DOC GIA1] FOREIGN KEY([MaDocGia])
REFERENCES [dbo].[DOC GIA] ([MaDocGia])
GO
ALTER TABLE [dbo].[PHIEU MUON] CHECK CONSTRAINT [FK_PHIEU MUON_DOC GIA1]
GO
ALTER TABLE [dbo].[PHIEU MUON]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU MUON_NHAN VIEN] FOREIGN KEY([MaNVLapPhieuMuon])
REFERENCES [dbo].[NHAN VIEN] ([MaNV])
GO
ALTER TABLE [dbo].[PHIEU MUON] CHECK CONSTRAINT [FK_PHIEU MUON_NHAN VIEN]
GO
ALTER TABLE [dbo].[PHIEU NHAC NHO]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU NHAC NHO_CHI TIET PHIEU MUON1] FOREIGN KEY([STTMuon])
REFERENCES [dbo].[CHI TIET PHIEU MUON] ([STTMuon])
GO
ALTER TABLE [dbo].[PHIEU NHAC NHO] CHECK CONSTRAINT [FK_PHIEU NHAC NHO_CHI TIET PHIEU MUON1]
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
ALTER TABLE [dbo].[PHIEU TRA]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU TRA_PHIEU MUON] FOREIGN KEY([MaPhieuMuon])
REFERENCES [dbo].[PHIEU MUON] ([MaPhieuMuon])
GO
ALTER TABLE [dbo].[PHIEU TRA] CHECK CONSTRAINT [FK_PHIEU TRA_PHIEU MUON]
GO
USE [master]
GO
ALTER DATABASE [QL_thuvien] SET  READ_WRITE 
GO
