using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;
namespace DAL_QuanLy
{
    public class DAL_PhieuPhat : DBConnect 
    {
        //PHIẾU PHẠT
        public string getMaPhieuPhat()
        {
            string strSql = "usp_TimMaPhieuPhatTiepTheo";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@MAPP", SqlDbType.NVarChar, 100);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql, p);

            provider.Disconnect();
            return p.Value.ToString();
        }

        public DataTable XemTatCaPhieuPhat()
        {
            string strSql = "exec usp_XemPhieuPhat";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }
        public DataTable LayDanhSachMaPhieuMuon()
        {
            string strSql = "usp_LoadMaPhieuMuon";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }
        public int ThemPhieuPhat(DTO_PhieuPhat DTO)
        {
            string strSql = "usp_ThemPhieuPhat";
            DBConnect provider = new DBConnect();
            provider.Connect();

            SqlParameter p = new SqlParameter("@Result", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaPhieuMuon", Value = DTO.MaPhieuMuon },
            new SqlParameter { ParameterName = "@MaNVLapPhieuPhat", Value = DTO.MaNVLapPhieuPhat }, p);
            provider.Disconnect();
            return Int32.Parse(p.Value.ToString());
        }
        public int XoaPhieuPhat(string maPhieuPhat)
        {
            try
            {
                string strSql = "usp_XoaPhieuPhat";
                DBConnect provider = new DBConnect();
                provider.Connect();

                provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaPhieuPhat", Value = maPhieuPhat });
                provider.Disconnect();
                return 1;
            }
            catch
            {
                return 0;
            }
        }

        public DataTable SearchPP_DG(string maDocGia)
        {
            string strSql = "exec usp_SearchPPTheoMaDG " + maDocGia;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }


        public DataTable SearchPP_PM(string maPhieuMuon)
        {
            string strSql = "exec usp_SearchPPTheoMaPM " + maPhieuMuon;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }


        public DataTable SearchPP_PP(string maPhieuPhat)
        {
            string strSql = "exec usp_SearchPPTheoMaPP " + maPhieuPhat;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }


    }
}
