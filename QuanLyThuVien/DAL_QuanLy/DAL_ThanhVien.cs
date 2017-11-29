using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;

namespace DAL_QuanLy
{
    public class DAL_ThanhVien : DBConnect
    {
       
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
