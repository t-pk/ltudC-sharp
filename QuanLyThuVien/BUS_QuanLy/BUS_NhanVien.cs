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
       DAL_NhanVien dalHome = new DAL_NhanVien();
        
        public bool updateNV(DTO_NhanVien DTO_Home)
        {
            return dalHome.updateNhanVien(DTO_Home);

        }

        public DataTable getNV()
        {
            return dalHome.getNV();
        }
    }
}
