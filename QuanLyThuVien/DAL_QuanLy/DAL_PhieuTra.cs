using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;
using System.Windows.Forms;

namespace DAL_QuanLy
{
    public class DAL_PhieuTra : DBConnect
    {
        // PHIẾU TRẢ

        public DataTable LayDanhSachMaPhieuMuon()
        {
            string strSql = "usp_LoadMaPhieuMuon";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }


        public DataTable LayDanhSachMaTaiLieuCuaPhieuMuon(string maPhieuMuon)
        {
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();

            //string strSql = "usp_LoadMaTLCuaPM " + maPhieuMuon;
            //DataTable dt = DBConnect.Select(CommandType.Text, strSql);

            string sql = "usp_LayMaTLCuaPM";
            DataTable dt = DBConnect.Select(CommandType.StoredProcedure, sql,
            new SqlParameter { ParameterName = "@MaPhieuMuon", Value = maPhieuMuon });
            DBConnect.Disconnect();
            return dt;
        }


        public DataTable XemTatCaPhieuTra()
        {
            string strSql = "exec usp_XemPhieuTra";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;

        }
        public void ThemPhieuTra(DTO_PhieuTra DTO)
        {
            string strSql = "usp_ThemPhieuTra";
            DBConnect provider = new DBConnect();
            provider.Connect();

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaPhieuTra", Value = DTO.MaPhieuTra },
            new SqlParameter { ParameterName = "@MaNVLapPhieuTra", Value = DTO.MaNhanVienLapPhieuTra });
            provider.Disconnect();
        }
        public void ThemChiTietPhieuTra(DTO_PhieuTra DTO)
        {
            string strSql = "usp_ThemChiTietPhieuTra";
            DBConnect provider = new DBConnect();
            provider.Connect();

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaCTPT", Value = DTO.MaCTPT },
            new SqlParameter { ParameterName = "@MaPhieuTra", Value = DTO.MaPhieuTra },
            new SqlParameter { ParameterName = "@MaPhieuMuon", Value = DTO.MaPhieuMuon },
            new SqlParameter { ParameterName = "@MaTaiLieu", Value = DTO.MaTaiLieu });
            provider.Disconnect();
        }
        public DataTable XemChiTietPhieuTra(string maPhieuTra)
        {
            string strSql = "exec usp_XemCTPhieuTra " + maPhieuTra;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;

        }

        public string LayMaPhieuTraTiepTheo()
        {
            string strSql = "usp_TimMaPhieuTraTiepTheo";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@MaPhieuTra", SqlDbType.NVarChar, 100);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql, p);

            provider.Disconnect();
            return p.Value.ToString();
        }


        public string LayMaChiTietPhieuTraTiepTheo()
        {
            string strSql = "usp_TimMaCTPTTiepTheo";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@MaCTPT", SqlDbType.NVarChar, 100);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql, p);

            provider.Disconnect();
            return p.Value.ToString();
        }


        public int LaySoNgayQuaHan(string maPhieuMuon)
        {
            string strSql = "usp_LaySoNgayQuaHan";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@NQH", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaPhieuMuon", Value = maPhieuMuon }, p);

            provider.Disconnect();
            return Int32.Parse(p.Value.ToString());
        }


        public int LaySoSachCuaPM(string maPhieuMuon)
        {
            string strSql = "usp_LaySoSachCuaPM";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@SoSach", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaPhieuMuon", Value = maPhieuMuon }, p);

            provider.Disconnect();
            return Int32.Parse(p.Value.ToString());
        }


        public int LaySoLanViPhamCuaPhieuMuon(string maPhieuMuon)
        {
            string strSql = "usp_LaySoLanViPhamCuaPhieuMuon";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@SLVP", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaPhieuMuon", Value = maPhieuMuon }, p);

            provider.Disconnect();
            return Int32.Parse(p.Value.ToString());
        }




        // chưa có proc xóa phiếu trả
        public bool XoaPhieuTra(string maPhieuTra)
        {
            try
            {
                string strSql = "usp_Xoaphieutra";
                DBConnect provider = new DBConnect();
                provider.Connect();

                provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@Maphieutra", Value = maPhieuTra });
                provider.Disconnect();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public void ChinhSuaCTPhieuTra(string maCTPT, string maPhieuTra, string maPhieuMuon, string maTaiLieu)
        {
            string strSql = "usp_ChinhSuaPhieuTra";
            DBConnect provider = new DBConnect();
            provider.Connect();

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaCTPT", Value = maCTPT },
            new SqlParameter { ParameterName = "@MaPhieuTra", Value = maPhieuTra },
            new SqlParameter { ParameterName = "@MaPhieuMuon", Value = maPhieuMuon },
            new SqlParameter { ParameterName = "@MaTaiLieu", Value = maTaiLieu });
            provider.Disconnect();
        }

        public DataTable SearchPT_PT(string maPhieuTra)
        {
            string strSql = "exec usp_SearchPhieuTratheoMaPT " + maPhieuTra;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }


        public DataTable SearchPT_PM(string maPhieuMuon)
        {
            string strSql = "exec usp_SearchPhieuTratheoMaPM " + maPhieuMuon;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }

        public DataTable SearchPT_DG(string maDocGia)
        {
            string strSql = "exec usp_SearchPhieuTratheoMaDG " + maDocGia;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }
    }
}
