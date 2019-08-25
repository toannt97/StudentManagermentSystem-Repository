using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace DeTai_QLDSV
{
    public partial class rptInDSSV : DevExpress.XtraReports.UI.XtraReport
    {
        public rptInDSSV(string malop)
        {
            InitializeComponent();
            this.sP_INDSSVTableAdapter1.Connection.ConnectionString = Program.connstr;
            this.sP_INDSSVTableAdapter1.Fill(dS_DIEM1.SP_INDSSV, malop);
            
        }

        private void xrLabel3_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            try
            {
                if (this.GetCurrentRow().Equals(this.GetNextRow()))
                {
                    xrLabel3.BorderWidth = 2;
                    xrLabel3.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
                }
            }catch(NullReferenceException ex)
            {
                xrLabel3.BorderWidth = 2;
                xrLabel3.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            }           
        }

        private void xrTable2_BeforePrint_1(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            try
            {
                if (this.GetCurrentRow().Equals(this.GetNextRow()))
                      xrTable2.Borders = DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom;
              
            }
            catch (NullReferenceException ex)
            {
                xrTable2.Borders = DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom;
            }
        }

        private void xrTable3_BeforePrint_1(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            try
            {
                if (this.GetCurrentRow().Equals(this.GetNextRow()))
                {
                    xrTable3.Borders = DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom;
                }
            }
            catch(NullReferenceException ex)
            {
                xrTable3.Borders = DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom;
            }
        }
    }
}
