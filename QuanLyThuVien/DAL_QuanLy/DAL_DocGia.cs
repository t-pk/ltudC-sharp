using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;
namespace DAL_QuanLy
{
    public class DAL_DocGia:DBConnect 
    {
        public DataTable getAllDocGia()
        {
            string strSql = "exec usp_TimKiemTatCaDocGia";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);           
            DBConnect.Disconnect();
            return dt;
        }
        public DataTable SearchDocGiaTheoTieuChi(string strSql)
        {
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);            
            DBConnect.Disconnect();
            return dt;
        }
        public DataTable XemChiTietDocGia(string maDocGia)
        {
            string strSql = "exec usp_SearchDocGia " + maDocGia;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);          
            DBConnect.Disconnect();
            return dt;
        }
        public bool XoaDocGia(string maDG)
        {
            string strSql = "usp_XoaDocGia";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            try
            {
                DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaDocGia", Value = maDG });
                DBConnect.Disconnect();
                return true;
            }
            catch
            {
                return false;
            }
            
        }
        public void CapNhatDocGia(DTO_DocGia DTO)
        {
            string strSql = "usp_CapNhatDocGia";

            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();

            DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaDG", Value = DTO._maDG },
            new SqlParameter { ParameterName = "@TenDG", Value = DTO._tenDG },
            new SqlParameter { ParameterName = "@NgaySinhDG", Value = DTO._ngaySinh },
            new SqlParameter { ParameterName = "@DiaChiDG", Value = DTO._DiaChiDG },
            new SqlParameter { ParameterName = "@SDTDG", Value = DTO._SDT_DG },
            new SqlParameter { ParameterName = "@EmailDG", Value = DTO._email },
            new SqlParameter { ParameterName = "@CMNDDG", Value = DTO._CMND_DG },
            new SqlParameter { ParameterName = "@MSSVDG", Value = DTO._MSSV_DG },
            new SqlParameter { ParameterName = "@MCBDG", Value = DTO._MCB_DG },
            new SqlParameter { ParameterName = "@LoaiDG", Value = DTO._LoaiDG });
            DBConnect.Disconnect();
        }

        public string TimMaDocGiaTiepTheo()
        {
            string strSql1 = "usp_TimMaDGTiepTheo";
            DBConnect DBConnect1 = new DBConnect();
            DBConnect1.Connect();
            SqlParameter p = new SqlParameter("@MaDocGia", SqlDbType.VarChar, 100);
            p.Direction = ParameterDirection.Output;
            DBConnect1.ExecuteNonQuery(CommandType.StoredProcedure, strSql1, p);
            DBConnect1.Disconnect();
            return p.Value.ToString();
        }
        public bool ThemDocGia(DTO_DocGia DTO)
        {
            string strSql = "usp_ThemDocGia";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            try
            {
               DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
               new SqlParameter { ParameterName = "@TenDG", Value = DTO._tenDG },
               new SqlParameter { ParameterName = "@NgaySinhDG", Value = DTO._ngaySinh },
               new SqlParameter { ParameterName = "@DiaChiDG", Value = DTO._DiaChiDG },
               new SqlParameter { ParameterName = "@SDTDG", Value = DTO._SDT_DG },
               new SqlParameter { ParameterName = "@EmailDG", Value = DTO._email },
               new SqlParameter { ParameterName = "@CMNDDG", Value = DTO._CMND_DG },
               new SqlParameter { ParameterName = "@MSSVDG", Value = DTO._MSSV_DG },
               new SqlParameter { ParameterName = "@MCBDG", Value = DTO._MCB_DG },
               new SqlParameter { ParameterName = "@LoaiDG", Value = DTO._LoaiDG });
               DBConnect.Disconnect();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public void ADMIN_AD_LDG(string MaLoaiDG, int SoNgayMuonToiDa, int SoSachMuonToiDa, string TenLoaiDG, int PhiThuongNien, string TaiLieuDB)
        {
            string strSql = "usp_AD_Add_LDG";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaLoaiDG", Value = MaLoaiDG },
            new SqlParameter { ParameterName = "@SoNgayMuonToiDa", Value = SoNgayMuonToiDa },
            new SqlParameter { ParameterName = "@SoSachMuonToiDa", Value = SoSachMuonToiDa },
            new SqlParameter { ParameterName = "@TenLoaiDG", Value = TenLoaiDG },
            new SqlParameter { ParameterName = "@PhiThuongNien", Value = PhiThuongNien },
            new SqlParameter { ParameterName = "@TaiLieuDB", Value = TaiLieuDB });
            DBConnect.Disconnect();
        }

        public DataTable LoadLoaiDocGia()
        {
            string strSql = "exec usp_LoadLoaiDocGia";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }

        public void ADMIN_UD_LDG(string MaLoaiDG, int SoNgayMuonToiDa, int SoSachMuonToiDa, string TenLoaiDG, int PhiThuongNien, string TaiLieuDB)
        {
            string strSql = "usp_AD_UP_LDG";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaLoaiDG", Value = MaLoaiDG },
            new SqlParameter { ParameterName = "@SoNgayMuonToiDa", Value = SoNgayMuonToiDa },
            new SqlParameter { ParameterName = "@SoSachMuonToiDa", Value = SoSachMuonToiDa },
            new SqlParameter { ParameterName = "@TenLoaiDG", Value = TenLoaiDG },
            new SqlParameter { ParameterName = "@PhiThuongNien", Value = PhiThuongNien },
            new SqlParameter { ParameterName = "@TaiLieuDB", Value = TaiLieuDB });
            DBConnect.Disconnect();
        }
    }
}
