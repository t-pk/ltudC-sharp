using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTO_QuanLy
{
    public class DTO_Phieu
    {
        private string maPhieuMuon;
        private string maDG_PhieuMuon;
        private string sTT_PhieuMuon;
        private string maTL_PMuon;
        private string soLuongTL_Muon;
        private string ngayMuon;
        private string hanTra_Muon;

        /* ======== GETTER/SETTER ======== */
        public string MaPhieu
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
        public string MaDG_PhieuMuon
        {
            get
            {
                return maDG_PhieuMuon;
            }

            set
            {
                maDG_PhieuMuon = value;
            }
        }
        public string STT_PhieuMuon
        {
            get
            {
                return sTT_PhieuMuon;
            }

            set
            {
                sTT_PhieuMuon = value;
            }
        }
        public string MaTL_PMuon
        {
            get
            {
                return maTL_PMuon;
            }

            set
            {
                maTL_PMuon = value;
            }
        }
        public string SoLuongTL_Muon
        {
            get
            {
                return soLuongTL_Muon;
            }

            set
            {
                soLuongTL_Muon = value;
            }
        }
        public string NgayMuon
        {
            get
            {
                return ngayMuon;
            }

            set
            {
                ngayMuon = value;
            }
        }
        public string HanTra_Muon
        {
            get
            {
                return hanTra_Muon;
            }

            set
            {
                hanTra_Muon = value;
            }
        }

        /* === Constructor === */
        public DTO_Phieu()
        {
        }
        public DTO_Phieu(string maPhieuMuon, string maDG_PhieuMuon, string sTT_PhieuMuon, string maTL_PMuon, string soLuongTL_Muon,
            string ngayMuon, string hanTra_Muon)
        {
            this.MaPhieu = maPhieuMuon;
            this.MaDG_PhieuMuon = maDG_PhieuMuon;
            this.STT_PhieuMuon = sTT_PhieuMuon;
            this.MaTL_PMuon = maTL_PMuon;
            this.SoLuongTL_Muon = soLuongTL_Muon;
            this.NgayMuon = ngayMuon;
            this.HanTra_Muon = hanTra_Muon;
        }

     
    }
}
