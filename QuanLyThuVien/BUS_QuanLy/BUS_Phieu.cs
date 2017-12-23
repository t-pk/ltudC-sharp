using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL_QuanLy;
using DTO_QuanLy;
using System.Data;
namespace BUS_QuanLy
{
   public class BUS_Phieu
    {
        // Phiếu Mượn
        DAL_PhieuMuon dal_Phieu = new DAL_PhieuMuon();
        
        public DataTable XemTatCaPhieuMuon()
        {
            return dal_Phieu.XemTatCaPhieuMuon();
        }
        public bool XoaPhieuMuon(string maPhieuMuon)
        {
            return dal_Phieu.XoaPhieuMuon(maPhieuMuon);
        }
        public DataTable XemChiTietPhieuMuon(string maPhieuMuon)
        {
            return dal_Phieu.XemChiTietPhieuMuon(maPhieuMuon);
        }
        public int ThemPhieuMuon(DTO_PhieuMuon DTO)
        {
             return dal_Phieu.ThemPhieuMuon(DTO);
        }

        public void ThemChiTietPhieuMuon(DTO_PhieuMuon DTO)
        {
            dal_Phieu.ThemChiTietPhieuMuon(DTO);
        }


        public DataTable SearchPhieuMuonTheoMaDocGia(string maDocGia)
        {
            return dal_Phieu.SearchPhieuMuonTheoMaDocGia(maDocGia);
        }


        public DataTable SearchPhieuMuonTheoMaPhieuMuon(string maPhieuMuon)
       {
           return dal_Phieu.SearchPhieuMuonTheoMaPhieuMuon(maPhieuMuon);
       }

       public int SoSachMuonToiDa(string maDocGia)
        {
            return dal_Phieu.SoSachMuonToiDa(maDocGia);
        }

       public int SoSachDangMuon(string maDocGia)
       {
           return dal_Phieu.SoSachDangMuon(maDocGia);
       }

       public int SoLanViPham(string maDocGia)
       {
           return dal_Phieu.SoLanViPham(maDocGia);
       }

       public bool KiemTraMuonTaiLieuDacBiet(string maDocGia, string maTaiLieu)
       {
           return dal_Phieu.KiemTraMuonTaiLieuDacBiet(maDocGia, maTaiLieu);
       }

        // Phiếu Trả
        DAL_PhieuTra dal_PhieuTra = new DAL_PhieuTra();
        public DataTable XemTatCaPhieuTra()
        {
            return dal_PhieuTra.XemTatCaPhieuTra();
        }
        public bool XoaPhieuTra(string maPhieuTra)
        {
            return dal_PhieuTra.XoaPhieuTra(maPhieuTra);
        }
        public DataTable XemChiTietPhieuTra(string maPhieuTra)
        {
            return dal_PhieuTra.XemChiTietPhieuTra(maPhieuTra);
        }
        public void ThemPhieuTra(DTO_PhieuTra DTO)
        {
            dal_PhieuTra.ThemPhieuTra(DTO);
        }

        public void ThemChiTietPhieuTra(DTO_PhieuTra DTO)
        {
            dal_PhieuTra.ThemChiTietPhieuTra(DTO);
        }

       public string LayMaPhieuMuonTiepTheo()
        {
            return dal_Phieu.getMaPhieuMuon();
        }

       public int LaySoNgayQuaHan(string maPhieuMuon)
       {
           return dal_PhieuTra.LaySoNgayQuaHan(maPhieuMuon);
       }

       public int LaySoSachCuaPM(string maPhieuMuon)
       {
           return dal_PhieuTra.LaySoSachCuaPM(maPhieuMuon);
       }

       public int LaySoLanViPhamCuaPhieuMuon(string maPhieuMuon)
       {
           return dal_PhieuTra.LaySoLanViPhamCuaPhieuMuon(maPhieuMuon);
       }

       public string LayMaChiTietPhieuMuonTiepTheo()
       {
           return dal_Phieu.getMaChiTietPhieuMuon();
       }

       public DataTable LayDanhSachMaDocGia()
       {
           return dal_Phieu.LayDanhSachMaDocGia();
       }

       public DataTable LayDanhSachMaTailieu()
       {
           return dal_Phieu.LayDanhSachMaTaiLieu();
       }

       public DataTable getListPhieuMuon()
       {
           return dal_PhieuTra.LayDanhSachMaPhieuMuon();
       }

       public DataTable LayDanhSachMaTaiLieuCuaPhieuMuon(string maPhieuMuon)
       {
           return dal_PhieuTra.LayDanhSachMaTaiLieuCuaPhieuMuon(maPhieuMuon);
       }

       public string LayMaPhieuTraTiepTheo()
       {
           return dal_PhieuTra.LayMaPhieuTraTiepTheo();
       }

       public string LayMaChiTietPhieuTraTiepTheo()
       {
           return dal_PhieuTra.LayMaChiTietPhieuTraTiepTheo();
       }

       public void ChinhSuaCTPhieuTra(string maCTPT, string maPhieuTra, string maPhieuMuon, string maTaiLieu)
       {
           dal_PhieuTra.ChinhSuaCTPhieuTra(maCTPT, maPhieuTra, maPhieuMuon, maTaiLieu);
       }


       public DataTable SearchPT_PT(string maPhieuTra)
       {
           return dal_PhieuTra.SearchPT_PT(maPhieuTra);
       }

       public DataTable SearchPT_PM(string maPhieuMuon)
       {
           return dal_PhieuTra.SearchPT_PM(maPhieuMuon);
       }

       public DataTable SearchPT_DG(string maDocGia)
       {
           return dal_PhieuTra.SearchPT_DG(maDocGia);
       }

       
        //PHIẾU PHẠT 
        DAL_PhieuPhat dal_Phieuphat = new DAL_PhieuPhat();
        public DataTable XemTatCaPhieuPhat()
        {
            return dal_Phieuphat.XemTatCaPhieuPhat();
        }
        public int ThemPhieuPhat(DTO_PhieuPhat DTO)
        {
            return dal_Phieuphat.ThemPhieuPhat(DTO);
        }

        public int XoaPhieuPhat(string maPhieuPhat)
        {
            return dal_Phieuphat.XoaPhieuPhat(maPhieuPhat);
        }

        public DataTable SearchPP_PP(string maPhieuPhat)
        {
            return dal_Phieuphat.SearchPP_PP(maPhieuPhat);
        }

        public DataTable SearchPP_DG(string maDocGia)
        {
            return dal_Phieuphat.SearchPP_DG(maDocGia);
        }

        public DataTable SearchPP_PM(string maPhieuMuon)
        {
            return dal_Phieuphat.SearchPP_PM(maPhieuMuon);
        }

        //PHIẾU NHẮC NHỞ
        DAL_PhieuNhacNho dal_PhieuNhacNho = new DAL_PhieuNhacNho();
        public DataTable XemPhieuNhacNho()
        {
            return dal_PhieuNhacNho.XemPhieuNhacNho();
        }
       public void ThemPhieuNhacNho(string maDocGia)
        {
            dal_PhieuNhacNho.ThemPhieuNhacNho(maDocGia);
        }

       public int XoaPhieuNhacNho(string maDocGia)
       {
           return dal_PhieuNhacNho.XoaPhieuNhacNho(maDocGia);
       }

       public DataTable SearchPNN(string maDocGia)
       {
           return dal_PhieuNhacNho.SearchPNN(maDocGia);
       }

       public void UpdatePNN(string mdg, int SLVP)
       {
           dal_PhieuNhacNho.UpdatePNN(mdg, SLVP);
       }
    }
}
