using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data;
using System.Data.SqlClient;

namespace LTQLUD1_DACK_Nhom15
{
    public partial class frmHome : Form
    {
        public frmHome()
        {
            InitializeComponent();
            this.StartPosition = FormStartPosition.CenterScreen;
            setVisiblePannel();
            Add_IconTab();
        }
        private void tab_MouseClick(object sender, MouseEventArgs e)
        {
           
        }
       
        private void tab_DrawItem(object sender, DrawItemEventArgs e)
        {
            //e.DrawBackground();
            //if (e.Index == tbcDocGia.SelectedIndex)
            //{
            //    e.Graphics.DrawString(tbcDocGia.TabPages[e.Index].Text,
            //        new Font(tbcDocGia.Font, FontStyle.Bold),
            //        Brushes.Red,
            //        new PointF(e.Bounds.X + 3, e.Bounds.Y + 3));
            //}
            //else
            //{
            //    e.Graphics.DrawString(tbcDocGia.TabPages[e.Index].Text,
            //        tbcDocGia.Font,
            //        Brushes.Black,
            //        new PointF(e.Bounds.X + 3, e.Bounds.Y + 3));
            //}

            // Draw the background of the ListBox control for each item.
     

        }

        public void funData(TextBox txtForm1)
        {
            userName.Text = txtForm1.Text;
        }

        void Add_IconTab()
        {
            tbcDocGia.Dock = DockStyle.Fill;
            tbcDocGia.ImageList = imageList1;
            tbcDocGia.TabPages[0].ImageIndex = 0;
            tbcDocGia.TabPages[1].ImageIndex = 1;
            tbcDocGia.TabPages[2].ImageIndex = 2;
            tbcDocGia.TabPages[3].ImageIndex = 3;


            tbcQuanLiSach.Dock = DockStyle.Fill;
            tbcQuanLiSach.ImageList = imageList2;
            tbcQuanLiSach.TabPages[0].ImageIndex = 0;
            tbcQuanLiSach.TabPages[1].ImageIndex = 1;
            tbcQuanLiSach.TabPages[2].ImageIndex = 2;

            tbcQuanLiNV.Dock = DockStyle.Fill;
            tbcQuanLiNV.ImageList = imageList3;
            tbcQuanLiNV.TabPages[0].ImageIndex = 0;
            tbcQuanLiNV.TabPages[1].ImageIndex = 1;
            tbcQuanLiNV.TabPages[2].ImageIndex = 2;

        }
        private void tab_MouseMove(object sender, MouseEventArgs e)
        {
            Rectangle mouseRect = new Rectangle(e.X, e.Y, 1, 1);
            for (int i = 0; i < tbcDocGia.TabCount; i++)
            {
                if (tbcDocGia.GetTabRect(i).IntersectsWith(mouseRect))
                {
                    tbcDocGia.SelectedIndex = i;
                    break;
                }
            }
        }
        void setVisiblePannel()
        {
            panelQLNhanVien.Visible = false;
            panelDocGia.Visible = false;
            panelTraCuu.Visible = false;
            this.panelQLSach.Location = new System.Drawing.Point(220, 118);
            panelQLSach.Visible = true;
            panelQLSach.Size = new Size(900, 447);


        }
        private bool drag = false;
        private Point dragCursor, dragForm;

        public Font Arial { get; private set; }

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

        private void button3_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
            Application.Exit();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            panelQLNhanVien.Visible = false;
            panelQLSach.Visible = false;
            panelDocGia.Visible = false;
            this.panelTraCuu.Location = new System.Drawing.Point(220, 118);
            panelTraCuu.Visible = true;
        }

        private void btnDocGia_Click(object sender, EventArgs e)
        {
            txtMSCBDG.Hide();
            txtCMNDDG.Hide();
            lblCMNDangKy.Hide();
            lblMSCBDangKy.Hide();
            txtMSSVDG.Hide();
            lblMSSVDangKy.Hide();


            txtMSSVCapNhat.Hide();
            lblMSSVCapNhat.Hide();
            txtCMNDCapNhat.Hide();
            txtMSCBCapNhat.Hide();
            lblCMNDCapNhat.Hide();
            lblMSCBCapNhat.Hide();


            panelQLNhanVien.Visible = false;           
            panelQLSach.Visible = false;
            panelTraCuu.Visible = false;
            this.panelDocGia.Location = new System.Drawing.Point(220, 118);
            panelDocGia.Visible = true;
            if (panelDocGia.Visible == true)
            {
                string strSql = "exec usp_XemDocGia";

                Provider provider = new Provider();
                provider.Connect();
                DataTable dt = provider.Select(CommandType.Text, strSql);
                dgvDocGia.DataSource = dt;

                provider.Disconnect();
            }
        }

