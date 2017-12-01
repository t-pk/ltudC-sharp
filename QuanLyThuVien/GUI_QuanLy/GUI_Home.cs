using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data;
using System.Data.SqlClient;
using DTO_QuanLy;
using BUS_QuanLy;

namespace GUI_QuanLy
{
    public partial class GUI_Home : Form
    {
        string Quyen = "";
        public GUI_Home()
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

        /*
         * fuction nhận dữ liệu từ Form Đăng Nhập gửi qua (Tên NV, Quyền)
         */
        public void funData(string ten, string quyen)
        {
            userName.Text = ten;
            label1.Text = quyen;
            Quyen = quyen;
            label1.TextAlign = ContentAlignment.MiddleRight;
            userName.TextAlign = ContentAlignment.MiddleRight;
        }
        /*
         * fuction add icon vào các Tab
         */
        void Add_IconTab()
        {
            tbcDocGia.Dock = DockStyle.Fill;
            tbcDocGia.ImageList = imageList1;
            tbcDocGia.TabPages[0].ImageIndex = 0;
            tbcDocGia.TabPages[1].ImageIndex = 1;


            tbcQuanLiSach.Dock = DockStyle.Fill;
            tbcQuanLiSach.ImageList = imageList2;
            tbcQuanLiSach.TabPages[0].ImageIndex = 0;
            tbcQuanLiSach.TabPages[1].ImageIndex = 1;

            tbcQuanLiNV.Dock = DockStyle.Fill;
            tbcQuanLiNV.ImageList = imageList3;
            tbcQuanLiNV.TabPages[0].ImageIndex = 0;
            tbcQuanLiNV.TabPages[1].ImageIndex = 1;
            tbcQuanLiNV.TabPages[2].ImageIndex = 2;

        }
        /*
         * fuction chỉ hiện panel chính , ẩn các panel còn lại
         */
        void setVisiblePannel()
        {
            pnThongKe.Visible = false;
            panelQLNhanVien.Visible = false;
            panelDocGia.Visible = false;
            panelTraCuu.Visible = false;
            this.panelQLSach.Location = new System.Drawing.Point(220, 118);
            panelQLSach.Visible = true;
            panelQLSach.Size = new Size(900, 447);


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

        /*
         * fuction : Form1_MouseDown(), Form1_MouseMove()
         * Di chuyển form trên màn hình
         */
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

        /* 
         * Kết thúc di chuyển form
         */

        /*
        * fuction : thu nhỏ form và đóng ứng dụng
        * Di chuyển form trên màn hình
        */
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
            pnThongKe.Visible = false;
        }

