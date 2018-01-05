using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL_QuanLy;
using DTO_QuanLy;
using System.Data;

namespace BUS_QuanLy
{
    public class BUS_DocGia
    {
        DAL_DocGia dal_DOcGia = new DAL_DocGia();

        public DataTable getAllDocGia()
        {
            return dal_DOcGia.getAllDocGia();
        }
        public DataTable SearchDocGiaTheoTieuChi(string chuoiTimKiem)
        {
            return dal_DOcGia.SearchDocGiaTheoTieuChi(chuoiTimKiem);
        }
        public DataTable XemChiTietDocGia(string maDocGia)
        {
            return dal_DOcGia.XemChiTietDocGia(maDocGia);
        }
        public void CapNhatDocGia(DTO_DocGia DTO)
        {
            dal_DOcGia.CapNhatDocGia(DTO);
        }
        public bool XoaDocGia(string maDG)
        {
            return dal_DOcGia.XoaDocGia(maDG);
        }
        public string TimMaDocGiaTiepTheo()
        {
            return dal_DOcGia.TimMaDocGiaTiepTheo();
        }
        public bool ThemDocGia(DTO_DocGia DTO)
        {
           return dal_DOcGia.ThemDocGia(DTO);
        }

        public void ADMIN_AD_LDG(string MaLoaiDG, int SoNgayMuonToiDa, int SoSachMuonToiDa, string TenLoaiDG, int PhiThuongNien, string TaiLieuDB)
        {
            dal_DOcGia.ADMIN_AD_LDG(MaLoaiDG, SoNgayMuonToiDa, SoSachMuonToiDa, TenLoaiDG, PhiThuongNien, TaiLieuDB);
        }

        public void ADMIN_UD_LDG(string MaLoaiDG, int SoNgayMuonToiDa, int SoSachMuonToiDa, string TenLoaiDG, int PhiThuongNien, string TaiLieuDB)
        {
            dal_DOcGia.ADMIN_UD_LDG(MaLoaiDG, SoNgayMuonToiDa, SoSachMuonToiDa, TenLoaiDG, PhiThuongNien, TaiLieuDB);
        }

        public DataTable LoadLoaiDocGia()
        {
            return dal_DOcGia.LoadLoaiDocGia();
        }
        public Boolean GetNgayHetHan(string MaDG)
        {
            return dal_DOcGia.GetNgayHetHan(MaDG);
        }
        public void UpdateNgayHetHan(string MaDG, string MaLoaiDG)
        {
            dal_DOcGia.UpdateNgayHetHan(MaDG, MaLoaiDG);
        }
    }
}
