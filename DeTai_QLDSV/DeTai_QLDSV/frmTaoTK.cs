using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace DeTai_QLDSV
{
    public partial class frmTaoTK : Form
    {
        int pos = 0;
        int thaotac = 0;
        string khoa = "";
        int thaotac_TK = 0;
        public frmTaoTK()
        {
            InitializeComponent();
            groupBox2.Visible = groupBox1.Enabled = false;
            if (Program.mGroup == "KHOA")
            {
                cmbKhoa.Enabled = false;
            }
            btnPhucHoi.Enabled = false;
        }
        private void frmTaoTK_Load(object sender, EventArgs e)
        {
            ControlBox = false;
            // TODO: This line of code loads data into the 'dS_DIEM.V_DSNHOM' table. You can move, or remove it, as needed.
            this.v_DSNHOMTableAdapter.Connection.ConnectionString = Program.connstr;
            this.v_DSNHOMTableAdapter.Fill(this.dS_DIEM.V_DSNHOM);
            if (Program.mGroup == "PGV") this.vDSNHOMBindingSource.Filter = "name NOT LIKE '%PKETOAN%'";
            else if (Program.mGroup == "KHOA") this.vDSNHOMBindingSource.Filter = "name NOT LIKE '%PKETOAN%' AND name NOT LIKE 'PGV'";
            else if (Program.mGroup == "PKETOAN") this.vDSNHOMBindingSource.Filter = "name LIKE '%PKETOAN%'";
            dS_DIEM.EnforceConstraints = false;
            // TODO: This line of code loads data into the 'dS_DIEM.GIANGVIEN' table. You can move, or remove it, as needed.
            this.gIANGVIENTableAdapter.Connection.ConnectionString = Program.connstr;
            this.gIANGVIENTableAdapter.Fill(this.dS_DIEM.GIANGVIEN);
            cmbKhoa.DataSource = Program.bds_dspm;
            cmbKhoa.DisplayMember = "TENCN";
            cmbKhoa.ValueMember = "TENSERVER";
            khoa = ((DataRowView)bdsGiangVien[0])["makh"].ToString();
        }
        private void TurnOn_Off_ButtonRole(string txtNhomQuyen, string Group)
        {
            if (bdsGiangVien.Position > 0) {
                if (((DataRowView)bdsGiangVien[bdsGiangVien.Position])["Magv"].ToString().Trim() == Program.username)
                {
                    btnCapQuyen.Enabled = false;
                    btnThuHoi.Enabled = false;
                }
            }
            if (Group == "PGV")
            {
                if (txtNhomQuyen == "")
                {
                    btnCapQuyen.Enabled = true;
                    btnThuHoi.Enabled = false;
                }
                else if (txtNhomQuyen == "PKETOAN")
                {
                    btnCapQuyen.Enabled = false;
                    btnThuHoi.Enabled = false;
                }
                else
                {
                    btnCapQuyen.Enabled = false;
                    btnThuHoi.Enabled = true;
                }

            }
            else if (Group == "PKETOAN")
            {
                if (txtNhomQuyen == "")
                {
                    btnCapQuyen.Enabled = true;
                    btnThuHoi.Enabled = false;
                }
                else if (txtNhomQuyen == "PKETOAN")
                {
                    btnCapQuyen.Enabled = false;
                    btnThuHoi.Enabled = true;
                }
                else
                {
                    btnCapQuyen.Enabled = false;
                    btnThuHoi.Enabled = false;
                }
            }
            else if (Group == "KHOA")
            {
                if (txtNhomQuyen == "")
                {
                    btnCapQuyen.Enabled = true;
                    btnThuHoi.Enabled = false;
                }
                else if (txtNhomQuyen == "PKETOAN" || txtNhomQuyen == "PGV")
                {
                    btnCapQuyen.Enabled = false;
                    btnThuHoi.Enabled = false;
                }
                else
                {
                    btnCapQuyen.Enabled = false;
                    btnThuHoi.Enabled = true;
                }
            }

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
                        this.gIANGVIENTableAdapter.Connection.ConnectionString = Program.connstr;
                        this.gIANGVIENTableAdapter.Fill(dS_DIEM.GIANGVIEN);
                        this.v_DSNHOMTableAdapter.Connection.ConnectionString = Program.connstr;
                        this.v_DSNHOMTableAdapter.Fill(this.dS_DIEM.V_DSNHOM);
                        fillToolStripButton_Click(sender, e);
                        TurnOn_Off_ButtonRole(lblNhomQuyen.Text, Program.mGroup);
                    }
                }
                catch (NullReferenceException ex) { };
            }
        }

        private void btnHoanTat_Click(object sender, EventArgs e)
        {
            if (thaotac_TK == 1)
            {
                if (txtTaiKhoan.Text.Trim() == "")
                {
                    MessageBox.Show("Tên tài khoản không được để trống!", "Cảnh báo", MessageBoxButtons.OK);
                    txtTaiKhoan.Focus();
                    return;
                }
                else if (txtMatKhau.Text.Trim() == "")
                {
                    MessageBox.Show("Bạn chưa nhập mật khẩu!", "Cảnh báo", MessageBoxButtons.OK);
                    txtMatKhau.Focus();
                    return;
                }
                else if (txtXacNhan.Text.Trim() == "")
                {
                    MessageBox.Show("Vui lòng xác nhận mật khẩu vừa nhập!", "Cảnh báo", MessageBoxButtons.OK);
                    txtXacNhan.Focus();
                    return;
                }
                else if (txtMatKhau.Text.Trim() != txtXacNhan.Text.Trim())
                {
                    MessageBox.Show("Mật khẩu xác nhận không đúng!", "Cảnh báo", MessageBoxButtons.OK);
                    txtXacNhan.Focus();
                    return;
                }

                string strLenh = "DECLARE	@return_value int EXEC @return_value = [dbo].[SP_check_Loginname] @loginName = N'" + txtTaiKhoan.Text + "' SELECT  'Return Value' = @return_value";
                if (Program.KetNoi() == 0) return;
                Program.myReader = Program.ExecSqlDataReader(strLenh);
                if (Program.myReader == null) return;
                Program.myReader.Read();
                int value = Program.myReader.GetInt32(0);
                if (value == 1)
                {
                    MessageBox.Show("Tên tài khoản đã tồn tại", "", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Program.myReader.Close();
                    return;
                }
                else if (value == 0)
                {

                    if (Program.KetNoi() == 0) return;
                    string sqlcmd = "EXEC SP_TAOLOGIN " + "'" + txtTaiKhoan.Text.ToUpper().Trim() + "'," + "'" + txtMatKhau.Text.Trim() + "'," + "'" + lblMaGV.Text.Trim() + "'," + "'" + cmbNhomQuyen.SelectedValue.ToString().Trim() + "'";
                    Program.myReader = Program.ExecSqlDataReader(sqlcmd);
                    MessageBox.Show("Đã cấp quyền thành công");
                    Program.conn.Close();
                }
                //if (myReader == null) return;
                //myReader.Read();
                //value = myReader.GetInt32(0);
                //myReader.Close();

            }
            else
            {
                try
                {
                    string strLenh = "EXEC Xoa_Login " + "'" + txtTaiKhoan.Text.ToUpper().Trim() + "'," + "'" + lblMaGV.Text.Trim() + "'";
                    SqlDataReader myReader;
                    myReader = Program.ExecSqlDataReader(strLenh);
                    MessageBox.Show("Đã thu hồi quyền!");
                    //if (myReader == null) return;
                    //myReader.Read();
                    myReader.Close();
                    Program.conn.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Không thể thu hồi quyền" + ex.Message);

                }
            }
            //if (value == 0) MessageBox.Show("Cấp quyền thành công");
            //else if (value == 1) MessageBox.Show("Login name bị trùng");
            //else if (value == 2) MessageBox.Show("User name bị trùng");
            txtTaiKhoan.Enabled = gcGiangVien.Enabled = true;
            groupBox2.Visible = false;
            thaotac = 0;
        }

        private void gvGiangVien_RowClick(object sender, DevExpress.XtraGrid.Views.Grid.RowClickEventArgs e)
        {

            fillToolStripButton_Click(sender, e);
            TurnOn_Off_ButtonRole(lblNhomQuyen.Text, Program.mGroup);
           
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
                if (rs == DialogResult.OK)
                {
                    this.vDSNHOMBindingSource.RemoveFilter();
                    this.Close();
                }
            }
        }

        private void btnPhucHoi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            bdsGiangVien.Position = pos;
            panel1.Enabled = btnTaiLai.Enabled = gcGiangVien.Enabled = true;
            groupBox1.Enabled = groupBox2.Visible = btnPhucHoi.Enabled = false;
            txtTaiKhoan.Text = txtMatKhau.Text = txtXacNhan.Text = "";
            fillToolStripButton_Click(sender, e);
            TurnOn_Off_ButtonRole(lblNhomQuyen.Text, Program.mGroup);
            thaotac = thaotac_TK = 0;
        }

        private void btnTaiLai_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
           //vDSNHOMBindingSource.RemoveFilter();          
            this.gIANGVIENTableAdapter.Fill(this.dS_DIEM.GIANGVIEN);
            groupBox2.Visible = false;
            fillToolStripButton_Click(sender, e);
            TurnOn_Off_ButtonRole(lblNhomQuyen.Text, Program.mGroup);
        }

        private void btnCapQuyen_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (thaotac == 1)
            {
                if (txtTaiKhoan.Text != "")
                {
                    txtTaiKhoan.Text = "";
                }
                if (txtMatKhau.Text != "")
                {
                    txtMatKhau.Text = "";
                }
                if (txtXacNhan.Text != "")
                {
                    txtXacNhan.Text = "";
                }
            }
            lblMaGV.Text = txtMaGV.Text.Trim();
            btnPhucHoi.Enabled = groupBox2.Visible = txtMatKhau.Enabled = txtXacNhan.Enabled = cmbNhomQuyen.Enabled = true;
            cmbKhoa.Enabled = groupBox1.Enabled =gcGiangVien.Enabled =false;
            txtTaiKhoan.Focus();
            thaotac_TK = 1;
        }

        private void btnThuHoi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

            DialogResult rs = MessageBox.Show("Bạn có chắc chắn muốn thu hồi quyền của giảng viên này?", "Thông báo", MessageBoxButtons.YesNo);
            if (rs == DialogResult.Yes)
            {
                if (Program.KetNoi() == 0)
                    return;
                string strLenh = "exec SP_GetLoginName_By_UserName '" + txtMaGV.Text.Trim() + "'";
                SqlDataReader myReader;
                myReader = Program.ExecSqlDataReader(strLenh);
                if (myReader == null)
                    return;
                myReader.Read();
                string Login = myReader.GetString(0);
                myReader.Close();
                Program.conn.Close();
                cmbNhomQuyen.SelectedValue = lblNhomQuyen.Text;
                txtTaiKhoan.Text = Login;
                lblMaGV.Text = txtMaGV.Text.Trim();
                txtTaiKhoan.Enabled = false;
                txtMatKhau.Text = txtXacNhan.Text = "********";
                cmbNhomQuyen.Enabled = txtMatKhau.Enabled = txtXacNhan.Enabled = groupBox1.Enabled = false;
                groupBox2.Visible = btnPhucHoi.Enabled = true;
                thaotac_TK = 2;
            }
        }

        private void gvGiangVien_FocusedRowChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs e)
        {
            fillToolStripButton_Click(sender, e);
            TurnOn_Off_ButtonRole(lblNhomQuyen.Text, Program.mGroup);
            //if (Program.KetNoi() == 0)
            //    return;
            //if (bdsGiangVien.Position > -1)
            //{
            //    try
            //    {
            //        string sqlcmd = "exec sp_InNhomQuyen '" + txtMaGV.Text.Trim() + "'";
            //        Program.myReader = Program.ExecSqlDataReader(sqlcmd);
            //        if (Program.myReader == null) return;
            //        Program.myReader.Read();
            //        lblNhomQuyen.Text = Program.myReader.GetString(0);
            //    }
            //    catch (InvalidOperationException ex)
            //    {
            //        lblNhomQuyen.Text = "";
            //    }
            //}

        }



        private void gvGiangVien_FocusedRowObjectChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowObjectChangedEventArgs e)
        {
            fillToolStripButton_Click(sender, e);
            TurnOn_Off_ButtonRole(lblNhomQuyen.Text, Program.mGroup);
            //if (Program.KetNoi() == 0)
            //    return;
            //if (bdsGiangVien.Position > -1)
            //{
            //    try
            //    {
            //        string sqlcmd = "exec sp_InNhomQuyen '" + txtMaGV.Text.Trim() + "'";
            //        Program.myReader = Program.ExecSqlDataReader(sqlcmd);
            //        if (Program.myReader == null) return;
            //        Program.myReader.Read();
            //        lblNhomQuyen.Text = Program.myReader.GetString(0);
            //    }
            //    catch (InvalidOperationException ex)
            //    {
            //        lblNhomQuyen.Text = "";
            //    }
            //}

        }

        private void fillToolStripButton_Click(object sender, EventArgs e)
        {
            try
            {
                this.sp_InNhomQuyenTableAdapter.Connection.ConnectionString = Program.connstr;
                this.sp_InNhomQuyenTableAdapter.Fill(this.dS_DIEM.sp_InNhomQuyen, txtMaGV.Text);
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }

        }
    }
}
