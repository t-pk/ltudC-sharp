using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Windows.Forms;

namespace LTQLUD1_DACK_Nhom15
{

    class Provider
    {
        static string nameCS = "sqlPC_QLThuVien";
        static string ConnectionString = ConfigurationManager.ConnectionStrings[nameCS].ConnectionString;
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
                MessageBox.Show("Lỗi : " +ex.ToString() );
                throw ex;
            }
        }
    }
}
