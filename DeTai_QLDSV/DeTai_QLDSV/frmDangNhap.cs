using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace DeTai_QLDSV
{
    public partial class frmDangNhap : DevExpress.XtraEditors.XtraForm
    {
        public frmDangNhap()
        {
            InitializeComponent();
            ControlBox = false;
            this.StartPosition = FormStartPosition.CenterScreen;//Vi Tri xuat hien cua frmDangNhap
            this.Location = new System.Drawing.Point(450, 150);
            this.bdsDSPhanManh.Filter = "TENCN NOT LIKE '%Học phí%'";
        }

        private void frmDangNhap_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'qLDSVDataSet.V_DS_PHANMANH' table. You can move, or remove it, as needed.
            this.v_DS_PHANMANHTableAdapter.Fill(this.qLDSVDataSet.V_DS_PHANMANH);
            
            cbKhoa.SelectedIndex = 1;
            cbKhoa.SelectedIndex = 0;
            btnDangNhap.Select();
        }

        private void cbKhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Program.servername = cbKhoa.SelectedValue.ToString();

            }
            catch (NullReferenceException ex) { };
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            if (txtLogin.Text.Trim() == "" || txtPassword.Text.Trim() == "")
            {
                MessageBox.Show("Ban chua nhap tai khoan hoac password dang nhap", "Lỗi đăng nhập", MessageBoxButtons.OK);
                txtLogin.Focus();
                return;
            }
            Program.mlogin = txtLogin.Text;
            Program.mpassword = txtPassword.Text;
            if (Program.KetNoi() == 0) return;
            Program.LoginDN = Program.mlogin;
            Program.PasswordDN = Program.mpassword;
            Program.bds_dspm = new BindingSource();
            Program.bds_dspm = this.bdsDSPhanManh; //giu lai danh sach cac phan manh de dung cho cac subform sau
            Program.mKhoa = cbKhoa.SelectedIndex;
            string sqlcmd = "exec SP_DANGNHAP '" + Program.mlogin + "'";
            Program.myReader = Program.ExecSqlDataReader(sqlcmd);
            if (Program.myReader == null) return;
            Program.myReader.Read();
            Program.username = Program.myReader.GetString(0);
            if (Convert.IsDBNull(Program.username))
            {
                MessageBox.Show("Login này không có quyền truy cập dữ liệu");
                return;
            }
            Program.mHoten = Program.myReader.GetString(1);
            Program.mGroup = Program.myReader.GetString(2);
            Program.myReader.Close();
            Program.conn.Close();
            Program.fmain = new frmQuanLy();
            Program.fmain.Activate();
            Program.fmain.Show();
            Program.dangnhap.Hide();
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            DialogResult Out = MessageBox.Show("Bạn có chắc chắn muốn thoát?", "Thoát khỏi chương trình", MessageBoxButtons.OKCancel);
            if (Out == DialogResult.OK)
            {
                Program.flag = 0;
                Close();
            }
        }
    }
}
