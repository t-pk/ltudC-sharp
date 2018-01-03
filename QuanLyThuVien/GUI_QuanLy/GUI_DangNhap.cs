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
using DTO_QuanLy;
using BUS_QuanLy;
using System.Security.Cryptography;

namespace GUI_QuanLy
{
    public partial class GUI_DangNhap : Form
    {
        BUS_DangNhap busDangNhap = new BUS_DangNhap();


        public delegate void delPassData(string ten, string quyen);
        public GUI_DangNhap()
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
        /*
        * Hàm băm SHA
        */
        private string EncodeSHA1(string pass)
        {

            SHA1CryptoServiceProvider sha1 = new SHA1CryptoServiceProvider();
            byte[] bs = System.Text.Encoding.UTF8.GetBytes(pass);
            bs = sha1.ComputeHash(bs);
            System.Text.StringBuilder s = new System.Text.StringBuilder();
            foreach (byte b in bs)
            {
                s.Append(b.ToString("x").ToLower());
            }
            pass = s.ToString();
            return pass;
        }
        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            string username = txtUSER.Text;
            string password = EncodeSHA1(txtPASS.Text);
            string NameUser = busDangNhap.getNameUser_Login(username, password);
            string Quyen = busDangNhap.getPermissionUser_Login(username, password);
            string p = busDangNhap._Login(username, password);
            
            if (p.ToString() == "1")
            {             
                this.Hide();
                GUI_Home frHome = new GUI_Home();
                frHome.Show();

                delPassData del = new delPassData(frHome.funData);
                del(NameUser, Quyen);
            }
            else MessageBox.Show("Tên đăng nhập hoặc mật khẩu không đúng!\n\tVui lòng kiểm tra lại!!!");
        }

        private void btnDangKy_Click(object sender, EventArgs e)
        {
            GUI_DangKy frDangKy = new GUI_DangKy();
            this.Hide();
            frDangKy.Show();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
       
        }

        private void cbNhoPassWord_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void txtPASS_TextChanged(object sender, EventArgs e)
        {
            txtPASS.PasswordChar = '*';
        }   
    }
}
