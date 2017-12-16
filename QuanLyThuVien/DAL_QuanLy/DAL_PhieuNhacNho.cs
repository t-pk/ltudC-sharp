using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;
namespace DAL_QuanLy
{
    public class DAL_PhieuNhacNho : DBConnect 
    {
        public DataTable XemPhieuNhacNho()
        {
            string strSql = "exec usp_XemPhieuNhacNho";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }

        public void ThemPhieuNhacNho(string madocgia)
        {
            string strSql = "exec usp_ThemPhieuNhacNho " + madocgia;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
        }

        public int XoaPhieuNhacNho(string maDocGia)
        {
            string strSql = "exec usp_XoaPhieuNhacNho " + maDocGia;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return 1;
        }
    }
}
