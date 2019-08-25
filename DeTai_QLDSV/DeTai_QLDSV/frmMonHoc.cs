using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DeTai_QLDSV
{
    public partial class frmMonHoc : Form
    {
        int thaotac = 0,pos=0;
        public frmMonHoc()
        {
            InitializeComponent();
            groupBox1.Enabled = false;
            btnGhi.Enabled = btnPhucHoi.Enabled = false;
        }

        private void frmMonHoc_Load(object sender, EventArgs e)
        {
            ControlBox = false;
            dS_DIEM.EnforceConstraints = false;
            // TODO: This line of code loads data into the 'dS_DIEM.MONHOC' table. You can move, or remove it, as needed.
            this.mONHOCTableAdapter.Connection.ConnectionString = Program.connstr;
            this.mONHOCTableAdapter.Fill(this.dS_DIEM.MONHOC);
            
        }

        private void btnThoat_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            DialogResult rs = MessageBox.Show("Bạn có chắc chắn muôn đóng form Môn Học?", "Thoát", MessageBoxButtons.OKCancel);
            if (rs == DialogResult.OK)
            {
                if (thaotac == 1)
                    rs = MessageBox.Show("Thao tác thêm đang được thực hiện, bạn có chắc chắn muốn hủy?", "Cảnh báo", MessageBoxButtons.OKCancel);
                else if (thaotac == 2)
                    rs = MessageBox.Show("Thao tác hiệu chỉnh đang được thực hiện, bạn có chắc chắn muốn hủy?", "Cảnh báo", MessageBoxButtons.OKCancel);
                if (rs == DialogResult.OK) this.Close();
            }
        }

        private void btnThem_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            pos = bdsMonHoc.Position;
            bdsMonHoc.AddNew();
            txtMaMH.Enabled=groupBox1.Enabled = btnThoat.Enabled = true;
            btnPhucHoi.Enabled = btnGhi.Enabled = true; btnThem.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = btnHieuChinh.Enabled = gcMonHoc.Enabled = false;
            thaotac = 1;
        }

        private void btnGhi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (txtMaMH.Text.Trim() == "")
            {
                MessageBox.Show("Bạn chưa nhập mã lớp!", "", MessageBoxButtons.OK);
                txtMaMH.Focus();
                return;
            }
            if (txtTenMH.Text.Trim() == "")
            {
                MessageBox.Show("Bạn chưa nhập tên lớp!", "", MessageBoxButtons.OK);
                txtTenMH.Focus();
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
                txtMaMH.Text = txtMaMH.Text.ToUpper();
                bdsMonHoc.EndEdit();
                bdsMonHoc.ResetCurrentItem();
                this.mONHOCTableAdapter.Update(this.dS_DIEM.MONHOC);
                btnThem.Enabled = btnXoa.Enabled =  btnHieuChinh.Enabled = btnTaiLai.Enabled = gcMonHoc.Enabled = true;
                groupBox1.Enabled = btnGhi.Enabled = false;
                thaotac = 0;
                MessageBox.Show("Ghi dữ liệu thành công!", "", MessageBoxButtons.OK);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Mã lớp đã bị trùng", "Lỗi mã lớp", MessageBoxButtons.OK);
                this.mONHOCTableAdapter.Fill(this.dS_DIEM.MONHOC);
                if (thaotac == 2) bdsMonHoc.Position = pos;
                else if (thaotac == 1) bdsMonHoc.AddNew();
                txtMaMH.Focus();
                return;
            }
        }

        private void btnPhucHoi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if(thaotac==1) bdsMonHoc.RemoveCurrent();
            bdsMonHoc.CancelEdit();           
            if (btnThem.Enabled == false) bdsMonHoc.Position = pos;
            btnThem.Enabled = btnHieuChinh.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = gcMonHoc.Enabled = true;
            btnGhi.Enabled = groupBox1.Enabled = btnPhucHoi.Enabled= false;
            thaotac = 0;
        }

        private void btnTaiLai_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            bdsMonHoc.RemoveFilter();
            this.mONHOCTableAdapter.Fill(this.dS_DIEM.MONHOC);
        }

        private void btnHieuChinh_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            pos = bdsMonHoc.Position;
            gcMonHoc.Enabled = btnHieuChinh.Enabled = btnThem.Enabled = btnXoa.Enabled = btnTaiLai.Enabled = btnPhucHoi.Enabled = false;
            btnPhucHoi.Enabled = btnThoat.Enabled = btnGhi.Enabled = groupBox1.Enabled = true;
            thaotac = 2;
        }


        private void Turn_On_Off()
        {
            if (dS_DIEM.MONHOC.Count > 0)
                btnXoa.Enabled = false;
            else
                btnXoa.Enabled = true;
        }

        private void gvMH_FocusedRowObjectChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs e)
        {
            Turn_On_Off();
        }

        private void gvMH_FocusedRowChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowObjectChangedEventArgs e)
        {
            Turn_On_Off();
        }
    }
}
