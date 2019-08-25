using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraEditors;
using System.Data.SqlClient;
using DevExpress.XtraReports.UI;

namespace DeTai_QLDSV
{
    public partial class frmLop1 : DevExpress.XtraEditors.XtraForm
    {
        string khoa = "";       
        int thaotac = 0;
        int pos = 0;
        int thaotacSv = 0;
        int posSv = 0;
        public frmLop1()
        {
            InitializeComponent();
        }

        private void frmLop1_Load(object sender, EventArgs e)
        {
            ControlBox = false;
            this.dS_DIEM.EnforceConstraints = false;
            // TODO: This line of code loads data into the 'dS_DIEM.LOP' table. You can move, or remove it, as needed.
            this.lOPTableAdapter.Connection.ConnectionString = Program.connstr;
            this.lOPTableAdapter.Fill(this.dS_DIEM.LOP);
            // TODO: This line of code loads data into the 'dS_DIEM.SINHVIEN' table. You can move, or remove it, as needed.
            this.sINHVIENTableAdapter.Connection.ConnectionString = Program.connstr;
            this.sINHVIENTableAdapter.Fill(this.dS_DIEM.SINHVIEN);
            // TODO: This line of code loads data into the 'qLDSVDataSet.V_DS_PHANMANH' table. You can move, or remove it, as needed.
            cmbKhoa.DataSource = Program.bds_dspm;
            cmbKhoa.DisplayMember = "tencn";
            cmbKhoa.ValueMember = "tenserver";
            cmbKhoa.SelectedIndex = Program.mKhoa;
            if (Program.mGroup == "KHOA")
            {
                cmbKhoa.Enabled = false;
            }
            if (Program.KetNoi() == 0) return;
            //this.v_DS_PHANMANHBindingSource.Filter = "TENCN NOT LIKE '%Học phí%'";
            //this.v_DS_PHANMANHTableAdapter.Fill(this.qLDSVDataSet.V_DS_PHANMANH);
            khoa = ((DataRowView)lOPBindingSource[0])["makh"].ToString();
            btnGhi.Enabled = btnPhucHoi.Enabled = btnGhiSv.Enabled = btnPhucHoiSv.Enabled = false;
        }

