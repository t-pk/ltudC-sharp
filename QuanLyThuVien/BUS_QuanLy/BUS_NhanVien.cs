using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL_QuanLy;
using DTO_QuanLy;
using System.Data;

namespace BUS_QuanLy
{
    public class BUS_NhanVien
    {
       DAL_NhanVien dal_NhanVien = new DAL_NhanVien();
        
        public bool updateNV(DTO_NhanVien DTO_Home)
        {
            return dal_NhanVien.updateNhanVien(DTO_Home);
        }

        public DataTable getNV()
        {
            return dal_NhanVien.getNV();
        }
        public string getMaNhanVienHienTai(string username)
        {
            return dal_NhanVien.getMaNhanVienHienTai(username);
        }
        public bool XoaNhanVien(string maNV)
        {
            return dal_NhanVien.XoaNhanVien(maNV);
        }
    }
}
