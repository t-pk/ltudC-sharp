﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Windows.Forms;

namespace DAL_QuanLy
{
    public class DBConnect
    {
        // chuỗi kết nối không sử dụng proc 
        protected SqlConnection _conn = new SqlConnection(@"Server=NGUYENDUYQUYET\SQLEXPRESS; Database=QL_thuvien; Trusted_Connection=True;");
        // chuỗi kết nối có sử dụng proc
        static String ConnectionString = @"Server=NGUYENDUYQUYET\SQLEXPRESS; Database=QL_thuvien; Trusted_Connection=True;";
        SqlConnection Connection;

        public void Connect()
        {
            try
            {
                if (Connection == null)
                    Connection = new SqlConnection(ConnectionString);
                if (Connection.State != ConnectionState.Closed)
                    Connection.Close();
                Connection.Open();
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi : " + ex.ToString());
                throw ex;
            }
        }
        public void Disconnect()
        {
            if (Connection != null && ConnectionState.Open == Connection.State)
            {
                Connection.Close();
            }
        }

        public int ExecuteNonQuery(CommandType cmdType, string strSql)
        {
            try
            {
                SqlCommand command = Connection.CreateCommand();
                command.CommandText = strSql;
                command.CommandType = cmdType;

                int nRow = command.ExecuteNonQuery();
                return nRow;
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi : " + ex.ToString());
                throw ex;
            }
        }

        public int ExecuteNonQuery(CommandType cmdType, string strSql, params SqlParameter[] parameters)
        {
            try
            {
                SqlCommand command = Connection.CreateCommand();
                command.CommandText = strSql;
                command.CommandType = cmdType;
                if (parameters != null && parameters.Length > 0)
                    command.Parameters.AddRange(parameters);

                int nRow = command.ExecuteNonQuery();
                return nRow;
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi : " + ex.ToString());
                throw ex;
            }
        }

        public SqlDataReader GetReader(CommandType cmdType, String strSql)
        {
            try
            {
                SqlCommand command = Connection.CreateCommand();
                command.CommandText = strSql;
                command.CommandType = cmdType;
                return command.ExecuteReader();
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi : " + ex.ToString());
                throw ex;
            }
        }
        public DataTable Select(CommandType cmdType, String strSql)
        {
            try
            {
                SqlCommand command = Connection.CreateCommand();
                command.CommandText = strSql;
                command.CommandType = cmdType;
                SqlDataAdapter da = new SqlDataAdapter(command);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public DataTable Select(CommandType cmdType, string strSql,
            params SqlParameter[] parameters)
        {
            try
            {
                SqlCommand command = Connection.CreateCommand();
                command.CommandText = strSql;
                command.CommandType = cmdType;
                if (parameters != null && parameters.Length > 0)
                    command.Parameters.AddRange(parameters);
                SqlDataAdapter da = new SqlDataAdapter(command);
                DataTable dt = new DataTable();
                da.Fill(dt);

                return dt;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }


    }
}