        private void cmbKhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbKhoa.ValueMember != "")
            {
                try
                {
                    if (Program.servername != this.cmbKhoa.SelectedValue.ToString())
                    {
                        Program.servername = this.cmbKhoa.SelectedValue.ToString();
                    }
                    if (cmbKhoa.SelectedIndex != Program.mKhoa)
                    {
                        Program.mlogin = Program.remoteLogin;
                        Program.mpassword = Program.remotepass;
                    }
                    else
                    {
                        Program.mlogin = Program.LoginDN;
                        Program.mpassword = Program.PasswordDN;
                    }
                    if (Program.KetNoi() == 0)
                    {
                        MessageBox.Show("Không thể kết nối tới khoa mới", "Lỗi kết nối", MessageBoxButtons.OK);
                        return;
                    }
                    else
                    {
                        this.lOPTableAdapter.Connection.ConnectionString = Program.connstr;
                        this.lOPTableAdapter.Fill(this.dS_DIEM.LOP);
                        lOPBindingSource.Position = 0;
                        this.sINHVIENTableAdapter.Connection.ConnectionString = Program.connstr;
                        this.sINHVIENTableAdapter.Fill(this.dS_DIEM.SINHVIEN);
                        TurnOn_Offbtn();
                       
                        try
                        {
                            khoa = ((DataRowView)lOPBindingSource[0])["MAKH"].ToString();
                        }
                        catch (Exception ex) { };
                    }
                }
                catch (NullReferenceException ex) { };
            }
        }

        private void tENCNLabel_Click(object sender, EventArgs e)
        {

        }

        private void standaloneBarDockControl1_Click(object sender, EventArgs e)
        {

        }

        private void h_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void btnXoa_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (sINHVIENBindingSource.Count > 0)
            {
                MessageBox.Show("Không thể xóa lớp vì đã có sinh viên", "Lỗi xóa sinh viên", MessageBoxButtons.OK);
                return;
            }
            DialogResult rs = MessageBox.Show("Bạn có chắc chắn muốn xóa lớp này?", "", MessageBoxButtons.OKCancel);
            if (rs == DialogResult.OK)
            {
                try
                {
                    lOPBindingSource.RemoveCurrent();
                    this.lOPTableAdapter.Update(this.dS_DIEM.LOP);
                    this.lOPTableAdapter.Fill(this.dS_DIEM.LOP);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Không thể xóa lớp vì đã có sinh viên", "Lỗi xóa sinh viên", MessageBoxButtons.OK);
                }
            }
        }

        private void btnThem_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            txtMaLop.Enabled = true;
            groupBox1.Enabled = btnThoat.Enabled = true;
            lOPBindingSource.AddNew();
            txtMaLop.Focus();
            txtMaKhoa.Text = khoa;
            gcLop.Enabled = false;
            groupBox2.Enabled = false;
            btnPhucHoi.Enabled = btnGhi.Enabled = true;
            btnThem.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = btnHieuChinh.Enabled = cmbKhoa.Enabled = false;
            thaotac = 1;
        }

        private void btnHieuChinh_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            /*txtMaLop.Enabled =*/ cmbKhoa.Enabled = false;
            pos = lOPBindingSource.Position;
            gcLop.Enabled = btnHieuChinh.Enabled = btnThem.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = btnPhucHoi.Enabled = false;
            btnPhucHoi.Enabled = btnThoat.Enabled = btnGhi.Enabled = groupBox1.Enabled = true;
            thaotac = 2;
        }

        private void btnGhi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (txtMaLop.Text.Trim() == "")
            {
                MessageBox.Show("Bạn chưa nhập mã lớp!", "", MessageBoxButtons.OK);
                txtMaLop.Focus();
                return;
            }
            if (txtTenLop.Text.Trim() == "")
            {
                MessageBox.Show("Bạn chưa nhập tên lớp!", "", MessageBoxButtons.OK);
                txtTenLop.Focus();
                return;
            }
            //Kiem tra ma mon hoc            
            if (Program.KetNoi() == 0)
            {
                return;
            }

            //Ket thuc kiem tra 
            try
            {              
                //lOPBindingSource.ResetCurrentItem();
                if (Program.GetReturnValue_TimID("SP_CHECKMALOP", txtMaLop.Text.Trim(), thaotac - 1) == 1)
                {
                    MessageBox.Show("Mã lớp đã bị trùng", "Lỗi mã lớp", MessageBoxButtons.OK);
                    this.lOPTableAdapter.Fill(this.dS_DIEM.LOP);
                    if (thaotac == 2) lOPBindingSource.Position = pos;
                    else if (thaotac == 1)
                    {
                        lOPBindingSource.AddNew();
                        txtMaKhoa.Text = khoa;
                    }
                    txtMaLop.Focus();
                    return;
                }
                lOPBindingSource.EndEdit();
                lOPBindingSource.ResetCurrentItem();
                this.lOPTableAdapter.Update(this.dS_DIEM.LOP);
                 btnThem.Enabled = btnXoa.Enabled = btnPhucHoi.Enabled = btnHieuChinh.Enabled = btnTaiLai.Enabled = gcLop.Enabled = true;
                groupBox1.Enabled = btnGhi.Enabled = btnPhucHoi.Enabled = false;
                groupBox2.Enabled = cmbKhoa.Enabled = true;
                thaotac = 0;
                MessageBox.Show("Ghi dữ liệu thành công!", "", MessageBoxButtons.OK);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Mã Lớp không được để trống"+ex.Message, "", MessageBoxButtons.OK);
                return;
            }
        }

        private void btnPhucHoi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (thaotac == 1) lOPBindingSource.RemoveCurrent();
            lOPBindingSource.CancelEdit();
            this.sINHVIENTableAdapter.Fill(this.dS_DIEM.SINHVIEN);
            lOPBindingSource.Position = pos;
            btnThem.Enabled = btnHieuChinh.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = gcLop.Enabled = true;
            btnGhi.Enabled = groupBox1.Enabled = btnPhucHoi.Enabled = false;
            groupBox2.Enabled = cmbKhoa.Enabled = true;
            txtMaLop.Enabled = true;
            thaotac = 0;
        }

        private void btnTaiLai_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            lOPBindingSource.RemoveFilter();
            this.lOPTableAdapter.Fill(this.dS_DIEM.LOP);
        }

        private void btnThoat_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            DialogResult rs = MessageBox.Show("Bạn có chắc chắn muôn đóng form Lớp?", "Thoát", MessageBoxButtons.OKCancel);
            if (rs == DialogResult.OK)
            {
                if (thaotac == 1)
                    rs = MessageBox.Show("Thao tác thêm đang được thực hiện, bạn có chắc chắn muốn hủy?", "Cảnh báo", MessageBoxButtons.OKCancel);
                else if (thaotac == 2)
                    rs = MessageBox.Show("Thao tác hiệu chỉnh đang được thực hiện, bạn có chắc chắn muốn hủy?", "Cảnh báo", MessageBoxButtons.OKCancel);
                if (rs == DialogResult.OK) this.Close();
            }
        }

        private void btnThemSv_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            btnPhucHoiSv.Enabled = btnGhiSv.Enabled = groupBox4.Enabled = txtMaSV.Enabled = true;
            sINHVIENBindingSource.AddNew();
            txtMaSV.Focus();
            txtMaLopSv.Text = ((DataRowView)lOPBindingSource[lOPBindingSource.Position])["malop"].ToString();
            pHAICheckEdit.Checked = true;        
            nghiHoc.Checked = gcLop.Enabled = groupBox1.Enabled = cmbKhoa.Enabled = nghiHoc.Enabled = false;
            btnThem.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = btnHieuChinh.Enabled = btnGhi.Enabled = btnPhucHoi.Enabled = btnThoat.Enabled = false;
            btnThemSv.Enabled = btnXoaSv.Enabled = btnTaiLaiSv.Enabled = btnHieuChinhSv.Enabled = dgcSinhVien.Enabled = false;
            thaotacSv = 1;
        }

        private void btnXoaSv_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        { 
            DialogResult rs = MessageBox.Show("Bạn có chắc chắn muốn xóa sinh viên này?", "", MessageBoxButtons.OKCancel);
            if (rs == DialogResult.OK)
            {
                try
                {
                    nghiHoc.Checked = true;
                    sINHVIENBindingSource.EndEdit();
                    sINHVIENBindingSource.ResetCurrentItem();
                    this.sINHVIENTableAdapter.Update(this.dS_DIEM.SINHVIEN);              
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Không thể xóa sinh viên vì sinh viên đã có điểm", "Lỗi xóa sinh viên", MessageBoxButtons.OK);
                }
            }
        }

        private void btnHieuChinhSv_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            posSv = sINHVIENBindingSource.Position;
            groupBox4.Enabled = true;
            txtMaSV.Enabled = false;
            btnPhucHoiSv.Enabled = btnGhiSv.Enabled = true;
            gcLop.Enabled =  false;
            groupBox1.Enabled = false;
            btnThem.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = btnHieuChinh.Enabled = btnGhi.Enabled = btnPhucHoi.Enabled = btnThoat.Enabled = false;
            btnThemSv.Enabled = btnXoaSv.Enabled = btnTaiLaiSv.Enabled = btnHieuChinhSv.Enabled = false;
            dgcSinhVien.Enabled = cmbKhoa.Enabled = false;
            thaotacSv = 2;
        }

        private void btnGhiSv_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (txtMaSV.Text.Trim() == "")
            {
                MessageBox.Show("Bạn chưa nhập mã sinh viên!", "", MessageBoxButtons.OK);
                txtMaSV.Focus();
                return;
            }
             if (txtHoSv.Text.Trim() == "")
            {
                MessageBox.Show("Bạn chưa nhập họ sinh viên!", "", MessageBoxButtons.OK);
                txtHoSv.Focus();
                return;
            }
            if (txtTenSv.Text.Trim() == "")
            {
                MessageBox.Show("Bạn chưa nhập tên sinh viên!", "", MessageBoxButtons.OK);
                txtTenSv.Focus();
                return;
            }
            if (txtNoiSinh.Text.Trim() == "")
            {
                MessageBox.Show("Bạn chưa nhập nơi sinh sinh viên!", "", MessageBoxButtons.OK);
                txtNoiSinh.Focus();
                return;
            }
            if (txtDiaChi.Text.Trim() == "")
            {
                MessageBox.Show("Bạn chưa nhập địa chỉ sinh viên!", "", MessageBoxButtons.OK);
                txtDiaChi.Focus();
                return;
            }
            //Kiem tra ma Sinh Viên
            if (Program.KetNoi() == 0)
                return;
            try
            {           
                if (Program.GetReturnValue_TimID("SP_CHECKMASV", txtMaSV.Text.Trim(), thaotacSv - 1) == 1)
                {
                    MessageBox.Show("Mã sinh viên đã bị trùng", "Lỗi mã sinh viên", MessageBoxButtons.OK);
                    this.sINHVIENTableAdapter.Fill(this.dS_DIEM.SINHVIEN);
                    if (thaotacSv == 2) sINHVIENBindingSource.Position = posSv;
                    else if (thaotacSv == 1)
                    {
                        sINHVIENBindingSource.AddNew();
                    }
                    txtMaSV.Focus();
                    return;
                }
                sINHVIENBindingSource.EndEdit();
                sINHVIENBindingSource.ResetCurrentItem();
                this.sINHVIENTableAdapter.Update(this.dS_DIEM.SINHVIEN);
                groupBox4.Enabled = btnGhiSv.Enabled = btnPhucHoiSv.Enabled = false;
                btnThemSv.Enabled = btnXoaSv.Enabled = btnTaiLaiSv.Enabled = btnHieuChinhSv.Enabled = true;
                groupBox2.Enabled = true;
                dgcSinhVien.Enabled = cmbKhoa.Enabled = true;
                gcLop.Enabled = btnThem.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = btnHieuChinh.Enabled = btnGhi.Enabled = btnPhucHoi.Enabled = btnThoat.Enabled = true;
                thaotacSv = 0;
                MessageBox.Show("Ghi dữ liệu thành công!", "", MessageBoxButtons.OK);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Mã sinh viên không được để trống", "", MessageBoxButtons.OK);
                return;
            }
        }

        private void btnPhucHoiSv_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (thaotacSv == 1) sINHVIENBindingSource.RemoveCurrent();
            sINHVIENBindingSource.CancelEdit();
            this.sINHVIENTableAdapter.Fill(this.dS_DIEM.SINHVIEN);
            sINHVIENBindingSource.Position = posSv;
            TurnOn_Offbtn();
            groupBox4.Enabled = btnGhiSv.Enabled = btnPhucHoiSv.Enabled = false;
            btnThemSv.Enabled =  btnTaiLaiSv.Enabled =  true;
            groupBox2.Enabled = true;
            dgcSinhVien.Enabled = true;
            gcLop.Enabled = btnThem.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = btnPhucHoi.Enabled = btnThoat.Enabled = true;
            btnGhi.Enabled = btnPhucHoi.Enabled = false;
            btnHieuChinh.Enabled = cmbKhoa.Enabled = true;
            thaotacSv = 0;
        }

        private void btnTaiLaiSv_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        { 
            this.sINHVIENTableAdapter.Fill(this.dS_DIEM.SINHVIEN);
        }
        private void TurnOn_Offbtn()
        {
            if (sINHVIENBindingSource.Count > 0)
            {
                btnInDSSV.Enabled = btnInPDSV.Enabled = btnHieuChinhSv.Enabled = btnXoaSv.Enabled = true;
                btnXoa.Enabled = false;
            }

            else
            {
                btnInDSSV.Enabled = btnInPDSV.Enabled = btnHieuChinhSv.Enabled = btnXoaSv.Enabled = false;
                btnXoa.Enabled = true;
            }
                
        }

        private void gvLop_FocusedRowObjectChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowObjectChangedEventArgs e)
        {
            TurnOn_Offbtn();         
        }

        private void gvLop_FocusedRowChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs e)
        {
            TurnOn_Offbtn();           
        }

        private void groupBox4_Enter(object sender, EventArgs e)
        {

        }

        private void standaloneBarDockControl1_Click_1(object sender, EventArgs e)
        {

        }

        private void barButtonItem1_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {


            //rpt.lvlTenLop.Text = txtTenLop.Text ;
            //rpt.lblMonhoc.Text = cmbMonHoc.Text;
            //rpt.lblLanThi.Text = txtLanThi.Value.ToString();
            
            XtraReport1 rpt = new XtraReport1(txtMaLop.Text.Trim());
            
            rpt.lblLop.Text += txtTenLop.Text;
            ReportPrintTool print = new ReportPrintTool(rpt);
            print.ShowPreviewDialog();
        }

        private void btnInPDSV_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            
            //string nienkhoa = txtNienKhoa.Value.ToString();
            //int lanthi = (int)txtLanThi.Value;
            //if (Program.Ketnoi_HP() == 0) return;
            rptPhieuDiemSinhVien rpt = new rptPhieuDiemSinhVien(((DataRowView)sINHVIENBindingSource[sINHVIENBindingSource.Position])["masv"].ToString());
            rpt.lblSinhVien.Text = ((DataRowView)sINHVIENBindingSource[sINHVIENBindingSource.Position])["masv"].ToString() + " - " + ((DataRowView)sINHVIENBindingSource[sINHVIENBindingSource.Position])["ho"].ToString() +" " +((DataRowView)sINHVIENBindingSource[sINHVIENBindingSource.Position])["ten"].ToString();
            //rpt.lblMonhoc.Text = cmbMonHoc.Text;
            //rpt.lblLanThi.Text = txtLanThi.Value.ToString();
            ReportPrintTool print = new ReportPrintTool(rpt);
            print.ShowPreviewDialog();
        }
    }
}