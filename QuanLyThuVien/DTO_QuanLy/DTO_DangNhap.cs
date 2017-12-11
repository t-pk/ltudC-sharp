using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTO_QuanLy
{
    public class DTO_DangNhap
    {

        private string username = "";
        private string password = "";
        public string User
        {
            get
            {
                return username;
            }

            set
            {
                username = value;
            }
        }
        public string Password
        {
            get
            {
                return password;
            }
            set
            {
                password = value;
            }
        }

        /* === Constructor === */
        public DTO_DangNhap()
        {

        }

        public DTO_DangNhap(int id, string name)
        {
         
        }
    }
}
