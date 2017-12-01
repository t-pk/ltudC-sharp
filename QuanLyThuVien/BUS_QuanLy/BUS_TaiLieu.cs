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
    }
}
