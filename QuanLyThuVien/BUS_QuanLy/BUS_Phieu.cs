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
        DAL_Phieu dal_Phieu = new DAL_Phieu();
        public DataTable XemTatCaPhieuMuon()
        {
            return dal_Phieu.XemTatCaPhieuMuon();
        }
        public bool XoaPhieuMuon(string maPhieuMuon)
        {
            return dal_Phieu.XoaPhieuMuon();
        }
        public DataTable XemChiTietPhieuMuon(string maPhieuMuon)
        {
            return dal_Phieu.XemChiTietPhieuMuon(maPhieuMuon);
        }
        public void ThemPhieuMuon(DTO_Phieu DTO)
        {
             dal_Phieu.ThemPhieuMuon(DTO);
        }
        // Phiếu Trả
        public DataTable XemTatCaPhieuTra()
        {
            return dal_Phieu.XemTatCaPhieuTra();
        }
        public bool XoaPhieuTra(string maPhieuTra)
        {
            return dal_Phieu.XoaPhieuTra();
        }
        public DataTable XemChiTietPhieuTra(string maPhieuTra)
        {
            return dal_Phieu.XemChiTietPhieuTra(maPhieuTra);
        }
        public void ThemPhieuTra(DTO_Phieu DTO)
        {
            dal_Phieu.ThemPhieuTra(DTO);
        }
    }
}
