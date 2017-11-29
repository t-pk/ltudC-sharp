using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using DTO_QuanLy;
using BUS_QuanLy;

namespace GUI_QuanLy
{
    public partial class GUI_ThanhVien : Form
    {
        BUS_ThanhVien busTV = new BUS_ThanhVien();

        public GUI_ThanhVien()
        {
            InitializeComponent();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (txtEmail.Text != "" && txtName.Text != "" && txtSDT.Text != "")
            {
                // Tạo DTo
                DTO_ThanhVien tv = new DTO_ThanhVien(0, txtName.Text, txtSDT.Text, txtEmail.Text); // Vì ID tự tăng nên để ID số gì cũng dc

                // Them
                if (busTV.themThanhVien(tv))
                {
                    MessageBox.Show("Thêm thành công");
                    dgvTV.DataSource = busTV.getThanhVien(); // refresh datagridview
                }
                else
                {
                    MessageBox.Show("Thêm ko thành công");
                }
            }
            else
            {
                MessageBox.Show("Xin hãy nhập đầy đủ");
            }
        }

        // load nhân viên thông qua bus
        private void GUI_ThanhVien_Load(object sender, EventArgs e)
        {
            //dgvTV.DataSource = busTV.getThanhVien(); // get thanh vien không dùng proc
            dgvTV.DataSource = busTV.getNV();       // dùng proc có sẵn trong sql
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            // Kiểm tra nếu có chọn table rồi
            if (dgvTV.SelectedRows.Count > 0)
            {
                if (txtEmail.Text != "" && txtName.Text != "" && txtSDT.Text != "")
                {
                    // Lấy row hiện tại
                    DataGridViewRow row = dgvTV.SelectedRows[0];
                    int ID = Convert.ToInt16(row.Cells[0].Value.ToString());

                    // Tạo DTo
                    DTO_ThanhVien tv = new DTO_ThanhVien(ID, txtName.Text, txtSDT.Text, txtEmail.Text); // Vì ID tự tăng nên để ID số gì cũng dc

                    // Sửa
                    if (busTV.suaThanhVien(tv))
                    {
                        MessageBox.Show("Sửa thành công");
                        dgvTV.DataSource = busTV.getThanhVien(); // refresh datagridview
                    }
                    else
                    {
                        MessageBox.Show("Sửa ko thành công");
                    }
                }
                else
                {
                    MessageBox.Show("Xin hãy nhập đầy đủ");
                }
            }
            else
            {
                MessageBox.Show("Hãy chọn thành viên muốn sửa");
            }
        }

        private void dgvTV_Click(object sender, EventArgs e)
        {
            // Lấy row hiện tại
            DataGridViewRow row = dgvTV.SelectedRows[0];

            // Chuyển giá trị lên form
            txtName.Text = row.Cells[1].Value.ToString();
            txtSDT.Text = row.Cells[2].Value.ToString();
            txtEmail.Text = row.Cells[3].Value.ToString();
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            // Kiểm tra nếu có chọn table rồi
            if (dgvTV.SelectedRows.Count > 0)
            {

                // Lấy row hiện tại
                DataGridViewRow row = dgvTV.SelectedRows[0];
                int ID = Convert.ToInt16(row.Cells[0].Value.ToString());

                // Xóa
                if (busTV.xoaThanhVien(ID))
                {
                    MessageBox.Show("Xóa thành công");
                    dgvTV.DataSource = busTV.getThanhVien(); // refresh datagridview
                }
                else
                {
                    MessageBox.Show("Xóa ko thành công");
                }

            }
            else
            {
                MessageBox.Show("Hãy chọn thành viên muốn xóa");
            }
        }
    }
}
