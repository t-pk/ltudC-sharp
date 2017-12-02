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
        DAL_Phieu dal_Phieu = new DAL_Phieu();
        public DataTable XemTatCaPhieuMuon()
        {
            return dal_Phieu.XemTatCaPhieuMuon();
        }
       
    }
}
