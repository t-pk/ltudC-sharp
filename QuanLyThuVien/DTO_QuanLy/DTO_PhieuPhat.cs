using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTO_QuanLy
{
    public class DTO_PhieuPhat
    {
        private string maPhieuPhat;
        private string maPhieuMuon;
        private string maNVLapPhieuPhat;
        private string ngayLapPhieuPhat;
        private int soNgayQuaHan;
        private int soTienPhat;
        public string MaPhieuPhat
        {
            get
            {
                return maPhieuPhat;
            }

            set
            {
                maPhieuPhat = value;
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
        public string MaNVLapPhieuPhat
        {
            get
            {
                return maNVLapPhieuPhat;
            }

            set
            {
                maNVLapPhieuPhat = value;
            }
        }
        public string NgayLapPhieuPhat
        {
            get
            {
                return ngayLapPhieuPhat;
            }

            set
            {
                ngayLapPhieuPhat = value;
            }
        }
        public int SoNgayQuaHan
        {
            get
            {
                return soNgayQuaHan;
            }

            set
            {
                soNgayQuaHan = value;
            }
        }
        public int SoTienPhat
        {
            get
            {
                return soTienPhat;
            }

            set
            {
                soTienPhat = value;
            }
        }
        /* === Constructor === */
        public DTO_PhieuPhat()
        {
        }
        public DTO_PhieuPhat(string ma_PhieuMuon, string ma_NVLapPhieuPhat, int so_NgayQuaHan, int so_TienPhat)
        {
            this.MaPhieuMuon = ma_PhieuMuon;
            this.MaNVLapPhieuPhat = ma_NVLapPhieuPhat;
            this.SoNgayQuaHan = so_NgayQuaHan;
            this.SoTienPhat = so_TienPhat;
        }
        public DTO_PhieuPhat(string ma_PhieuMuon, string ma_NVLapPhieuPhat)
        {
            this.MaPhieuMuon = ma_PhieuMuon;
            this.MaNVLapPhieuPhat = ma_NVLapPhieuPhat;
        }
    }
}
