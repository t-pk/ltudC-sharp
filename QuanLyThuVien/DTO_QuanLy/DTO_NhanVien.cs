using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTO_QuanLy
{
    public class DTO_NhanVien
    {
        private string _user;
        private string _hotennv;
        private string _pass;
        private string _loai;
        private string _ca;
        private string _manv;

        /* ======== GETTER/SETTER ======== */
        public string NhanVien_manv
        {
            get
            {
                return _manv;
            }

            set
            {
                _manv = value;
            }
        }

        public string NhanVien_user
        {
            get
            {
                return _user;
            }

            set
            {
                _user = value;
            }
        }
        public string NhanVien_hotennv
        {
            get
            {
                return _hotennv;
            }

            set
            {
                _hotennv = value;
            }
        }
        public string NhanVien_pass
        {
            get
            {
                return _pass;
            }

            set
            {
                _pass = value;
            }
        }
        public string NhanVien_loai
        {
            get
            {
                return _loai;
            }

            set
            {
                _loai = value;
            }
        }
        public string NhanVien_ca
        {
            get
            {
                return _ca;
            }

            set
            {
                _ca = value;
            }
        }

        /* === Constructor === */
        public DTO_NhanVien()
        {
        }
        public DTO_NhanVien(string manv ,string user, string hoten, string pass, string loai, string ca)
        {
            this.NhanVien_manv = manv;
            this.NhanVien_user = user;
            this.NhanVien_hotennv = hoten;
            this.NhanVien_pass = pass;
            this.NhanVien_loai = loai;
            this.NhanVien_ca = ca;
        }
    }
}
