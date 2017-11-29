using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DAL_QuanLy;
using DTO_QuanLy;

namespace BUS_QuanLy
{
    public class BUS_DangKy
    {
        DAL_DangKy dalDangKy = new DAL_DangKy();
        public bool addNhanVien(DTO_DangKy DTO_NhanVien)
        {
            return dalDangKy.addNhanVien(DTO_NhanVien);
            
        }
        public string TimNhanVienTiepTheo()
        {
            return dalDangKy.TimNhanVienTiepTheo(); 
        }

    }
}
