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
    public partial class frmDiem : DevExpress.XtraEditors.XtraForm
    {
        DataSet ds = null;
        int value = -1;
        DataTable table = null;
        //int success = 0;
        public frmDiem()
        {
            InitializeComponent();
            btnUndo.Enabled = btnGhi.Enabled = false;
            cmbKhoa.DataSource = Program.bds_dspm;
            cmbKhoa.DisplayMember = "TENCN";
            cmbKhoa.ValueMember = "TENSERVER";
            cmbKhoa.SelectedIndex = Program.mKhoa;
            turnOnOff_Button();
            dtgvDiem.Visible = false;
        }
        private void turnOnOff_Button()
        {
            if (Program.mGroup == "USER")
            {
                btnPrint.Enabled = cmbKhoa.Enabled = false;

            }
            else if (Program.mGroup == "KHOA")
            {
                cmbKhoa.Enabled = false;
                btnPrint.Enabled = true;

            }
            else btnPrint.Enabled = true;
        }
        private DataSet GetDataSet(string sqlCommand)
        {
            DataSet data = new DataSet();
            SqlCommand cmd = new SqlCommand(sqlCommand, Program.conn);
            cmd.Connection.Open();
            table = new DataTable();
            table.Load(cmd.ExecuteReader());
            data.Tables.Add(table);
            return data;
        }
        private int check_CellBlank()
        {
            int result = -1;
            for (int i = 0; i < dtgvDiem.Rows.Count; i++)
            {
                if (dtgvDiem[2, i].Value.ToString() == String.Empty)
                {
                    dtgvDiem.CurrentCell = dtgvDiem.Rows[i].Cells[2];
                    MessageBox.Show("Bạn chưa nhập điểm cho sinh viên này", "", MessageBoxButtons.OK);
                    return i;
                }
            }
            return result;
        }
        private void Insert_DIEM()
        {
            dtgvDiem.CancelEdit();
            if (Program.KetNoi() == 0) return;
            string ins_upd_cmd = "insert into DIEM(MASV,MAMH,LAN,DIEM) values(@MASV,@MAMH,@LAN,CAST(@DIEM AS FLOAT));";
            for (int i = 0; i < dtgvDiem.RowCount; i++)
            {
                using (SqlConnection connection = new SqlConnection(Program.connstr))
                using (SqlCommand cm = new SqlCommand(ins_upd_cmd, connection))
                {
                    cm.Parameters.AddWithValue("@MASV", dtgvDiem.Rows[i].Cells[0].Value.ToString());
                    cm.Parameters.AddWithValue("@MAMH", cmbMonHoc.SelectedValue.ToString());
                    cm.Parameters.AddWithValue("@LAN", txtLanThi.Value);
                    cm.Parameters.AddWithValue("@DIEM", dtgvDiem.Rows[i].Cells[2].Value);
                    connection.Open();
                    try
                    {
                        cm.ExecuteNonQuery();

                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Lưu điểm thất bại" + ex.Message);
                        connection.Close();
                        return;
                    }
                    connection.Close();
                }
            }
            MessageBox.Show("Đã ghi điểm thành công");
        }
        private void Update_DIEM()
        {
            string udt_upd_cmd = "UPDATE dbo.DIEM SET DIEM = @DIEM WHERE MASV = @MASV and MAMH = @MAMH and LAN = @LAN";
            if (Program.KetNoi() == 0) return;
            for (int i = 0; i < dtgvDiem.RowCount; i++)
            {

                using (SqlConnection connection = new SqlConnection(Program.connstr))
                using (SqlCommand cm = new SqlCommand(udt_upd_cmd, connection))
                {
                    cm.Parameters.AddWithValue("@MASV", dtgvDiem.Rows[i].Cells[0].Value.ToString());
                    cm.Parameters.AddWithValue("@MAMH", cmbMonHoc.SelectedValue.ToString());
                    cm.Parameters.AddWithValue("@LAN", txtLanThi.Value);
                    cm.Parameters.AddWithValue("@DIEM", dtgvDiem.Rows[i].Cells[2].Value);
                    connection.Open();
                    try
                    {

                        cm.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Lưu điểm thất bại!");
                        connection.Close();
                        return;
                    }
                    connection.Close();
                }
            }
            MessageBox.Show("Đã cập nhật điểm mới thành công");
        }
        public void LoadDiem()
        {
            string sqlcmd = "EXEC[dbo].[SP_LoadDiem] @malop = N'" + cmbLop.SelectedValue.ToString() + "', @mamh = N'" + cmbMonHoc.SelectedValue.ToString() + "', @lan = " + txtLanThi.Value;
            ds = GetDataSet(sqlcmd);
            dtgvDiem.DataSource = table;
            dtgvDiem.Columns[2].DefaultCellStyle.Format = "N1";
        }

        private void btnBatDau_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (ds != null)
                ds.Clear();
            if (Program.KetNoi() == 0) return;
            //Excute SP_CheckExists_DiemSV để biết trạng thái của bảng điểm của lớp đó
            string cmd = "DECLARE	@return_value int EXEC @return_value = [dbo].[SP_CheckExists_DiemSV]  @MaLop = N'" + cmbLop.SelectedValue.ToString().Trim() + "',@MaMH = N'" + cmbMonHoc.SelectedValue.ToString().Trim() + "',@Lan = " + txtLanThi.Value + "SELECT  'Return Value' = @return_value";
            SqlDataReader myReader;
            myReader = Program.ExecSqlDataReader(cmd);
            if (myReader == null) return;
            myReader.Read();
            value = myReader.GetInt32(0);
            myReader.Close();
            Program.conn.Close();
            if (txtLanThi.Value == 1)
            {
                if (value == 0)// Bảng điểm không tồn tại trong CSDL => nhập điểm lần đầu
                {
                    DialogResult rs = MessageBox.Show("Chưa có điểm thi lần 1, bạn có muốn khởi tạo?", "Điểm thi không tồn tại", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                    if (rs == DialogResult.Yes)
                    {
                        LoadDiem();
                    }
                    else
                    {
                        btnBatDau.Enabled = true;
                        btnGhi.Enabled = false;
                        return;
                    }
                }
                else
                {
                    LoadDiem();
                }
            }
            else
            {
                if (value == 0)
                {
                    MessageBox.Show("Chưa có điểm thi lần 1 nên không thể khởi tạo điểm thi lần 2", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    btnBatDau.Enabled = true;
                    btnGhi.Enabled = false;
                    return;
                }
                else if (value == 1)
                {
                    DialogResult rs = MessageBox.Show("Chưa có điểm thi lần 2, bạn có muốn khởi tạo?", "Điểm thi không tồn tại", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                    if (rs == DialogResult.Yes)
                    {
                        LoadDiem();
                    }
                    else return;
                }
                else
                {
                    LoadDiem();
                }
            }
            cmbKhoa.Enabled = groupBox1.Enabled = btnBatDau.Enabled = btnPrint.Enabled = false;
            dtgvDiem.Visible = btnGhi.Enabled = btnUndo.Enabled = true;
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
                    v_DSLOP_Tontai_SVTableAdapter.Connection.ConnectionString = Program.connstr;
                    this.v_DSLOP_Tontai_SVTableAdapter.Fill(this.dS_DIEM.V_DSLOP_Tontai_SV);
                }
                catch (NullReferenceException ex) { };
            }
        }

        private void frmDiem_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'dS_DIEM.V_DSLOP_Tontai_SV' table. You can move, or remove it, as needed.
            this.v_DSLOP_Tontai_SVTableAdapter.Connection.ConnectionString = Program.connstr;
            this.v_DSLOP_Tontai_SVTableAdapter.Fill(this.dS_DIEM.V_DSLOP_Tontai_SV);
            // TODO: This line of code loads data into the 'dS_DIEM.V_DS_MonHoc' table. You can move, or remove it, as needed.
            this.v_DS_MonHocTableAdapter.Connection.ConnectionString = Program.connstr;
            this.v_DS_MonHocTableAdapter.Fill(this.dS_DIEM.V_DS_MonHoc);
        }

        private void btnThoat_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (btnBatDau.Enabled == false)
            {
                DialogResult rs = MessageBox.Show("Dữ liệu vừa nhập chưa được ghi vào CSDL, bạn có chắc chắn muốn thoát?", "Cảnh báo", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                if (rs == DialogResult.Yes)
                    this.Close();
            }
            else
            {
                DialogResult rs = MessageBox.Show("Bạn có chắc chắn muôn đóng form Điểm ?", "Thoát", MessageBoxButtons.OKCancel);
                if (rs == DialogResult.OK)
                    this.Close();
            }
        }

        private void btnGhi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (check_CellBlank() != -1)
                return;

            if (txtLanThi.Value == 1)
            {
                if (value == 0)
                    Insert_DIEM();
                else if (value == 1)
                    Update_DIEM();
            }
            else
            {
                if (value == 1)
                    Insert_DIEM();
                else if (value == 2)
                    Update_DIEM();
            }
            cmbKhoa.Enabled = groupBox1.Enabled = btnBatDau.Enabled = true;
            dtgvDiem.Visible = btnGhi.Enabled = false;

        }

        private void btnUndo_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (ds != null)
                ds.Clear();
            btnBatDau.Enabled = cmbKhoa.Enabled =groupBox1.Enabled =true;
            btnUndo.Enabled = btnGhi.Enabled = dtgvDiem.Visible = btnXem.Enabled = false;
            turnOnOff_Button();
        }

        private void dtgvDiem_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            e.Control.KeyPress -= new KeyPressEventHandler(dtgvDiem_KeyPress);
            if (dtgvDiem.CurrentCell.ColumnIndex == 2)//cot Diem
            {
                TextBox txt = e.Control as TextBox;
                if (txt != null)
                {
                    txt.KeyPress += new KeyPressEventHandler(dtgvDiem_KeyPress);
                }
            }
        }

        private void dtgvDiem_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '.' && e.KeyChar != (char)8)
            {
                if (!System.Text.RegularExpressions.Regex.IsMatch(e.KeyChar.ToString(), "\\d+"))
                {
                    e.Handled = true;
                }
            }
        }

        private void dtgvDiem_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                if (dtgvDiem[2, e.RowIndex].Value.ToString() != String.Empty && Convert.ToInt32(dtgvDiem.Rows[e.RowIndex].Cells[2].Value) > 10)
                {
                    dtgvDiem.Rows[e.RowIndex].Cells[2].Value = 10;
                }
            }catch(NullReferenceException ex) { }

        }

        private void btnPrint_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            groupBox1.Enabled = btnXem.Enabled = btnUndo.Enabled = true;
            btnPrint.Enabled = btnBatDau.Enabled = false;
        }

        private void btnXem_Click(object sender, EventArgs e)
        {
            if (Program.KetNoi() == 0) return;
            int lanthi = (int)txtLanThi.Value;
            rptBangDiemMonHoc rpt = new rptBangDiemMonHoc(cmbLop.SelectedValue.ToString(), cmbMonHoc.SelectedValue.ToString(), lanthi);
            rpt.lblLop.Text = cmbLop.Text;
            rpt.lblMonhoc.Text = cmbMonHoc.Text;
            rpt.lblLanThi.Text = txtLanThi.Value.ToString();
            ReportPrintTool print = new ReportPrintTool(rpt);
            print.ShowPreviewDialog();
        }
    }
}