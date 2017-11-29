using System;
using System.Collections.Generic;
using System.ComponentModel;
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
    public partial class FrmDangKy : Form
    {
        public FrmDangKy()
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
            Application.Exit();
        }

        private void btnDangKy_Click(object sender, EventArgs e)
        {
            if (txtHoTenNVDangKy.Text != "" && txtUserNVDangKy.Text != "" && txtPassNVDangKy.Text != "")
            {
                string hotennv = txtHoTenNVDangKy.Text;
                string user = txtUserNVDangKy.Text;
                string pass = txtPassNVDangKy.Text;
                string loai = "";
                string ca = "";
                if (rdAdminDangKy.Checked == true)
                    loai = "AD";
                else if (rdThuThuDangKy.Checked == true)
                {
                    loai = "TT";
                    ca = txtCaNVDangKy.Text;
                }


                string strSql = "usp_ThemNhanVien";
                Provider provider = new Provider();
                provider.Connect();

                provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@CaTruc", Value = ca },
                new SqlParameter { ParameterName = "@TenDangNhap", Value = user },
                new SqlParameter { ParameterName = "@HoTen", Value = hotennv },
                new SqlParameter { ParameterName = "@MatKhau", Value = pass },
                new SqlParameter { ParameterName = "@LoaiNV", Value = loai });
                provider.Disconnect();
                MessageBox.Show("Đăng Ký Nhân Viên Thành Công!!!");
                FrmDangNhap frmDangNhap = new FrmDangNhap();
                this.Hide();
                frmDangNhap.Show();
            }
            else
            {
                MessageBox.Show("Xin hãy nhập đầy đủ");
            }
           
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            lblCaTrucNVDangKy.Hide();
            txtCaNVDangKy.Hide();
            txtMaNVDangKy.ReadOnly = true;

            string strSql1 = "usp_TimMaNVTiepTheo";
            Provider provider1 = new Provider();
            provider1.Connect();

            SqlParameter p = new SqlParameter("@MaNV", SqlDbType.VarChar, 100);
            p.Direction = ParameterDirection.Output;

            provider1.ExecuteNonQuery(CommandType.StoredProcedure, strSql1, p);

            provider1.Disconnect();
            txtMaNVDangKy.Text = p.Value.ToString();
        }

        private void rdThuThuDangKy_CheckedChanged(object sender, EventArgs e)
        {
            lblCaTrucNVDangKy.Show();
            txtCaNVDangKy.Show();
        }

        private void rdAdminDangKy_CheckedChanged(object sender, EventArgs e)
        {
            lblCaTrucNVDangKy.Hide();
            txtCaNVDangKy.Hide();
        }
    }
}
