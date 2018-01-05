using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;
namespace DAL_QuanLy
{
    public class DAL_PhieuMuon : DBConnect 
    {
        public DataTable XemTatCaPhieuMuon()
        {
            string strSql = "exec usp_XemPhieuMuon";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;

        }

        public int ThemPhieuMuon(DTO_PhieuMuon DTO)
        {
            string strSql = "usp_ThemPhieuMuon";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@result", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaNVLapPhieuMuon", Value = DTO.MaNhanVienLapPhieuMuon },
            new SqlParameter { ParameterName = "@MaDocGia", Value = DTO.MaDocGiaMuon }, p);
            provider.Disconnect();

            return Int32.Parse(p.Value.ToString());
        }


        public void ThemChiTietPhieuMuon(DTO_PhieuMuon DTO)
        {
            string strSql = "usp_ThemChiTietPhieuMuon";
            DBConnect provider = new DBConnect();
            provider.Connect();

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaCTPM", Value = DTO.MaCTPM },
            new SqlParameter { ParameterName = "@MaTaiLieu", Value = DTO.MaTaiLieuMuon },
            new SqlParameter { ParameterName = "@MaPhieuMuon", Value = DTO.MaPhieuMuon });
            provider.Disconnect();
        }

        public string getMaPhieuMuon()
        {
            string strSql = "usp_TimMaPhieuMuonTiepTheo";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@Maphieumuon", SqlDbType.NVarChar, 100);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql, p);

            provider.Disconnect();
            return p.Value.ToString();
        }

        public string LayMaDocGiaDePhat(string maPhieuMuon)
        {
            string strSql = "usp_LayMaDocGiaDePhat";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@MaDocGia", SqlDbType.NVarChar, 100);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaPhieuMuon", Value = maPhieuMuon }, p);

            provider.Disconnect();
            return p.Value.ToString();
        }

        public string getMaChiTietPhieuMuon()
        {
            string strSql = "usp_TimMaChiTietPhieuMuonTiepTheo";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@MaCTPM", SqlDbType.NVarChar, 100);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql, p);

            provider.Disconnect();
            return p.Value.ToString();
        }

        public DataTable XemChiTietPhieuMuon(string maPhieuMuon)
        {
            string strSql = "exec usp_xemChiTietPhieuMuon " + maPhieuMuon;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;

        }


        public DataTable LayDanhSachMaDocGia()
        {
            string strSql = "exec usp_LayDanhSachDocGia";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }


        public DataTable LayDanhSachMaTaiLieu()
        {
            string strSql = "exec usp_LayDanhSachTaiLieu";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }

        public bool XoaPhieuMuon(string maPhieuMuon)
        {
            try
            {
                string strSql = "usp_XoaPhieuMuon";
                DBConnect provider = new DBConnect();
                provider.Connect();

                provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaPhieuMuon", Value = maPhieuMuon });
                provider.Disconnect();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public DataTable SearchPhieuMuonTheoMaDocGia(string maDocGia)
        {
            string strSql = "usp_SearchPhieuMuonTheoMaDocGia " + maDocGia;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;

        }

        public DataTable SearchPhieuMuonTheoMaPhieuMuon(string maPhieuMuon)
        {
            string strSql = "exec usp_SearchPhieuMuonTheoMaPM " + maPhieuMuon;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }

        public int SoSachMuonToiDa(string maDocGia)
        {
            string strSql = "usp_LaySoSachMuonToiDa";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@Result", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaDocGia", Value = maDocGia }, p);

            provider.Disconnect();
            return Int32.Parse(p.Value.ToString());
        }

        public bool KiemTraMuonTaiLieuDacBiet(string maDocGia, string maTaiLieu)
        {
            string strSql = "usp_KiemTraMuonTaiLieuDacBiet";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@result", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaDocGia", Value = maDocGia },
                new SqlParameter { ParameterName = "@MaTaiLieu", Value = maTaiLieu }, p);

            provider.Disconnect();
            if (p.Value.ToString() == "1")
                return true;
            else
                return false;
        }

        public int SoSachDangMuon(string maDocGia)
        {
            string strSql = "usp_SoSachDangMuon";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@SoSachDangMuon", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaDocGia", Value = maDocGia }, p);

            provider.Disconnect();
            return Int32.Parse(p.Value.ToString());
        }

        public int SoLanViPham(string maDocGia)
        {
            string strSql = "usp_SoLanViPham";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@SoLanViPham", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaDocGia", Value = maDocGia }, p);

            provider.Disconnect();
            return Int32.Parse(p.Value.ToString());
        }

        public void UpdatePhieuMuon(DTO_PhieuMuon PM)
        {
            string strSql = "usp_CapNhatPhieuMuon";
            DBConnect provider = new DBConnect();
            provider.Connect();

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaCTPM", Value = PM.MaCTPM },
                new SqlParameter { ParameterName = "@MaTaiLieu", Value = PM.MaTaiLieuMuon },
                new SqlParameter { ParameterName = "@MaTaiLieuCu", Value = PM.MaTaiLieuCu },
                new SqlParameter { ParameterName = "@MaPhieuMuon", Value = PM.MaPhieuMuon });

            provider.Disconnect();
        }
    }
}