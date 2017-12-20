using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL_QuanLy;
using DTO_QuanLy;
using System.Data;
namespace BUS_QuanLy
{
   public class BUS_TaiLieu
    {
        DAL_TaiLieu dalTaiLieu = new DAL_TaiLieu();
        public DataTable getTL()
        {
            return dalTaiLieu.getTL();
        }
        public DataTable gettheloai()
        {
            return dalTaiLieu.getTheoLoai();
        }
        public DataTable getTheoMa()
        {
            return dalTaiLieu.getTheoMa();
        }
        public DataTable getTheoTen()
        {
            return dalTaiLieu.getTheoTen();
        }
        public string TimMaTLTiepTheo()
        {
            return dalTaiLieu.TimMaTLTiepTheo();
        }
        public void ThemTaiLieuMoi(DTO_TaiLieu DTO)
        {
            dalTaiLieu.ThemTaiLieuMoi(DTO);
        }
        public DataTable XemChitietTaiLieu(string maTL)
        {
            return dalTaiLieu.xemChiTietTaiLieu(maTL);
        }
        public bool XoaChitietTaiLieu(string maTL)
        {
            return dalTaiLieu.XoaChiTietTaiLieu(maTL);
        }
        public void LuuChitietTaiLieu(DTO_TaiLieu  DTO_TL)
        {
            dalTaiLieu.LuuChiTietTaiLieu(DTO_TL);
        }
        public bool YeuCauThemTaiLieu(string TenTLYeCau)
        {
            return dalTaiLieu.YeuCauThemTaiLieu(TenTLYeCau);
        }
        public DataTable XemTatCaTaiLieuYeuCauMoi()
        {
            return dalTaiLieu.XemTatCaTaiLieuYeuCauMoi();
        }
        public bool XoaTaiLieuYeuCauMoi(string TenTaiLieuYeuCau)
        {
            return dalTaiLieu.XoaTaiLieuYeuCauMoi(TenTaiLieuYeuCau);
        }

       public DataTable LoadTheLoaiTaiLieu()
        {
            return dalTaiLieu.LoadTheLoaiTaiLieu();
        }
    }
}
