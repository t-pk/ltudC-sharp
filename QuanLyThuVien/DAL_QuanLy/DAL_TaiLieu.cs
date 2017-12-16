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
        static string loaisach = "";
        static string masach = "";
        static string tensach = "";

        //lấy loại sách từ form 
        public void loai(string a)
        {
            loaisach = a;

        }

        //lấy ma sách từ form 
        public void ma(string a)
        {
            masach = a;

        }
        //lấy ten sách từ form 
        public void ten(string a)
        {
            tensach = a;

        }
        public bool YeuCauThemTaiLieu(string TenTLYeuCau)
        {
            string strSql = "usp_ThemYeuCauTaiLieu";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();

            SqlParameter p = new SqlParameter("@result", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@TenTLYeuCau", Value = TenTLYeuCau }, p);
            DBConnect.Disconnect();
            if (p.Value.ToString() == "1")
                return true;
            else
                return false;

        }
        public DataTable XemTatCaTaiLieuYeuCauMoi()
        {
            string strSql1 = "exec usp_XemYeuCauTaiLieu";
            DBConnect db = new DBConnect();
            db.Connect();
            DataTable dt = new DataTable();
            dt = db.Select(CommandType.Text, strSql1);
            if (dt.Rows.Count > 1)
            {
                int maxSlNo = int.Parse(dt.Rows[dt.Rows.Count - 1]["STT"].ToString());
                maxSlNo = 1;
                foreach (DataRow dtRow in dt.Rows)
                {
                    dtRow["STT"] = maxSlNo;
                    maxSlNo++;
                }

                dt.AcceptChanges();
            }
            db.Disconnect();
            return dt;
        }
        public bool XoaTaiLieuYeuCauMoi(string tenTaiLieuYeuCau)
        {
            string strSql = "usp_XoaYeuCauTaiLieuMoi";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            try
            {
                DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@TenTLYeuCau", Value = tenTaiLieuYeuCau });
                DBConnect.Disconnect();
                return true;
            }
            catch
            {
                DBConnect.Disconnect();
                return false;
            }
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

            string strSql1 = "exec usp_SearchTaiLieuTheoLoai N'" + loaisach + "'";
            DBConnect db = new DBConnect();
            db.Connect();
            DataTable gettl = db.Select(CommandType.Text, strSql1);
            db.Disconnect();
            return gettl;


        }

        public DataTable getTheoMa()
        {
            string strSql1 = "exec usp_SearchTaiLieuTheoMa N'" + masach + "'";
            DBConnect db = new DBConnect();
            db.Connect();
            DataTable getma = db.Select(CommandType.Text, strSql1);
            db.Disconnect();
            return getma;


        }

        public DataTable getTheoTen()
        {
            string strSql1 = "exec usp_SearchTaiLieuTheoTen N'" + tensach + "'";
            DBConnect db = new DBConnect();
            db.Connect();
            DataTable getten = db.Select(CommandType.Text, strSql1);
            db.Disconnect();
            return getten;


        }

        public string TimMaTLTiepTheo()
        {
            string strSql1 = "usp_TimMaTLTiepTheo";
            DBConnect DBConnect1 = new DBConnect();
            DBConnect1.Connect();
            SqlParameter p = new SqlParameter("@MaTaiLieu", SqlDbType.VarChar, 100);
            p.Direction = ParameterDirection.Output;
            DBConnect1.ExecuteNonQuery(CommandType.StoredProcedure, strSql1, p);
            DBConnect1.Disconnect();
            return p.Value.ToString();
        }
        public void ThemTaiLieuMoi(DTO_TaiLieu dTO_TL)
        {
            string strSql = "usp_InsertTaiLieu";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();

            DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@TenTaiLieu", Value = dTO_TL._tenTL },
            new SqlParameter { ParameterName = "@LoaiTaiLieu", Value = dTO_TL._loaiTL },
            new SqlParameter { ParameterName = "@SoLuong", Value = dTO_TL._soLuong });
            DBConnect.Disconnect();
        }
        public DataTable xemChiTietTaiLieu(string maTL)
        {
            string strSql = "exec usp_SearchTaiLieuTheoMa " + maTL;
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            DBConnect.Disconnect();
            return dt;
        }
        public bool XoaChiTietTaiLieu(string maTL)
        {

            string strSql = "usp_DeleteTaiLieu";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();
            try
            {
                SqlParameter p1 = new SqlParameter("@result", SqlDbType.Int);
                p1.Direction = ParameterDirection.Output;
                DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaTaiLieu", Value = maTL }, p1);
                DBConnect.Disconnect();
                if (p1.Value.ToString() == "1")
                    return true;
                return false;
            }
            catch
            {
                return false;
            }
        }

        public void LuuChiTietTaiLieu(DTO_TaiLieu dTO_TL)
        {
            string strSql = "usp_UpdateTaiLieu";
            DBConnect DBConnect = new DBConnect();
            DBConnect.Connect();

            DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@MaTaiLieu", Value = dTO_TL._maTL },
            new SqlParameter { ParameterName = "@TenTaiLieu", Value = dTO_TL._tenTL },
            new SqlParameter { ParameterName = "@LoaiTaiLieu", Value = dTO_TL._loaiTL },
            new SqlParameter { ParameterName = "@SoLuong", Value = dTO_TL._soLuong });
            DBConnect.Disconnect();

        }
    }

}