        private void btnDocGia_Click(object sender, EventArgs e)
        {
            //txtMSCBDG.Hide();
            //lblMSCBDangKy.Hide();
            //txtMSSVDG.Hide();
            //lblMSSVDangKy.Hide();

            //lblMaDGSearch.Hide();
            //lblDinhDanhSearch.Hide();
            //lblHoTenSearch.Hide();
            //txtSearchDG.Hide();
            pnThongKe.Visible = false;
            rdMaDGSearch.Checked = true;

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
            pnThongKe.Visible = false;

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox6_TextChanged(object sender, EventArgs e)
        {

        }

        private void frmHome_Load(object sender, EventArgs e)
        {

            txtMaTL.Enabled = false;
            btnChinhSuaTL.Hide();
            btnLuuTL.Hide();
            btnHuyTL.Hide();
            btnXemChiTietTL.Hide();
            btnXoaTL.Hide();
            btnLapPhieuMuonTL.Hide();
            btnYeuCauTL.Hide();


            txtSearchTaiLieu.Hide();
            lblTenTaiLieu.Hide();
            lblMaTaiLieu.Hide();
            txtSearchTaiLieu.ReadOnly = false;
            btnXemChiTiet.Hide();
            btnXoaDocGia.Hide();
            btnLapPhieMuon.Hide();
            btnLapPhieuCanhCao.Hide();
            btnLapPhieuTra.Hide();

            cbxLoaiTaiLieu.Items.Add("SÁCH");
            cbxLoaiTaiLieu.Items.Add("CÔNG TRÌNH NGHIÊN CỨU");
            cbxLoaiTaiLieu.Items.Add("TẠP CHÍ");
            cbxLoaiTaiLieu.Items.Add("LUẬN VĂN");
            cbxLoaiTaiLieu.Items.Add("HỘI NGHỊ-BÁO CÁO");

            //string strSql1 = "usp_TimMaTLTiepTheo";
            //DBConnect DBConnect1 = new DBConnect();
            //DBConnect1.Connect();

            //SqlParameter p1 = new SqlParameter("@MaTaiLieu", SqlDbType.VarChar, 100);
            //p1.Direction = ParameterDirection.Output;

            //DBConnect1.ExecuteNonQuery(CommandType.StoredProcedure, strSql1, p1);

            //DBConnect1.Disconnect();
            //txtMaTL.Text = p1.Value.ToString();

            //--------------------------------------------------------------------------------------------


            txtMaDG.Enabled = false;
            cbxDinhDanh.Hide();

            this.cbxDinhDanh.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;

            cbxDinhDanh.Items.Add("CMND");
            cbxDinhDanh.Items.Add("MSSV");
            cbxDinhDanh.Items.Add("MCB");


            //string strSql2 = "usp_TimMaDGTiepTheo";
            //DBConnect DBConnect2 = new DBConnect();
            //DBConnect2.Connect();

            //SqlParameter p2 = new SqlParameter("@MaDocGia", SqlDbType.VarChar, 100);
            //p2.Direction = ParameterDirection.Output;

            //DBConnect2.ExecuteNonQuery(CommandType.StoredProcedure, strSql2, p2);

            //DBConnect2.Disconnect();
            //txtMaDG.Text = p2.Value.ToString();

            btnLuu.Hide();
            btnHuy.Hide();
            btnChinhSua.Hide();
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
            lblMSCBDangKy.Hide();
        }

        private void rdCanBo_CheckedChanged(object sender, EventArgs e)
        {
            txtMSCBDG.Show();
            lblMSCBDangKy.Show();
            txtMSSVDG.Hide();
            txtCMNDDG.Hide();
            lblMSSVDangKy.Hide();
        }

        private void rdKhac_CheckedChanged(object sender, EventArgs e)
        {
            txtCMNDDG.Show();
            txtMSSVDG.Hide();
            txtMSCBDG.Hide();
            lblMSSVDangKy.Hide();
            lblMSCBDangKy.Hide();
        }

        private void btnDangKyDocGia_Click(object sender, EventArgs e)
        {
            try
            {
                txtMaDG.Enabled = false;

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

                //string strSql = "usp_ThemDocGia";
                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();

                //DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                //new SqlParameter { ParameterName = "@TenDG", Value = tendocgia },
                //new SqlParameter { ParameterName = "@NgaySinhDG", Value = ngaysinh },
                //new SqlParameter { ParameterName = "@DiaChiDG", Value = diachi },
                //new SqlParameter { ParameterName = "@SDTDG", Value = sdt },
                //new SqlParameter { ParameterName = "@EmailDG", Value = email },
                //new SqlParameter { ParameterName = "@CMNDDG", Value = cmnd },
                //new SqlParameter { ParameterName = "@MSSVDG", Value = mssv },
                //new SqlParameter { ParameterName = "@MCBDG", Value = mscb },
                //new SqlParameter { ParameterName = "@LoaiDG", Value = loai });
                //DBConnect.Disconnect();
                MessageBox.Show("Đăng ký Độc Giả Thành Công!!!");
            }
            catch (SqlException ex)
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
            //string strSql1 = "usp_TimMaDGTiepTheo";
            //DBConnect DBConnect1 = new DBConnect();
            //DBConnect1.Connect();

            //SqlParameter p = new SqlParameter("@MaDocGia", SqlDbType.VarChar, 100);
            //p.Direction = ParameterDirection.Output;

            //DBConnect1.ExecuteNonQuery(CommandType.StoredProcedure, strSql1, p);

            //DBConnect1.Disconnect();
            //txtMaDG.Text = p.Value.ToString();
        }

        private void btnNhanVien_Click(object sender, EventArgs e)
        {
            panelQLNhanVien.Visible = true;
            this.panelQLNhanVien.Location = new System.Drawing.Point(220, 118);
            panelQLSach.Visible = false;
            panelDocGia.Visible = false;
            panelTraCuu.Visible = false;
            pnThongKe.Visible = false;

            if (panelQLNhanVien.Visible == true)
            {
                string strSql = "exec usp_XemNhanVien";

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();
                //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
                //dgvNhanVien.DataSource = dt;
                //dgvNhanVien.ReadOnly = true;

                //dgvNhanVien.Columns[0].HeaderText = "Mã Nhân Viên";
                //dgvNhanVien.Columns[1].HeaderText = "Ca Trực ";
                //dgvNhanVien.Columns[2].HeaderText = "Tên Đăng Nhập";
                //dgvNhanVien.Columns[3].HeaderText = "Mật Khẩu";
                //dgvNhanVien.Columns[4].HeaderText = "Họ Tên";
                //dgvNhanVien.Columns[5].HeaderText = "Login Gần Nhất";
                //dgvNhanVien.Columns[6].HeaderText = "Loại Nhân Viên";

                //DBConnect.Disconnect();
            }
        }

        private void btnCapNhatNhanVien_Click(object sender, EventArgs e)
        {
            if (Quyen == "Admin")
            {
                try
                {
                    string manv = txtMaNVCapNhap.Text;
                    string hotennv = txtHoTenNVCapNhat.Text;
                    string tendangnhapnv = txtTenDangNhapNVCapNhat.Text;
                    string mkhaudangnhapnv = txtMatKhauNVCapNhat.Text;
                    string catruc = txtCaTrucNVCapNhat.Text;
                    string loai = "";
                    if (rdAdminCapNhat.Checked == true)
                        loai = "AD";
                    else if (rdThuThuCapNhat.Checked == true)
                        loai = "TT";

                    //string strSql = "usp_CapNhatNhanVien";
                    //DBConnect DBConnect = new DBConnect();
                    //DBConnect.Connect();

                    //DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                    //new SqlParameter { ParameterName = "@MaNV", Value = manv },
                    //new SqlParameter { ParameterName = "@CaTruc", Value = catruc },
                    //new SqlParameter { ParameterName = "@TenDangNhap", Value = tendangnhapnv },
                    //new SqlParameter { ParameterName = "@MatKhau", Value = mkhaudangnhapnv },
                    //new SqlParameter { ParameterName = "@HoTen", Value = hotennv },
                    //new SqlParameter { ParameterName = "@LoaiNV", Value = loai });
                    //DBConnect.Disconnect();
                    MessageBox.Show("Cập Nhật Nhân Viên Thành Công!!!");
                }
                catch (SqlException ex)
                {
                    MessageBox.Show("Lỗi");
                    throw ex;
                }
                txtMaNVCapNhap.Text = null;
                txtHoTenNVCapNhat.Text = null;
                txtTenDangNhapNVCapNhat.Text = null;
                txtMatKhauNVCapNhat.Text = null;
                txtCaTrucNVCapNhat.Text = null;
                rdAdminCapNhat.Checked = false;
                rdThuThuCapNhat.Checked = false;
                if (panelQLNhanVien.Visible == true)
                {
                    //string strSql = "exec usp_XemNhanVien";

                    //DBConnect DBConnect = new DBConnect();
                    //DBConnect.Connect();
                    //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
                    //dgvNhanVien.DataSource = dt;
                    //dgvNhanVien.ReadOnly = true;
                    //DBConnect.Disconnect();
                }
            }
            else MessageBox.Show("Bạn Không Phải ADMIN, Bạn Không Có Quyền Cập Nhật Nhân Viên !!!");
        }

        private void btnXoaNhanVien_Click(object sender, EventArgs e)
        {
            if (Quyen == "Admin")
            {
                try
                {
                    string manvxoa = txtMaNVXoa.Text;
                    string strSql = "usp_XoaNhanVien";
                    //DBConnect DBConnect = new DBConnect();
                    //DBConnect.Connect();

                    //DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                    //new SqlParameter { ParameterName = "@MaNV", Value = manvxoa });
                    //DBConnect.Disconnect();
                    MessageBox.Show("Xóa Nhân Viên Thành Công");
                }
                catch (SqlException ex)
                {
                    MessageBox.Show("Lỗi");
                    throw ex;
                }
                txtMaNVXoa.Text = null;
                if (panelQLNhanVien.Visible == true)
                {
                    string strSql = "exec usp_XemNhanVien";

                    //DBConnect DBConnect = new DBConnect();
                    //DBConnect.Connect();
                    //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
                    //dgvNhanVien.DataSource = dt;
                    //dgvNhanVien.ReadOnly = true;
                    //DBConnect.Disconnect();
                }
            }
            else MessageBox.Show("Bạn Không Phải ADMIN, Bạn Không Có Quyền Xóa Nhân Viên !!!");
        }

        private void btnSearchDocGia_Click(object sender, EventArgs e)
        {
            btnLuu.Hide();
            btnHuy.Hide();
            btnChinhSua.Hide();

            btnXemChiTiet.Show();
            btnXoaDocGia.Show();
            btnLapPhieMuon.Show();
            btnLapPhieuCanhCao.Show();
            btnLapPhieuTra.Show();

            string select = cbxDinhDanh.GetItemText(this.cbxDinhDanh.SelectedItem);
            if ((rdMaDGSearch.Checked == false && rdMaDinhDanhSearch.Checked == false && rdHoTenSearch.Checked == false) || (rdMaDinhDanhSearch.Checked == true && select == "") || (txtSearchDG.Text == ""))
            {
                MessageBox.Show("Lỗi Rồi Bạn Êi :( \nTìm Kiếm Gì Thì Nhớ Điền Đầy Đủ Nha");
            }
            else
            {
                string strSql = "";
                string Search = txtSearchDG.Text;
                if (rdMaDGSearch.Checked == true)
                {
                    strSql = "exec usp_TimKiemDocGiaTheoMaDocGia " + Search;
                }

                else if (rdMaDinhDanhSearch.Checked == true)
                {
                    if (select == "MSSV")
                    {
                        strSql = "exec usp_TimKiemDocGiaTheoMSSV " + Search;
                    }

                    else if (select == "MSCB")
                    {
                        strSql = "exec usp_TimKiemDocGiaTheoMSCB " + Search;
                    }

                    else if (select == "CMND")
                    {
                        strSql = "exec usp_TimKiemDocGiaTheoCMND " + Search;
                    }
                }
                else if (rdHoTenSearch.Checked == true)
                {
                    strSql = "exec usp_TimKiemDocGiaTheoHoTen '" + Search + "'";
                }

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();
                //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
                //dgvDGSearch.DataSource = dt;
                //dgvDGSearch.ReadOnly = true;
                //DBConnect.Disconnect();
                //dgvDGSearch.Columns[0].Width = 90;
                //dgvDGSearch.Columns[1].Width = 420;
                //dgvDGSearch.Columns[2].Width = 90;
                //dgvDGSearch.Columns[3].Width = 90;
                //dgvDGSearch.Columns[4].Width = 90;
            }

        }

        private void rdMaDGSearch_CheckedChanged(object sender, EventArgs e)
        {
            lblMaDGSearch.Show();
            lblDinhDanhSearch.Hide();
            lblHoTenSearch.Hide();
            txtSearchDG.Show();
            cbxDinhDanh.Hide();
        }

        private void rdMaDinhDanhSearch_CheckedChanged(object sender, EventArgs e)
        {
            lblMaDGSearch.Hide();
            lblDinhDanhSearch.Show();
            lblHoTenSearch.Hide();
            txtSearchDG.Show();
            cbxDinhDanh.Show();
        }

        private void rdHoTenSearch_CheckedChanged(object sender, EventArgs e)
        {
            lblMaDGSearch.Hide();
            lblDinhDanhSearch.Hide();
            lblHoTenSearch.Show();
            txtSearchDG.Show();
            cbxDinhDanh.Hide();
        }

        private void btnXemAllDocGia_Click(object sender, EventArgs e)
        {
            btnLuu.Hide();
            btnHuy.Hide();
            btnChinhSua.Hide();

            btnXemChiTiet.Show();
            btnXoaDocGia.Show();
            btnLapPhieMuon.Show();
            btnLapPhieuCanhCao.Show();
            btnLapPhieuTra.Show();

            //dgvDGSearch.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            //string strSql = "exec usp_TimKiemTatCaDocGia";
            //DBConnect DBConnect = new DBConnect();
            //DBConnect.Connect();
            //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            //dgvDGSearch.DataSource = dt;
            //dgvDGSearch.ReadOnly = true;
            //DBConnect.Disconnect();


            dgvDGSearch.Columns[0].HeaderText = "Mã Độc Giả";
            dgvDGSearch.Columns[1].HeaderText = "Họ Tên ";
            dgvDGSearch.Columns[2].HeaderText = "CMND";
            dgvDGSearch.Columns[3].HeaderText = "Loại Độc Giả";
            dgvDGSearch.Columns[4].HeaderText = "Số Sách Mượn";
        
        }

        private void btnXemChiTiet_Click(object sender, EventArgs e)
        {
            //dgvDGSearch.ReadOnly = false;
            // lấy mã độc giả
            string secondCellValue = dgvDGSearch[0, dgvDGSearch.CurrentRow.Index].Value.ToString();

            //dgvDGSearch.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            string strSql = "exec usp_SearchDocGia " + secondCellValue;
            //DBConnect DBConnect = new DBConnect();
            //DBConnect.Connect();
            //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            //dgvDGSearch.DataSource = dt;
            //DBConnect.Disconnect();

            btnXemChiTiet.Hide();
            btnXoaDocGia.Hide();
            btnLapPhieMuon.Hide();
            btnLapPhieuCanhCao.Hide();
            btnLapPhieuTra.Hide();


            btnHuy.Show();
            btnLuu.Show();
            btnChinhSua.Show();

            //dgvDGSearch.Columns[0].Width = 40;
            //dgvDGSearch.Columns[1].Width = 200;
            //dgvDGSearch.Columns[2].Width = 60;
            //dgvDGSearch.Columns[3].Width = 110;
            //dgvDGSearch.Columns[4].Width = 70;
            //dgvDGSearch.Columns[4].Width = 90;
            //dgvDGSearch.Columns[4].Width = 60;
            //dgvDGSearch.Columns[4].Width = 60;
            //dgvDGSearch.Columns[4].Width = 60;
            //dgvDGSearch.Columns[4].Width = 40;
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            try
            {
                string madocgia = dgvDGSearch[0, dgvDGSearch.CurrentRow.Index].Value.ToString();
                //string madocgia = dgvDGSearch[0, dgvDGSearch.CurrentCell.RowIndex].Value.ToString();
                string hoten = dgvDGSearch[1, dgvDGSearch.CurrentCell.RowIndex].Value.ToString().ToUpper();
                string ngaysinh = dgvDGSearch[2, dgvDGSearch.CurrentCell.RowIndex].Value.ToString();
                string diachi = dgvDGSearch[3, dgvDGSearch.CurrentCell.RowIndex].Value.ToString();
                string sdt = dgvDGSearch[4, dgvDGSearch.CurrentCell.RowIndex].Value.ToString();
                string email = dgvDGSearch[5, dgvDGSearch.CurrentCell.RowIndex].Value.ToString().ToUpper();
                string cmnd = dgvDGSearch[6, dgvDGSearch.CurrentCell.RowIndex].Value.ToString();
                string mssv = dgvDGSearch[7, dgvDGSearch.CurrentCell.RowIndex].Value.ToString();
                string mcb = dgvDGSearch[8, dgvDGSearch.CurrentCell.RowIndex].Value.ToString();
                string loai = dgvDGSearch[9, dgvDGSearch.CurrentCell.RowIndex].Value.ToString();

                string[] ns = ngaysinh.Split(' ');

                string strSql = "usp_CapNhatDocGia";

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();

                //DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                //new SqlParameter { ParameterName = "@MaDG", Value = madocgia },
                //new SqlParameter { ParameterName = "@TenDG", Value = hoten },
                //new SqlParameter { ParameterName = "@NgaySinhDG", Value = ns[0].ToString() },
                //new SqlParameter { ParameterName = "@DiaChiDG", Value = diachi },
                //new SqlParameter { ParameterName = "@SDTDG", Value = sdt },
                //new SqlParameter { ParameterName = "@EmailDG", Value = email },
                //new SqlParameter { ParameterName = "@CMNDDG", Value = cmnd },
                //new SqlParameter { ParameterName = "@MSSVDG", Value = mssv },
                //new SqlParameter { ParameterName = "@MCBDG", Value = mcb },
                //new SqlParameter { ParameterName = "@LoaiDG", Value = loai });
                //DBConnect.Disconnect();
                MessageBox.Show("Cập Nhật Độc Giả Thành Công!!!");
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Cập Nhật Thất Bại :(");
                throw ex;
            }
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            btnXemChiTiet.Hide();
            btnXoaDocGia.Hide();
            btnLapPhieMuon.Hide();
            btnLapPhieuCanhCao.Hide();
            btnLapPhieuTra.Hide();
            btnHuy.Hide();
            btnLuu.Hide();
            btnChinhSua.Hide();

            dgvDGSearch.DataSource = null;
        }

        private void btnChinhSua_Click(object sender, EventArgs e)
        {
            dgvDGSearch.ReadOnly = false;
        }

        private void btnXoaDocGia_Click(object sender, EventArgs e)
        {
            string madocgia = dgvDGSearch[0, dgvDGSearch.CurrentRow.Index].Value.ToString();
            if (MessageBox.Show(string.Format("Xác nhận xóa độc giả {0}", madocgia), "Xác nhận xóa", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                string strSql = "usp_XoaDocGia";

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();

                //DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                //new SqlParameter { ParameterName = "@MaDG", Value = madocgia });
                //DBConnect.Disconnect();
                MessageBox.Show("Xóa Độc Giả Thành Công!!!");
            }
            //dgvDGSearch.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            string strSql1 = "exec usp_TimKiemTatCaDocGia";
            //DBConnect DBConnect1 = new DBConnect();
            //DBConnect1.Connect();
            //DataTable dt1 = DBConnect1.Select(CommandType.Text, strSql1);
            //dgvDGSearch.DataSource = dt1;
            //DBConnect1.Disconnect();

            dgvDGSearch.Columns[0].Width = 40;
            dgvDGSearch.Columns[1].Width = 200;
            dgvDGSearch.Columns[2].Width = 60;
            dgvDGSearch.Columns[3].Width = 110;
            dgvDGSearch.Columns[4].Width = 70;
            dgvDGSearch.Columns[5].Width = 90;
            dgvDGSearch.Columns[6].Width = 60;
            dgvDGSearch.Columns[7].Width = 60;
            dgvDGSearch.Columns[8].Width = 60;
            dgvDGSearch.Columns[9].Width = 40;


          





        }

        private void btnXemTheoLoai_Click(object sender, EventArgs e)
        {
            string loaitl = cbxLoaiTaiLieu.Text;

            string strSql = "exec usp_SearchTaiLieuTheoLoai N'" + loaitl + "'";

            //DBConnect DBConnect = new DBConnect();
            //DBConnect.Connect();
            //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            //dgvSearchTaiLieu.DataSource = dt;
            //dgvSearchTaiLieu.ReadOnly = true;
            //DBConnect.Disconnect();
            dgvSearchTaiLieu.Columns[0].Width = 90;
            dgvSearchTaiLieu.Columns[1].Width = 420;
            dgvSearchTaiLieu.Columns[2].Width = 90;
            dgvSearchTaiLieu.Columns[3].Width = 90;
            dgvSearchTaiLieu.Columns[4].Width = 90;


            btnXemChiTietTL.Show();
            btnXoaTL.Show();
            btnLapPhieuMuonTL.Show();
            btnYeuCauTL.Show();

            btnChinhSuaTL.Hide();
            btnLuuTL.Hide();
            btnHuyTL.Hide();
        }

        private void btnXemAllTaiLieu_Click(object sender, EventArgs e)
        {
            string strSql = "exec usp_XemAllTaiLieu";
            //DBConnect DBConnect = new DBConnect();
            //DBConnect.Connect();
            //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            //dgvSearchTaiLieu.DataSource = dt;
            //dgvSearchTaiLieu.ReadOnly = true;
            //DBConnect.Disconnect();
            dgvSearchTaiLieu.Columns[0].Width = 90;
            dgvSearchTaiLieu.Columns[1].Width = 420;
            dgvSearchTaiLieu.Columns[2].Width = 90;
            dgvSearchTaiLieu.Columns[3].Width = 90;
            dgvSearchTaiLieu.Columns[4].Width = 90;

            dgvSearchTaiLieu.Columns[0].HeaderText = "Mã Tài Liệu";         
            dgvSearchTaiLieu.Columns[1].HeaderText = "Tên Tài Liệu";
            dgvSearchTaiLieu.Columns[2].HeaderText = "Hiện Trạng";
            dgvSearchTaiLieu.Columns[3].HeaderText = "Loại Tài Liệu";
            dgvSearchTaiLieu.Columns[4].HeaderText = "Số Lượng";


            btnXemChiTietTL.Show();
            btnXoaTL.Show();
            btnLapPhieuMuonTL.Show();
            btnYeuCauTL.Show();

            btnChinhSuaTL.Hide();
            btnLuuTL.Hide();
            btnHuyTL.Hide();
        }

        private void btnLapPhieMuon_Click(object sender, EventArgs e)
        {

        }

        private void btnSearchTaiLieu_Click(object sender, EventArgs e)
        {
            if (rdTimTLCoBan.Checked == true)
            {

                string matl = txtSearchTaiLieu.Text;

                string strSql = "exec usp_SearchTaiLieuTheoMa " + matl;

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();
                //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
                //dgvSearchTaiLieu.DataSource = dt;
                //dgvSearchTaiLieu.ReadOnly = true;
                //DBConnect.Disconnect();
                btnXemChiTietTL.Show();
                btnXoaTL.Show();
                btnLapPhieuMuonTL.Show();
                btnYeuCauTL.Show();
            }

            if (rdTimTLNangCao.Checked == true)
            {
                string tentl = txtSearchTaiLieu.Text;

                string strSql = "exec usp_SearchTaiLieuTheoTen " + "N'" + tentl + "'";

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();
                //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
                //dgvSearchTaiLieu.DataSource = dt;
                //dgvSearchTaiLieu.ReadOnly = true;
                //DBConnect.Disconnect();

                btnXemChiTietTL.Show();
                btnXoaTL.Show();
                btnLapPhieuMuonTL.Show();
                btnYeuCauTL.Show();

                btnChinhSuaTL.Hide();
                btnLuuTL.Hide();
                btnHuyTL.Hide();
            }
        }

        private void rdTimTLNangCao_CheckedChanged(object sender, EventArgs e)
        {
            lblMaTaiLieu.Hide();
            lblTenTaiLieu.Show();
            txtSearchTaiLieu.Show();
        }

        private void rdTimTLCoBan_CheckedChanged(object sender, EventArgs e)
        {
            lblMaTaiLieu.Show();
            lblTenTaiLieu.Hide();
            txtSearchTaiLieu.Show();
        }

        private void btnThemTaiLieu_Click(object sender, EventArgs e)
        {
            try
            {
                //string matailieu = txtMaTL.Text;
                string tentailieu = txtTenTL.Text;
                string hientrangtailieu = txtHienTrangTL.Text;
                string loaitailieu = txtLoaiTL.Text;
                string soluongtailieu = txtSoLuongTL.Text;

                string strSql = "usp_InsertTaiLieu";

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();

                //DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                //new SqlParameter { ParameterName = "@TenTaiLieu", Value = tentailieu },
                //new SqlParameter { ParameterName = "@HienTrang", Value = hientrangtailieu },
                //new SqlParameter { ParameterName = "@LoaiTaiLieu", Value = loaitailieu },
                //new SqlParameter { ParameterName = "@SoLuong", Value = soluongtailieu });
                //DBConnect.Disconnect();
                MessageBox.Show("Thêm Tài Liệu Thành Công!!!");
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi");
                throw ex;
            }

            txtTenTL.Text = null;
            txtHienTrangTL.Text = null;
            txtLoaiTL.Text = null;
            txtSoLuongTL.Text = null;

            string strSql1 = "usp_TimMaTLTiepTheo";
            //DBConnect DBConnect1 = new DBConnect();
            //DBConnect1.Connect();

            //SqlParameter p = new SqlParameter("@MaTaiLieu", SqlDbType.VarChar, 100);
            //p.Direction = ParameterDirection.Output;

            //DBConnect1.ExecuteNonQuery(CommandType.StoredProcedure, strSql1, p);

            //DBConnect1.Disconnect();
            //txtMaTL.Text = p.Value.ToString();
        }

        private void btnXemChiTietTL_Click(object sender, EventArgs e)
        {
            string secondCellValue = dgvSearchTaiLieu[0, dgvSearchTaiLieu.CurrentRow.Index].Value.ToString();

            //dgvDGSearch.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            string strSql = "exec usp_SearchTaiLieuTheoMa " + secondCellValue;
            //DBConnect DBConnect = new DBConnect();
            //DBConnect.Connect();
            //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
            //dgvSearchTaiLieu.DataSource = dt;
            //DBConnect.Disconnect();

            btnChinhSuaTL.Show();
            btnLuuTL.Show();
            btnHuyTL.Show();

            btnXemChiTietTL.Hide();
            btnXoaTL.Hide();
            btnLapPhieuMuonTL.Hide();
            btnYeuCauTL.Hide();
        }

        private void btnChinhSuaTL_Click(object sender, EventArgs e)
        {
            dgvSearchTaiLieu.ReadOnly = false;
        }

        private void btnXoaTL_Click(object sender, EventArgs e)
        {
            string matailieu = dgvSearchTaiLieu[0, dgvSearchTaiLieu.CurrentRow.Index].Value.ToString();
            if (MessageBox.Show(string.Format("Xác nhận xóa Tài Liệu {0}", matailieu), "Xác nhận xóa", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                string strSql = "usp_DeleteTaiLieu";

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();

                //DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                //new SqlParameter { ParameterName = "@MaTaiLieu", Value = matailieu });
                //DBConnect.Disconnect();
                MessageBox.Show("Xóa Tài Liệu Thành Công!!!");
            }
            //dgvDGSearch.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            string strSql1 = "exec usp_XemAllTaiLieu";
            //DBConnect DBConnect1 = new DBConnect();
            //DBConnect1.Connect();
            //DataTable dt1 = DBConnect1.Select(CommandType.Text, strSql1);
            //dgvSearchTaiLieu.DataSource = dt1;
            //DBConnect1.Disconnect();
        }

        private void btnLuuTL_Click(object sender, EventArgs e)
        {
            try
            {
                string matailieu = dgvSearchTaiLieu[0, dgvSearchTaiLieu.CurrentRow.Index].Value.ToString();
                string tentailieu = dgvSearchTaiLieu[1, dgvSearchTaiLieu.CurrentCell.RowIndex].Value.ToString().ToUpper();
                string hientrang = dgvSearchTaiLieu[2, dgvSearchTaiLieu.CurrentCell.RowIndex].Value.ToString();
                string loaitailieu = dgvSearchTaiLieu[3, dgvSearchTaiLieu.CurrentCell.RowIndex].Value.ToString();
                string soluong = dgvSearchTaiLieu[4, dgvSearchTaiLieu.CurrentCell.RowIndex].Value.ToString();

                string strSql = "usp_UpdateTaiLieu";
                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();

                //DBConnect.ExecuteNonQuery(CommandType.StoredProcedure, strSql,
                //new SqlParameter { ParameterName = "@MaTaiLieu", Value = matailieu },
                //new SqlParameter { ParameterName = "@TenTaiLieu", Value = tentailieu },
                //new SqlParameter { ParameterName = "@HienTrang", Value = hientrang },
                //new SqlParameter { ParameterName = "@LoaiTaiLieu", Value = loaitailieu },
                //new SqlParameter { ParameterName = "@SoLuong", Value = soluong });

                //DBConnect.Disconnect();
                MessageBox.Show("Cập Nhật Tài Liệu Thành Công!!!");
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Cập Nhật Tài Liệu Thất Bại :(");
                throw ex;
            }
        }

        private void btnLapPhieuMuonTL_Click(object sender, EventArgs e)
        {

        }

        private void btnHuyTL_Click(object sender, EventArgs e)
        {
            btnXemChiTietTL.Hide();
            btnXoaTL.Hide();
            btnLapPhieuMuonTL.Hide();
            btnYeuCauTL.Hide();

            btnChinhSuaTL.Hide();
            btnLuuTL.Hide();
            btnHuyTL.Hide();

            dgvSearchTaiLieu.DataSource = null;
        }

        private void btnYeuCauTL_Click(object sender, EventArgs e)
        {

        }

        private void btnThongKe_Click(object sender, EventArgs e)
        {
            panelQLNhanVien.Visible = false;
            panelDocGia.Visible = false;
            panelTraCuu.Visible = false;
            panelQLSach.Visible = false;
            pnThongKe.Visible = true;
            this.pnThongKe.Location = new System.Drawing.Point(220, 118);

        }

        private void btnXPmuon_Click(object sender, EventArgs e)
        {
            this.pnxemphieumuon.Location = new System.Drawing.Point(0, 24);
            pnLapPhieumuon.Visible = false;
            pnxemphieumuon.Visible = true;
            pnNhapthongtintimkiemphieumuon.Visible = false;
            if (pnxemphieumuon.Visible == true)
            {
                string strSql = "exec usp_XemPhieuMuon";

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();
                //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
                //dgvxemphieumuon.DataSource = dt;
                //dgvxemphieumuon.ReadOnly = true;

                //DBConnect.Disconnect();
            }
        }

        private void dgvNhanVien_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void btnLPmuon_Click(object sender, EventArgs e)
        {
            this.pnLapPhieumuon.Location = new System.Drawing.Point(0, 24);
            pnxemphieumuon.Visible = false;
            pnLapPhieumuon.Visible = true;

        }

        private void btnLpTra_Click(object sender, EventArgs e)
        {
            //this.pnLapPhieumuon.Location = new System.Drawing.Point(0, 24);
            //pnxemphieumuon.Visible = false;
            //pnLapPhieumuon.Visible = true;
            this.pnlapphieutra.Location = new System.Drawing.Point(0, 24);
            pnlapphieutra.Visible = true;
            pnXemPhieuTra.Visible = false;
        }

        private void btnXemPhieuTra_Click(object sender, EventArgs e)
        {
            // this.pnxemphieumuon.Location = new System.Drawing.Point(0, 24);
            //pnLapPhieumuon.Visible = false;
            //pnxemphieumuon.Visible = true;
            //if (pnxemphieumuon.Visible == true) 
            this.pnXemPhieuTra.Location = new System.Drawing.Point(0, 24);
            pnlapphieutra.Visible = false;
            pnXemPhieuTra.Visible = true;
            if (pnXemPhieuTra.Visible == true) 
            {
                string strSql = "exec usp_XemPhieuTra";

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();
                //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
                ////dgvxemphieumuon.DataSource = dt;
                ////dgvxemphieumuon.ReadOnly = true;
                //dgvXemPhieuTra.DataSource = dt;
                //dgvXemPhieuTra.ReadOnly = true;

                //DBConnect.Disconnect();
            }

        }

        private void btnLPNhacNho_Click(object sender, EventArgs e)
        {
            pnXemPhieuNhacNho.Visible = false;
            pnLapPhieuNhacNho.Visible = true;
            this.pnLapPhieuNhacNho.Location = new System.Drawing.Point(0, 24);
        }

        private void btnXemPNhacNho_Click(object sender, EventArgs e)
        {
            this.pnXemPhieuNhacNho.Location = new System.Drawing.Point(0, 24);
            //pnlapphieutra.Visible = false;
            //pnXemPhieuTra.Visible = true;
            pnXemPhieuNhacNho.Visible = true;
            pnLapPhieuNhacNho.Visible = false;
            if (pnXemPhieuNhacNho.Visible == true)
            {
                string strSql = "exec usp_XemPhieuNhacNho";

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();
                //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
                ////dgvxemphieumuon.DataSource = dt;
                ////dgvxemphieumuon.ReadOnly = true;
                //dgvXemPhieuNhacNho.DataSource = dt;
                //dgvXemPhieuNhacNho.ReadOnly = true;
                //DBConnect.Disconnect();

            }
        }

        private void btnLapPhieuPhat_Click(object sender, EventArgs e)
        {
            //pnXemPhieuNhacNho.Visible = false;
            //pnLapPhieuNhacNho.Visible = true;
            //this.pnLapPhieuNhacNho.Location = new System.Drawing.Point(0, 24);
            pnXemPhieuPhat.Visible = false;
            pnLapPhieuPhat.Visible = true;
            this.pnLapPhieuPhat.Location = new System.Drawing.Point(0, 24);
        }

        private void btnXemPhieuPhat_Click(object sender, EventArgs e)
        {
            pnXemPhieuPhat.Visible = true;
            pnLapPhieuPhat.Visible = false;
            this.pnXemPhieuPhat.Location = new System.Drawing.Point(0, 24);
            if (pnXemPhieuPhat.Visible == true) 
            {
                string strSql = "exec usp_XemPhieuPhat";

                //DBConnect DBConnect = new DBConnect();
                //DBConnect.Connect();
                //DataTable dt = DBConnect.Select(CommandType.Text, strSql);
                ////dgvxemphieumuon.DataSource = dt;
                ////dgvxemphieumuon.ReadOnly = true;
                //dgvXemPhieuPhat.DataSource = dt;
                //dgvXemPhieuPhat.ReadOnly = true;
                //DBConnect.Disconnect();

            }
        }

        private void btnCNmuon_Click(object sender, EventArgs e)
        {
            pnxemphieumuon.Visible = true;
            pnNhapthongtintimkiemphieumuon.Visible = true;
        }
    }
}
