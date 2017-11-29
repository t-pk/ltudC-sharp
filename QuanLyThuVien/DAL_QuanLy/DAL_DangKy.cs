using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;

namespace DAL_QuanLy
{
    public class DAL_DangKy : DBConnect
    {
   
        public bool addNhanVien(DTO_DangKy DTO_Nhanvien)
        {
            string strSql = "usp_ThemNhanVien";
            DBConnect provider = new DBConnect();
            provider.Connect();

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@CaTruc", Value = DTO_Nhanvien.NhanVien_ca },
            new SqlParameter { ParameterName = "@TenDangNhap", Value = DTO_Nhanvien.NhanVien_user },
            new SqlParameter { ParameterName = "@HoTen", Value = DTO_Nhanvien.NhanVien_hotennv },
            new SqlParameter { ParameterName = "@MatKhau", Value = DTO_Nhanvien.NhanVien_pass },
            new SqlParameter { ParameterName = "@LoaiNV", Value = DTO_Nhanvien.NhanVien_loai });
            provider.Disconnect();
            return true;
        }
        public string TimNhanVienTiepTheo()
        {
            string strSql1 = "usp_TimMaNVTiepTheo";
            DBConnect provider1 = new DBConnect();
            provider1.Connect();

            SqlParameter p = new SqlParameter("@MaNV", SqlDbType.VarChar, 100);
            p.Direction = ParameterDirection.Output;

            provider1.ExecuteNonQuery(CommandType.StoredProcedure, strSql1, p);

            provider1.Disconnect();
            return p.Value.ToString();
        }
    }
}
