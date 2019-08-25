using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace DeTai_QLDSV
{
    public partial class rptBangDiemMonHoc : DevExpress.XtraReports.UI.XtraReport
    {
        public rptBangDiemMonHoc(string tenlop,string tenmh, int lan)
        {
            InitializeComponent();
            this.sP_INBANGDIEMTableAdapter1.Connection.ConnectionString = Program.connstr;
            this.sP_INBANGDIEMTableAdapter1.Fill(dS_DIEM1.SP_INBANGDIEM, tenlop, tenmh, lan);
        }

        private void xrTable2_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            if (this.GetCurrentRow().Equals(this.GetNextRow()))
            {
                xrTable2.Borders = DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom;
            }
        }
    }
}
