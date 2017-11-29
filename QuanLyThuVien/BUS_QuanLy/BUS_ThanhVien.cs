using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DAL_QuanLy;
using DTO_QuanLy;

namespace BUS_QuanLy
{
    public class BUS_ThanhVien
    {
        DAL_ThanhVien dalThanhVien = new DAL_ThanhVien();

        // gọi getALLNhanVien thông qua DAL gọi hàm getThanhVien()
        public DataTable getThanhVien()
        {
            return dalThanhVien.getThanhVien();
        }
        public DataTable getNV()
        {
            return dalThanhVien.getNV();
        }
        public bool themThanhVien(DTO_ThanhVien tv)
        {
            return dalThanhVien.themThanhVien(tv);
        }
        // thêm nhân viên sử dụng proc
        public bool themNhanVien(DTO_ThanhVien tv)
        {
            return dalThanhVien.themNhanVien(tv);
        }
        public bool suaThanhVien(DTO_ThanhVien tv)
        {
            return dalThanhVien.suaThanhVien(tv);
        }

        public bool xoaThanhVien(int TV_ID)
        {
            return dalThanhVien.xoaThanhVien(TV_ID);
        }
    }
}
