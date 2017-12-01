using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;

namespace DAL_QuanLy
{
   
    public class DAL_TaiLieu
    {

       static string rong = "";
        public void loai(string a)
        {
            rong = a;
           
        }
        
        public DataTable getTL()
        {
           
            string strSql = "exec usp_XemAllTaiLieu";
            DBConnect db = new DBConnect();
            db.Connect();
            DataTable tl = db.Select(CommandType.Text, strSql);
            db.Disconnect();
            return tl;
        }
        
        public DataTable getTheoLoai()
        {


           

            
           
            string strSql1 = "exec usp_SearchTaiLieuTheoLoai N'" + rong + "'";
            DBConnect db = new DBConnect();
            db.Connect();
            DataTable gettl = db.Select(CommandType.Text, strSql1);
            db.Disconnect();
            return gettl;

           
        }
    }
    
}
