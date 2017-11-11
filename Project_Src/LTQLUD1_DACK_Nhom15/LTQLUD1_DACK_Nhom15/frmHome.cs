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
        }

        void setVisiblePannel()
        {
            panelQLNhanVien.Visible = false;
            panelDocGia.Visible = false;
            this.panelQLSach.Location = new System.Drawing.Point(220, 118);
            panelQLSach.Visible = true;
            panelQLSach.Size = new Size(900, 447);
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

        }

        private void button4_Click(object sender, EventArgs e)
        {
            panelQLNhanVien.Visible = false;           
            panelQLSach.Visible = false;
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

        private void button7_Click(object sender, EventArgs e)
        {
            panelQLNhanVien.Visible = true;
            this.panelQLNhanVien.Location = new System.Drawing.Point(220, 118);
            panelQLSach.Visible = false;
            panelDocGia.Visible = false;

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

        private void Form1_MouseUp(object sender, MouseEventArgs e)
        {
            drag = false;
        }
    }
}
