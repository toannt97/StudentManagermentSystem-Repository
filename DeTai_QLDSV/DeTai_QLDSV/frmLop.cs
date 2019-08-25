using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DeTai_QLDSV
{
    public partial class frmLop : DevExpress.XtraEditors.XtraForm
    {

        int pos = 0;
        int thaotac = 0;
        string khoa = "";
        public frmLop()
        {
            InitializeComponent();
        }

        private void frmLop_Load(object sender, EventArgs e)
        {
            
            dgvSinhVien.Columns["NGAY"].DefaultCellStyle.Format = "dd/MM/yyyy";
            ControlBox = false;      
            dS_DIEM.EnforceConstraints = false;
            this.lOPTableAdapter.Connection.ConnectionString = Program.connstr;            
            // TODO: This line of code loads data into the 'dS_DIEM.LOP' table. You can move, or remove it, as needed.
            this.lOPTableAdapter.Fill(this.dS_DIEM.LOP);
            this.sINHVIENTableAdapter.Connection.ConnectionString = Program.connstr;
            // TODO: This line of code loads data into the 'dS_DIEM.SINHVIEN' table. You can move, or remove it, as needed.
            this.sINHVIENTableAdapter.Fill(this.dS_DIEM.SINHVIEN);
            this.gcLop.ShowOnlyPredefinedDetails = true;
            dgvSinhVien.ReadOnly = true;
            dgvSinhVien.AllowUserToDeleteRows = false;
            khoa = ((DataRowView)bdsLop[0])["makh"].ToString();
            cmbkhoa.DataSource = Program.bds_dspm;
            cmbkhoa.DisplayMember = "tencn";
            cmbkhoa.ValueMember = "tenserver";
            cmbkhoa.SelectedIndex = Program.mKhoa;
            txtMaKhoa.Enabled = false;
             if (Program.mGroup == "KHOA")
             { 
                    cmbkhoa.Enabled = false;
             }
            else if (Program.mGroup == "PKETOAN")
            {
                    cmbkhoa.Enabled = false;

            }
            groupBox1.Enabled = btnGhi.Enabled = btnPhucHoi.Enabled = false;
            MessageBox.Show(nGAYSINHDateTimePicker.Value.ToString());
        }

        private void cmbkhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbkhoa.ValueMember != "")
            {//cntt, index= 0
                //vt,index =1
                try
                {
                    if (Program.servername != this.cmbkhoa.SelectedValue.ToString())
                    {
                        Program.servername = this.cmbkhoa.SelectedValue.ToString();
                    }
                    if (cmbkhoa.SelectedIndex != Program.mKhoa)//0
                    {
                        Program.mlogin = Program.remoteLogin;//HTKN
                        Program.mpassword = Program.remotepass;//htkn
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
                        this.lOPTableAdapter.Fill(dS_DIEM.LOP);
                        this.sINHVIENTableAdapter.Connection.ConnectionString = Program.connstr;
                        this.sINHVIENTableAdapter.Fill(this.dS_DIEM.SINHVIEN);
                        try
                        {
                            khoa = ((DataRowView)bdsLop[0])["MAKH"].ToString();
                        }
                        catch (Exception ex) { };

                    }
                }
                catch (NullReferenceException ex) { };
            }
        }

        private void btnThem_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            groupBox1.Enabled = btnThoat.Enabled = true;
            bdsLop.AddNew();
            txtMaKhoa.Text = khoa;
            gcLop.Enabled = panel1.Enabled = false;
            btnPhucHoi.Enabled = btnGhi.Enabled = true; btnThem.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = btnHieuChinh.Enabled = false;
            thaotac = 1;
        }

        private void btnXoa_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            //pos = bdsLop.Position;
            if (bdsSinhVien.Count > 0)
            {
                MessageBox.Show("Không thể xóa lớp vì đã có sinh viên", "Lỗi xóa sinh viên", MessageBoxButtons.OK);
                return;
            }
            DialogResult rs = MessageBox.Show("Bạn có chắc chắn muốn xóa lớp này?", "", MessageBoxButtons.OKCancel);
            if (rs == DialogResult.OK)
            {
                try
                {
                    bdsLop.RemoveCurrent();
                    this.lOPTableAdapter.Update(this.dS_DIEM.LOP);
                    this.lOPTableAdapter.Fill(this.dS_DIEM.LOP);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Không thể xóa lớp vì đã có sinh viên", "Lỗi xóa sinh viên", MessageBoxButtons.OK);
                }
            }
        }

        private void btnHieuChinh_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            pos = bdsLop.Position;
            dgvSinhVien.AllowUserToDeleteRows = true;
            panel1.Enabled = gcLop.Enabled = btnHieuChinh.Enabled = btnThem.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = btnPhucHoi.Enabled = dgvSinhVien.ReadOnly = false;
            btnPhucHoi.Enabled = btnThoat.Enabled = btnGhi.Enabled = groupBox1.Enabled = dgvSinhVien.Columns["MALOP"].ReadOnly = true;
            thaotac = 2;
        }

        private void btnGhi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            //int rowindex = dgvSinhVien.CurrentRow.Index;
            //MessageBox.Show(rowindex.ToString());
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
                txtMaLop.Text = txtMaLop.Text.ToUpper();
                bdsLop.EndEdit();
                bdsLop.ResetCurrentItem();
                if (Program.GetReturnValue_TimID("SP_TIMLOP", txtMaLop.Text,thaotac-1) == 1)
                {
                    MessageBox.Show("Mã lớp đã bị trùng", "Lỗi mã lớp", MessageBoxButtons.OK);
                    this.lOPTableAdapter.Fill(this.dS_DIEM.LOP);
                    if (thaotac == 2) bdsLop.Position = pos;
                    else if (thaotac == 1) bdsLop.AddNew();
                    txtMaLop.Focus();
                    return;
                }
                this.sINHVIENTableAdapter.Update(this.dS_DIEM.SINHVIEN);
                this.lOPTableAdapter.Update(this.dS_DIEM.LOP);
                
                panel1.Enabled = btnThem.Enabled = btnXoa.Enabled = btnPhucHoi.Enabled = btnHieuChinh.Enabled = btnTaiLai.Enabled = gcLop.Enabled = true;
                groupBox1.Enabled = btnGhi.Enabled = false;
                dgvSinhVien.ReadOnly = true;
                dgvSinhVien.AllowUserToDeleteRows = false;
                thaotac = 0;
                MessageBox.Show("Ghi dữ liệu thành công!", "", MessageBoxButtons.OK);
            }
            catch (Exception ex)
            {
               
                MessageBox.Show("Mã sinh viên không được để trống", "", MessageBoxButtons.OK);
                return;
            }
           
        }

        private void btnPhucHoi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if(thaotac ==1) bdsLop.RemoveCurrent();
            bdsLop.CancelEdit();
            this.sINHVIENTableAdapter.Fill(this.dS_DIEM.SINHVIEN);
            bdsLop.Position = pos;
            dgvSinhVien.AllowUserToDeleteRows = false;
            panel1.Enabled = btnThem.Enabled = btnHieuChinh.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = gcLop.Enabled = dgvSinhVien.ReadOnly = true;
            btnGhi.Enabled = groupBox1.Enabled = btnPhucHoi.Enabled= false;
            thaotac = 0;
        }

        private void btnTaiLai_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            thaotac = 0;
            bdsLop.RemoveFilter();
            this.lOPTableAdapter.Fill(this.dS_DIEM.LOP);
            this.sINHVIENTableAdapter.Fill(this.dS_DIEM.SINHVIEN);
            
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

        private void dgvSinhVien_UserDeletingRow(object sender, DataGridViewRowCancelEventArgs e)
        {
            DialogResult response = MessageBox.Show("Bạn có chắc chắn muốn xóa sinh viên này?", "Cảnh báo", MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2);
            if ((response == DialogResult.No))
                e.Cancel = true;
        }

        private void dgvSinhVien_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {
            MessageBox.Show(e.Exception.Message);
        }
    }
}
