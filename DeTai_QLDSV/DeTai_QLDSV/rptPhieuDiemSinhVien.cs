using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace DeTai_QLDSV
{
    public partial class rptPhieuDiemSinhVien : DevExpress.XtraReports.UI.XtraReport
    {
        public rptPhieuDiemSinhVien(string masv)
        {
            InitializeComponent();
            this.sP_PHIEUDIEMSVTableAdapter1.Connection.ConnectionString = Program.connstr;
            this.sP_PHIEUDIEMSVTableAdapter1.Fill(dS_DIEM1.SP_PHIEUDIEMSV, masv);
        }

    }
}
