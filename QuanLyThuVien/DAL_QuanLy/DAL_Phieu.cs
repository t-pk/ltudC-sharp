using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;
namespace DAL_QuanLy
{
    public class DAL_Phieu : DBConnect 
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
        public void ThemPhieuMuon(DTO_Phieu DTO)
        {
            

        }
        // chưa có proc xem chi tiết phiếu mượn
        public DataTable XemChiTietPhieuMuon(string maPhieuMuon)
        {
            string strSql = "exec usp_XemPhieuMuon";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;

        }
        // chưa có proc xóa phiếu mượn
        public bool XoaPhieuMuon()
        {
            try
            {
                return true;
            }
            catch
            {
                return false;
            }
        }

        // PHIẾU TRẢ
        public DataTable XemTatCaPhieuTra()
        {
            string strSql = "exec usp_XemPhieuTra";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;

        }
        // chưa có proc thêm phiếu trả
        public void ThemPhieuTra(DTO_Phieu DTO)
        {


        }
        // chưa có proc xem chi tiết phiếu trả
        public DataTable XemChiTietPhieuTra(string maPhieuMuon)
        {
            string strSql = "exec usp_XemPhieuMuon";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;

        }
        // chưa có proc xóa phiếu trả
        public bool XoaPhieuTra()
        {
            try
            {
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
