using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraBars;

namespace DeTai_QLDSV
{
    public partial class frmQuanLy : DevExpress.XtraBars.Ribbon.RibbonForm
    {
        //string SV_QLHP = @"DESKTOP-FR28U9S\SERVER_04";
        public frmQuanLy()
        {
            InitializeComponent();
        }

        private void frmQuanLy_Load(object sender, EventArgs e)
        {
            ControlBox = false;
            sttMaGv.Text += Program.username ;
            sttHoten.Text += Program.mHoten;
            sttNhom.Text += Program.mGroup;
            if (Program.mGroup == "PKETOAN")
            {
                btnLop.Enabled = btnDiem.Enabled = btnMonHoc.Enabled = false;
            }
            else if (Program.mGroup == "USER")
            {
                btnTaoTK.Enabled = btnHP.Enabled = btnLop.Enabled = btnMonHoc.Enabled = false;
            }
            else if (Program.mGroup != "PKETOAN")
            {
                btnHP.Enabled = false;
            }
        }

        private Form CheckExists(Type ftype)
        {
            foreach (Form f in this.MdiChildren)
                if (f.GetType() == ftype)
                    return f;
            return null;
        }

        private void btnLop_ItemClick(object sender, ItemClickEventArgs e)
        {
            Form frm = this.CheckExists(typeof(frmLop1));
            if (frm != null) frm.Activate();
            else
            {
                Program.flop = new frmLop1();
                Program.flop.MdiParent = this;
                // Program.flop.Activate();
                Program.flop.Show();
            }
        }

        private void btnMonHoc_ItemClick(object sender, ItemClickEventArgs e)
        {
            Form frm = this.CheckExists(typeof(frmMonHoc));
            if (frm != null) frm.Activate();
            else
            {
                Program.fMonHoc = new frmMonHoc();
                Program.fMonHoc.MdiParent = this;
                // Program.flop.Activate();
                Program.fMonHoc.Show();
            }
        }

        private void btnDangXuat_ItemClick(object sender, ItemClickEventArgs e)
        {
            DialogResult rs = MessageBox.Show("Bạn có chắc chắn muốn đăng xuất?", "Đăng xuất tài khoản", MessageBoxButtons.OKCancel);
            if (rs == DialogResult.Cancel) return;
            Program.bds_dspm.RemoveFilter();
            Program.fmain.Close();
            Program.dangnhap.Close();
            Program.flag = 1;
        }

        private void btnDiem_ItemClick(object sender, ItemClickEventArgs e)
        {
            Form frm = this.CheckExists(typeof(frmDiem));
            if (frm != null) frm.Activate();
            else
            {
                Program.fDiem = new frmDiem();
                Program.fDiem.MdiParent = this;
                //Program.flop.Activate();
                Program.fDiem.Show();
            }
        }

        private void btnHP_ItemClick(object sender, ItemClickEventArgs e)
        {

            Form frm = this.CheckExists(typeof(frmHocPhi));
            if (frm != null) frm.Activate();
            else
            {
                Program.fHocPhi = new frmHocPhi();
                Program.fHocPhi.MdiParent = this;
                //Program.flop.Activate();
                Program.fHocPhi.Show();
            }
        }

        private void frmQuanLy_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (Program.flop != null) Program.flop.Close();
            if (Program.fMonHoc != null) Program.fMonHoc.Close();
            if (Program.fHocPhi != null) Program.fHocPhi.Close();
            Program.dangnhap.Close();
            Program.flag = 0;
        }

        private void btnTaoTK_ItemClick(object sender, ItemClickEventArgs e)
        {
            // frmTaoTK;
            Form frm = this.CheckExists(typeof(frmTaoTK));
            if (frm != null) frm.Activate();
            else
            {
                Program.fTaikhoan = new frmTaoTK();
                Program.fTaikhoan.MdiParent = this;
                //Program.flop.Activate();
                Program.fTaikhoan.Show();
            }
        }
    }
}