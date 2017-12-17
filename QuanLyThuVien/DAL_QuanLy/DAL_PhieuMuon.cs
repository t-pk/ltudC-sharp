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
        // PHIẾU MƯỢN
        public DataTable XemTatCaPhieuMuon()
        {
            string strSql = "exec usp_XemPhieuMuon";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;

        }
        // chưa có proc thêm phiếu mượn
        public void ThemPhieuMuon(DTO_PhieuMuon DTO)
        {
            string strSql = "usp_ThemPhieuMuon";
            DBConnect provider = new DBConnect();
            provider.Connect();

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaNVLapPhieuMuon", Value = DTO.MaNhanVienLapPhieuMuon },
            new SqlParameter { ParameterName = "@MaDocGia", Value = DTO.MaDocGiaMuon });
            provider.Disconnect();
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

        // chưa có proc xem chi tiết phiếu mượn
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
            DataTable dt = new DataTable();
            DBConnect provider1 = new DBConnect();
            provider1.Connect();
            SqlDataAdapter da = new SqlDataAdapter("Select MaDocGia, HoTen From [DOC GIA]", @"Data Source=WIN-GCDD6G4KV5S\SQLEXPRESS;Initial Catalog=QL_thuvien;Integrated Security=True;");
            da.Fill(dt);
            provider1.Disconnect();
            return dt;
        }


        public DataTable LayDanhSachMaTaiLieu()
        {
            DataTable dt = new DataTable();
            DBConnect provider1 = new DBConnect();
            provider1.Connect();
            SqlDataAdapter da = new SqlDataAdapter("select MaTaiLieu, TenTaiLieu from [TAI LIEU]", @"Data Source=WIN-GCDD6G4KV5S\SQLEXPRESS;Initial Catalog=QL_thuvien;Integrated Security=True;");
            da.Fill(dt);
            provider1.Disconnect();
            return dt;
        }
        // chưa có proc xóa phiếu mượn
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
    }
}
