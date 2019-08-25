using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace DeTai_QLDSV
{
    public partial class rptDanhSachDongHocPhi : DevExpress.XtraReports.UI.XtraReport
    {
        public rptDanhSachDongHocPhi(string malop,string nienkhoa,int hocky)
        {
            InitializeComponent();          
            this.sP_DSHOCPHICUALOPTableAdapter1.Connection.ConnectionString = Program.connstr;
            this.sP_DSHOCPHICUALOPTableAdapter1.Fill(dS_HOCPHI1.SP_DSHOCPHICUALOP,malop,nienkhoa,hocky);
        }

        private void xrLabel3_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            
        }
        private void xrLabel3_SummaryCalculated(object sender, TextFormatEventArgs e)
        {
            lblTienChu.Text =" Số tiền bằng chữ: " + Program.So_chu(Double.Parse(e.Value.ToString()));
        }
    }
}
