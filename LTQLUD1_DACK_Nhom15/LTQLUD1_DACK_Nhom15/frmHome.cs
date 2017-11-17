using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

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

        private void button4_Click(object sender, EventArgs e)
        {
            panelQLNhanVien.Visible = false;           
            panelQLSach.Visible = false;
            panelTraCuu.Visible = false;
            this.panelDocGia.Location = new System.Drawing.Point(220, 118);
            panelDocGia.Visible = true;
        }

        private void lbTittle_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Maximized;
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


        private void UserName(string text)
        {
            userName.Text = text;
        }

        public void funData(TextBox txtForm1)
        {
            userName.Text = txtForm1.Text;
        }

        private void label25_Click(object sender, EventArgs e)
        {

        }

        private void Form1_MouseUp(object sender, MouseEventArgs e)
        {
            drag = false;
        }

        private void btnNhanVien_Click(object sender, EventArgs e)
        {
            panelQLNhanVien.Visible = true;
            if(panelQLNhanVien.Visible == true)
            {
                string strSql = "exec usp_XemDocGia";

                Provider provider = new Provider();
                provider.Connect();
                DataTable dt = provider.Select(CommandType.Text, strSql);
                dgvDSDG.DataSource = dt;

                provider.Disconnect();
            }
            this.panelQLNhanVien.Location = new System.Drawing.Point(220, 118);

            panelQLSach.Visible = false;
            panelDocGia.Visible = false;
            panelTraCuu.Visible = false;
        }

        private void btnDangKyDocGia_Click(object sender, EventArgs e)
        {
            string tendocgia = txtTenDocGiaDangKy.Text;
            string email = txtEmailDocGiaDangKy.Text;
            string diachi = txtDiaChiDocGiaDangKy.Text;
            string sdt = txtSDTDocGiaDangKy.Text;
            string cmnd = "", cbnv = "", mssv = "";
            string loai = "";
            if (rdSinhVien.Checked == true)
            {
                mssv = txtMSSVDocGiaDangKy.Text;
                loai = "SinhVien";
                txtCBNVDocGiaDangKy.ReadOnly = true;
                txtCMNDDocGiaDangKy.ReadOnly = true;

            }
            //if (rdCBNV.Checked == true)
            //{
            //    mssv = txtCBNVDocGiaDangKy.Text;
            //    loai = "CBNV";
            //    txtMSSVDocGiaDangKy.ReadOnly = true;
            //    txtCMNDDocGiaDangKy.ReadOnly = true;
            //}
            //if (rdKhac.Checked == true)
            //{
            //    mssv = txtCMNDDocGiaDangKy.Text;
            //    loai = "Khac";
            //    txtCBNVDocGiaDangKy.ReadOnly = true;
            //    txtMSSVDocGiaDangKy.ReadOnly = true;
            //}
            //string strSql = "usp_AddUser";
            //Provider provider = new Provider();
            //provider.Connect();

            //provider.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
            //new SqlParameter { ParameterName = "@username", Value = username },
            //new SqlParameter { ParameterName = "@email", Value = email },
            //new SqlParameter { ParameterName = "@password", Value = password });
            //provider.Disconnect();
        }

    }
}
