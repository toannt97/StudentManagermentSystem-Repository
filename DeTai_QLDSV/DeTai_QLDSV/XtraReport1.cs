using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace DeTai_QLDSV
{
    public partial class XtraReport1 : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReport1(string Malop)
        {
            InitializeComponent();
            this.sP_INDSSVTableAdapter1.Connection.ConnectionString = Program.connstr;

            this.sP_INDSSVTableAdapter1.Fill(dS_DIEM1.SP_INDSSV, Malop);
        }

    }
}