        private void lbTittle_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Maximized;
        }

        private void button7_Click(object sender, EventArgs e)
        {
            panelQLNhanVien.Visible = true;
            this.panelQLNhanVien.Location = new System.Drawing.Point(220, 118);
            panelQLSach.Visible = false;
            panelDocGia.Visible = false;
            panelTraCuu.Visible = false;

        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            panelQLNhanVien.Visible = false;
            this.panelQLSach.Location = new System.Drawing.Point(220, 118);
            panelQLSach.Visible = true;
            panelDocGia.Visible = false;

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox6_TextChanged(object sender, EventArgs e)
        {

        }

        private void frmHome_Load(object sender, EventArgs e)
        {

        }

        private void label25_Click(object sender, EventArgs e)
        {

        }

        private void Form1_MouseUp(object sender, MouseEventArgs e)
        {
            drag = false;
        }

        private void rdSinhVien_CheckedChanged(object sender, EventArgs e)
        {
            txtMSSVDG.Show();
            lblMSSVDangKy.Show();
            txtMSCBDG.Hide();
            txtCMNDDG.Hide();
            lblCMNDangKy.Hide();
            lblMSCBDangKy.Hide();
        }

        private void rdCanBo_CheckedChanged(object sender, EventArgs e)
        {
            txtMSCBDG.Show();
            lblMSCBDangKy.Show();
            txtMSSVDG.Hide();
            txtCMNDDG.Hide();
            lblMSSVDangKy.Hide();
            lblCMNDangKy.Hide();
        }

        private void rdKhac_CheckedChanged(object sender, EventArgs e)
        {
            txtCMNDDG.Show();
            lblCMNDangKy.Show();
            txtMSSVDG.Hide();
            txtMSCBDG.Hide();
            lblMSSVDangKy.Hide();
            lblMSCBDangKy.Hide();
        }

        private void btnDangKyDocGia_Click(object sender, EventArgs e)
        {
            try
            {
                string tendocgia = txtTenDG.Text;
                string ngaysinh = txtNgaySinhDG.Text;
                string diachi = txtDiaChiDG.Text;
                string sdt = txtSDTDG.Text;
                string email = txtEmailDG.Text;
                string cmnd = txtCMNDDG.Text;
                string mscb = txtMSCBDG.Text;
                string mssv = txtMSSVDG.Text;
                string loai;
                if (rdSinhVien.Checked == true)
                    loai = "SV";
                else if (rdCanBo.Checked == true)
                    loai = "CBNV";
                else
                    loai = "K";

                string strSql = "usp_ThemDocGia";
                Provider provider = new Provider();
                provider.Connect();

                provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@TenDG", Value = tendocgia },
                new SqlParameter { ParameterName = "@NgaySinhDG", Value = ngaysinh },
                new SqlParameter { ParameterName = "@DiaChiDG", Value = diachi },
                new SqlParameter { ParameterName = "@SDTDG", Value = sdt },
                new SqlParameter { ParameterName = "@EmailDG", Value = email },
                new SqlParameter { ParameterName = "@CMNDDG", Value = cmnd },
                new SqlParameter { ParameterName = "@MSSVDG", Value = mssv },
                new SqlParameter { ParameterName = "@MCBDG", Value = mscb },
                new SqlParameter { ParameterName = "@LoaiDG", Value = loai });
                provider.Disconnect();
                MessageBox.Show("Đăng ký Độc Giả Thành Công!!!");
            }
            catch(SqlException ex)
            {
                MessageBox.Show("Lỗi");
                throw ex;
            }
            txtTenDG.Text = null;
            txtNgaySinhDG.Text = null;
            txtDiaChiDG.Text = null;
            txtSDTDG.Text = null;
            txtEmailDG.Text = null;
            txtCMNDDG.Text = null;
            txtMSCBDG.Text = null;
            txtMSSVDG.Text = null;
            rdSinhVien.Checked = false;
            rdCanBo.Checked = false;
            rdKhac.Checked = false;
            if (panelDocGia.Visible == true)
            {
                string strSql = "exec usp_XemDocGia";

                Provider provider = new Provider();
                provider.Connect();
                DataTable dt = provider.Select(CommandType.Text, strSql);
                dgvDocGia.DataSource = dt;

                provider.Disconnect();
            }
        }

        private void btnCapNhatDocGia_Click(object sender, EventArgs e)
        {
            try
            {
                string madocgia = txtMaCapNhat.Text;
                string tendocgia = txtTenCapNhat.Text;
                string ngaysinh = txtNgaySinhCapNhat.Text;
                string diachi = txtDiaChiCapNhat.Text;
                string sdt = txtSDTCapNhat.Text;
                string email = txtEmailCapNhat.Text;
                string cmnd = txtCMNDCapNhat.Text;
                string mscb = txtMSCBCapNhat.Text;
                string mssv = txtMSSVCapNhat.Text;
                string loai;
                if (rdSinhVienCapNhat.Checked == true)
                    loai = "SV";
                else if (rdCanBoCapNhat.Checked == true)
                    loai = "CBNV";
                else
                    loai = "K";

                string strSql = "usp_CapNhatDocGia";
                Provider provider = new Provider();
                provider.Connect();

                provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaDG", Value = madocgia },
                new SqlParameter { ParameterName = "@TenDG", Value = tendocgia },
                new SqlParameter { ParameterName = "@NgaySinhDG", Value = ngaysinh },
                new SqlParameter { ParameterName = "@DiaChiDG", Value = diachi },
                new SqlParameter { ParameterName = "@SDTDG", Value = sdt },
                new SqlParameter { ParameterName = "@EmailDG", Value = email },
                new SqlParameter { ParameterName = "@CMNDDG", Value = cmnd },
                new SqlParameter { ParameterName = "@MSSVDG", Value = mssv },
                new SqlParameter { ParameterName = "@MCBDG", Value = mscb },
                new SqlParameter { ParameterName = "@LoaiDG", Value = loai });
                provider.Disconnect();
                MessageBox.Show("Cập Nhật Độc Giả Thành Công!!!");
            }
            catch(SqlException ex)
            {
                MessageBox.Show("Lỗi");
                throw ex;
            }
            txtMaCapNhat.Text = null;
            txtTenCapNhat.Text = null;
            txtNgaySinhCapNhat.Text = null;
            txtDiaChiCapNhat.Text = null;
            txtSDTCapNhat.Text = null;
            txtEmailCapNhat.Text = null;
            txtCMNDCapNhat.Text = null;
            txtMSCBCapNhat.Text = null;
            txtMSSVCapNhat.Text = null;
            rdSinhVienCapNhat.Checked = false;
            rdCanBoCapNhat.Checked = false;
            rdKhacCapNhat.Checked = false;
            if (panelDocGia.Visible == true)
            {
                string strSql = "exec usp_XemDocGia";

                Provider provider = new Provider();
                provider.Connect();
                DataTable dt = provider.Select(CommandType.Text, strSql);
                dgvDocGia.DataSource = dt;

                provider.Disconnect();
            }
        }

        private void rdSinhVienCapNhat_CheckedChanged(object sender, EventArgs e)
        {
            txtMSSVCapNhat.Show();
            lblMSSVCapNhat.Show();
            txtCMNDCapNhat.Hide();
            txtMSCBCapNhat.Hide();
            lblCMNDCapNhat.Hide();
            lblMSCBCapNhat.Hide();
        }

        private void rdCanBoCapNhat_CheckedChanged(object sender, EventArgs e)
        {
            txtMSCBCapNhat.Show();
            lblMSCBCapNhat.Show();
            txtMSSVCapNhat.Hide();
            lblMSSVCapNhat.Hide();
            txtCMNDCapNhat.Hide();
            lblCMNDCapNhat.Hide();
        }

        private void rdKhacCapNhat_CheckedChanged(object sender, EventArgs e)
        {
            txtCMNDCapNhat.Show();
            lblCMNDCapNhat.Show();
            txtMSCBCapNhat.Hide();
            lblMSCBCapNhat.Hide();
            txtMSSVCapNhat.Hide();
            lblMSSVCapNhat.Hide();
        }

        private void btnXoaDocGia_Click(object sender, EventArgs e)
        {
            try
            {
                string madocgia = txtMaDocGiaXoa.Text;
                string strSql = "usp_XoaDocGia";
                Provider provider = new Provider();
                provider.Connect();

                provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                new SqlParameter { ParameterName = "@MaDG", Value = madocgia });
                provider.Disconnect();
                MessageBox.Show("Xóa Độc Giả Thành Công");
            }
            catch(SqlException ex)
            {
                MessageBox.Show("Lỗi");
                throw ex;
            }
            txtMaDocGiaXoa.Text = null;
            if (panelDocGia.Visible == true)
            {
                string strSql = "exec usp_XemDocGia";

                Provider provider = new Provider();
                provider.Connect();
                DataTable dt = provider.Select(CommandType.Text, strSql);
                dgvDocGia.DataSource = dt;

                provider.Disconnect();
            }

        }
    }
}
