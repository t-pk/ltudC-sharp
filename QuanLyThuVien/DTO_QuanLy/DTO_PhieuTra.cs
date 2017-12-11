using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTO_QuanLy
{
    public class DTO_PhieuTra
    {
        private string maNhanVienLapPhieuTra;
        private string maPhieuMuon;
        private string maPhieuTra;
        private string maCTPT;
        private string maTaiLieu;

        public string MaNhanVienLapPhieuTra
        {
            get
            {
                return maNhanVienLapPhieuTra;
            }

            set
            {
                maNhanVienLapPhieuTra = value;
            }
        }

        public string MaPhieuMuon
        {
            get
            {
                return maPhieuMuon;
            }

            set
            {
                maPhieuMuon = value;
            }
        }

        public string MaPhieuTra
        {
            get
            {
                return maPhieuTra;
            }

            set
            {
                maPhieuTra = value;
            }
        }
        public string MaCTPT
        {
            get
            {
                return maCTPT;
            }

            set
            {
                maCTPT = value;
            }
        }


        public string MaTaiLieu
        {
            get
            {
                return maTaiLieu;
            }

            set
            {
                maTaiLieu = value;
            }
        }

        /* === Constructor === */
        public DTO_PhieuTra()
        {
        }
        public DTO_PhieuTra(string maNhanVienLapPhieuTra, string maPhieuMuon, string maPhieuTra, string maCTPT, string maTaiLieu)
        {
            this.MaNhanVienLapPhieuTra = maNhanVienLapPhieuTra;
            this.MaPhieuMuon = maPhieuMuon;
            this.MaPhieuTra = maPhieuTra;
            this.MaCTPT = maCTPT;
            this.MaTaiLieu = maTaiLieu;
        }
    }
}
