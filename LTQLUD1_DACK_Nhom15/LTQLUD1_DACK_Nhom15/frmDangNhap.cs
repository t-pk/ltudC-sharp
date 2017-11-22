using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing.Printing;
using System.Data;
using System.Data.SqlClient;



namespace LTQLUD1_DACK_Nhom15
{
    public partial class FrmDangNhap : Form
    {
        public delegate void delPassData(string ten, string quyen);
        public FrmDangNhap()
        {
            InitializeComponent();
            this.WindowState = FormWindowState.Normal;         
            this.StartPosition = FormStartPosition.CenterScreen;

        }
        private bool drag = false;
        private Point dragCursor, dragForm;
        private void Form1_MouseDown(object sender, MouseEventArgs e)
        {
            drag = true;
            dragCursor = Cursor.Position;
            dragForm = this.Location;
        }

        private void Form1_MouseMove(object sender, MouseEventArgs e)
        {
            int wid = SystemInformation.VirtualScreen.Width;
            int hei = SystemInformation.VirtualScreen.Height;
            if (drag)
            {
                // Phải using System.Drawing;
                Point change = Point.Subtract(Cursor.Position, new Size(dragCursor));
                Point newpos = Point.Add(dragForm, new Size(change));
                // QUyết định có cho form chui ra ngoài màn hình không
                if (newpos.X < 0) newpos.X = 0;
                if (newpos.Y < 0) newpos.Y = 0;
                if (newpos.X + this.Width > wid) newpos.X = wid - this.Width;
                if (newpos.Y + this.Height > hei) newpos.Y = hei - this.Height;
                this.Location = newpos;
            }
        }
        private void Form1_MouseUp(object sender, MouseEventArgs e)
        {
            drag = false;
        }

        private void button2_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            string username = txtUSER.Text;
            string password = txtPASS.Text;


            string strSql1 = "usp_LayTenNhanVien";
            Provider provider1 = new Provider();
            provider1.Connect();

            SqlParameter p1 = new SqlParameter("@TenNV", SqlDbType.NVarChar, 100);
            p1.Direction = ParameterDirection.Output;

            provider1.ExecuteNonQuery(CommandType.StoredProcedure, strSql1,
             new SqlParameter { ParameterName = "@UserName", Value = username },
             new SqlParameter { ParameterName = "@Pass", Value = password }, p1);

            provider1.Disconnect();
            string NameUser = p1.Value.ToString();


            string strSql2 = "usp_LayQuyenNhanVien";
            Provider provider2 = new Provider();
            provider2.Connect();

            SqlParameter p2 = new SqlParameter("@QuyenNV", SqlDbType.NVarChar, 100);
            p2.Direction = ParameterDirection.Output;

            provider2.ExecuteNonQuery(CommandType.StoredProcedure, strSql2,
            new SqlParameter { ParameterName = "@UserName", Value = username },
            new SqlParameter { ParameterName = "@Pass", Value = password }, p2);

            provider1.Disconnect();
            string Quyen = p2.Value.ToString();





            string strSql = "usp_Login";
            Provider provider = new Provider();
            provider.Connect();

            SqlParameter p = new SqlParameter("@result", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;

            provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            new SqlParameter { ParameterName = "@username", Value = username },
            new SqlParameter { ParameterName = "@password", Value = password }, p);

            provider.Disconnect();
            if (p.Value.ToString() == "1")
            {
                this.Hide();
                frmHome frHome = new frmHome();
                frHome.Show();

                delPassData del = new delPassData(frHome.funData);
                del(NameUser, Quyen);
            }
            else MessageBox.Show("Tên đăng nhập hoặc mật khẩu không đúng!\n\tVui lòng kiểm tra lại!!!");
        }

        private void btnDangKy_Click(object sender, EventArgs e)
        {
            FrmDangKy frDangKy = new FrmDangKy();
            this.Hide();
            frDangKy.Show();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
       
        }

        private void txtUSER_TextChanged(object sender, EventArgs e)
        {

        }

        private void lbCopyright_Click(object sender, EventArgs e)
        {

        }

        private void txtPASS_TextChanged(object sender, EventArgs e)
        {
            txtPASS.PasswordChar = '*';
        }

        
    }
}
