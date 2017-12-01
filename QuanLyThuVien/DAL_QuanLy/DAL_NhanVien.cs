using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;
namespace DAL_QuanLy
{
    public class DAL_NhanVien:DBConnect 
    {


        public bool updateNhanVien(DTO_NhanVien DTO_Home)
        {
            string strSql = "usp_CapNhatNhanVien";
            DBConnect provider = new DBConnect();
            provider.Connect();

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                    new SqlParameter { ParameterName = "@MaNV", Value = DTO_Home.NhanVien_manv },
                    new SqlParameter { ParameterName = "@CaTruc", Value = DTO_Home.NhanVien_ca },
                    new SqlParameter { ParameterName = "@TenDangNhap", Value = DTO_Home.NhanVien_user },
                    new SqlParameter { ParameterName = "@MatKhau", Value = DTO_Home.NhanVien_pass },
                    new SqlParameter { ParameterName = "@HoTen", Value = DTO_Home.NhanVien_hotennv },
                    new SqlParameter { ParameterName = "@LoaiNV", Value = DTO_Home.NhanVien_loai });
            provider.Disconnect();
            return true;
        }


        public DataTable getNV()
        {
            string strSql = "exec usp_XemNhanVien";
            DBConnect db = new DBConnect();
            db.Connect();
            DataTable dt = db.Select(CommandType.Text, strSql);
            db.Disconnect();
            return dt;
        }
    }
}
