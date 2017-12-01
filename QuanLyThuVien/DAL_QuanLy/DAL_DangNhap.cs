using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;

namespace DAL_QuanLy
{
    public class DAL_DangNhap : DBConnect
    {


        public string getNameUser_Login(string username, string password)
        {
            string strSql1 = "usp_LayTenNhanVien";
            DBConnect provider1 = new DBConnect();
            provider1.Connect();

            SqlParameter p1 = new SqlParameter("@TenNV", SqlDbType.NVarChar, 100);
            p1.Direction = ParameterDirection.Output;

            provider1.ExecuteNonQuery(CommandType.StoredProcedure, strSql1,
             new SqlParameter { ParameterName = "@UserName", Value = username },
             new SqlParameter { ParameterName = "@Pass", Value = password }, p1);

            provider1.Disconnect();
            return p1.Value.ToString();
        }
        public string getPermissionUser_Login(string username, string password)
        {
            string strSql2 = "usp_LayQuyenNhanVien";
            DBConnect provider2 = new DBConnect();
            provider2.Connect();

            SqlParameter p2 = new SqlParameter("@QuyenNV", SqlDbType.NVarChar, 100);
            p2.Direction = ParameterDirection.Output;

            provider2.ExecuteNonQuery(CommandType.StoredProcedure, strSql2,
            new SqlParameter { ParameterName = "@UserName", Value = username },
            new SqlParameter { ParameterName = "@Pass", Value = password }, p2);

            provider2.Disconnect();
            return p2.Value.ToString();
        }
        public string _Login(string username, string password)
        {
            string strSql = "usp_Login";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@result", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@username", Value = username },
            new SqlParameter { ParameterName = "@password", Value = password }, p);

            provider.Disconnect();
            return p.Value.ToString();
        }

    }
}
