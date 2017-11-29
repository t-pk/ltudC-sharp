using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL_QuanLy;
using DTO_QuanLy;

namespace BUS_QuanLy
{
    public class BUS_Home
    {
       DAL_Home dalHome = new DAL_Home();
        public bool updateNV(DTO_Home DTO_Home)
        {
            return dalHome.updateNhanVien(DTO_Home);

        }
    }
}
