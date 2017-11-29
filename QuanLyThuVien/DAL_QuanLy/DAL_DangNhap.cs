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
        
      

















        /// <summary>
        /// Get toàn bộ thành viên
        /// </summary>
        /// <returns></returns>
        public DataTable getThanhVien()
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM [QL_thuvien].[dbo].[NHAN VIEN]", _conn);
            DataTable dtThanhvien = new DataTable();
            da.Fill(dtThanhvien);
            return dtThanhvien;
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

        /// <summary>
        /// Thêm thành viên
        /// </summary>
        /// <param name="tv"></param>
        /// <returns></returns>
        public bool themThanhVien(DTO_ThanhVien tv)
        {
            try
            {
                // Ket noi
                _conn.Open();

                // Query string - vì mình để TV_ID là identity (giá trị tự tăng dần) nên ko cần fải insert ID
                string SQL = string.Format("INSERT INTO THANHVIEN(TV_NAME, TV_PHONE, TV_EMAIL) VALUES ('{0}', '{1}', '{2}')", tv.THANHVIEN_NAME, tv.THANHVIEN_PHONE, tv.THANHVIEN_EMAIL);

                // Command (mặc định command type = text nên chúng ta khỏi fải làm gì nhiều).
                SqlCommand cmd = new SqlCommand(SQL, _conn);

                // Query và kiểm tra
                if (cmd.ExecuteNonQuery() > 0)
                    return true;

            }
            catch (Exception e)
            {

            }
            finally
            {
                // Dong ket noi
                _conn.Close();
            }

            return false;
        }

        // hàm đọc proc thêm nhân viên
        public bool themNhanVien(DTO_ThanhVien tv)
        {
            try
            {
                // Ket noi
                _conn.Open();

                // Query string - vì mình để TV_ID là identity (giá trị tự tăng dần) nên ko cần fải insert ID
                string SQL = string.Format("INSERT INTO THANHVIEN(TV_NAME, TV_PHONE, TV_EMAIL) VALUES ('{0}', '{1}', '{2}')", tv.THANHVIEN_NAME, tv.THANHVIEN_PHONE, tv.THANHVIEN_EMAIL);

                // Command (mặc định command type = text nên chúng ta khỏi fải làm gì nhiều).
                SqlCommand cmd = new SqlCommand(SQL, _conn);

                // Query và kiểm tra
                if (cmd.ExecuteNonQuery() > 0)
                    return true;

            }
            catch (Exception e)
            {

            }
            finally
            {
                // Dong ket noi
                _conn.Close();
            }

            return false;
        }

        /// <summary>
        /// Sửa thành viên
        /// </summary>
        /// <param name="tv"></param>
        /// <returns></returns>
        public bool suaThanhVien(DTO_ThanhVien tv)
        {
            try
            {
                // Ket noi
                _conn.Open();

                // Query string
                string SQL = string.Format("UPDATE THANHVIEN SET TV_NAME = '{0}', TV_PHONE = '{1}', TV_EMAIL = '{2}' WHERE TV_ID = {3}", tv.THANHVIEN_NAME, tv.THANHVIEN_PHONE, tv.THANHVIEN_EMAIL, tv.THANHVIEN_ID);

                // Command (mặc định command type = text nên chúng ta khỏi fải làm gì nhiều).
                SqlCommand cmd = new SqlCommand(SQL, _conn);

                // Query và kiểm tra
                if (cmd.ExecuteNonQuery() > 0)
                    return true;

            }
            catch (Exception e)
            {

            }
            finally
            {
                // Dong ket noi
                _conn.Close();
            }

            return false;
        }

        /// <summary>
        /// Xóa thành viên
        /// </summary>
        /// <param name="tv"></param>
        /// <returns></returns>
        public bool xoaThanhVien(int TV_ID)
        {
            try
            {
                // Ket noi
                _conn.Open();

                // Query string - vì xóa chỉ cần ID nên chúng ta ko cần 1 DTO, ID là đủ
                string SQL = string.Format("DELETE FROM THANHVIEN WHERE TV_ID = {0})", TV_ID);

                // Command (mặc định command type = text nên chúng ta khỏi fải làm gì nhiều).
                SqlCommand cmd = new SqlCommand(SQL, _conn);

                // Query và kiểm tra
                if (cmd.ExecuteNonQuery() > 0)
                    return true;

            }
            catch (Exception e)
            {

            }
            finally
            {
                // Dong ket noi
                _conn.Close();
            }

            return false;
        }
    }
}
