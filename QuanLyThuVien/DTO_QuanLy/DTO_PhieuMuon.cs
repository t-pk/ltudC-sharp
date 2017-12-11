using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTO_QuanLy
{
    public class DTO_PhieuMuon
    {
        private string maNhanVienLapPhieuMuon;
        private string maDocGiaMuon;
        private string maTaiLieuMuon;
        private string maPhieuMuon;
        private string maCTPM;

        /* ======== GETTER/SETTER ======== */


        public string MaNhanVienLapPhieuMuon
        {
            get
            {
                return maNhanVienLapPhieuMuon;
            }

            set
            {
                maNhanVienLapPhieuMuon = value;
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

        public string MaDocGiaMuon
        {
            get
            {
                return maDocGiaMuon;
            }

            set
            {
                maDocGiaMuon = value;
            }
        }
        public string MaTaiLieuMuon
        {
            get
            {
                return maTaiLieuMuon;
            }

            set
            {
                maTaiLieuMuon = value;
            }
        }


        public string MaCTPM
        {
            get
            {
                return maCTPM;
            }

            set
            {
                maCTPM = value;
            }
        }

        /* === Constructor === */
        public DTO_PhieuMuon()
        {
        }
        public DTO_PhieuMuon(string maNV_PhieuMuon, string maDG_PhieuMuon, string maTL_PMuon, string ma_PhieuMuon, string ma_CTPM)
        {
            this.MaNhanVienLapPhieuMuon = maNV_PhieuMuon;
            this.MaDocGiaMuon = maDG_PhieuMuon;
            this.MaTaiLieuMuon = maTL_PMuon;
            this.MaPhieuMuon = ma_PhieuMuon;
            this.MaCTPM = ma_CTPM;
        }

     
    }
}
