using DevExpress.XtraReports.UI;
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
    public partial class frmHocPhi : Form
    {
        //SqlDataReader myReader;
        int soluong = 0;
        int thaotac = 0, col = 0, row = 0;
        DataTable dtHocPhi;
        public frmHocPhi()
        {
            InitializeComponent();
            ((TextBox)txtNienKhoa.Controls[1]).MaxLength = 4;
            ((TextBox)txtHocKy.Controls[1]).MaxLength = 1;
            //Format = "N2";
            //DefaultCellStyle.Format = "#,###.##";
            txtHo.Enabled = txtTen.Enabled = txtMaLop.Enabled = gbTTSV.Enabled = gbDSHP.Enabled = gvHocPhi.Visible = btnGhi.Enabled = btnThem.Enabled = btnHieuChinh.Enabled = btnPhucHoi.Enabled = gbDSHP.Visible = false;
            if (Program.Ketnoi_HP() == 0) return;
        }

        private void btnBatDau_Click(object sender, EventArgs e)
        {
            if (txtMaSV.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập mã sinh viên cần tra cứu", "Thông báo", MessageBoxButtons.OK);
                txtMaSV.Focus();
                return;
            }
            txtMaSV.Text = txtMaSV.Text.ToUpper();
            btnBatDau.Enabled = false;
            btnGhi.Enabled = true;
            try
            {
                
                string strLenh = " select HO,TEN,MALOP FROM SINHVIEN WHERE  MASV =  '" + txtMaSV.Text.Trim() + "'";
                Program.myReader = Program.ExecSqlDataReader(strLenh);
                if (Program.myReader == null) return;
                Program.myReader.Read();
                txtHo.Text = Program.myReader.GetString(0).ToUpper();
                txtTen.Text = Program.myReader.GetString(1).ToUpper();
                txtMaLop.Text = Program.myReader.GetString(2).ToUpper();
                Program.myReader.Close();
                Program.conn.Close();
            }
            catch (InvalidOperationException ex)
            {
                MessageBox.Show("Sinh viên không tồn tại", "Thông báo", MessageBoxButtons.OK);
                btnGhi.Enabled = false;
                btnBatDau.Enabled = true;
                txtMaSV.Focus();
                Program.myReader.Close();
                Program.conn.Close();
                return;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Thông báo", MessageBoxButtons.OK);
                btnGhi.Enabled = false;
                btnBatDau.Enabled = true;
                txtMaSV.Focus();
                Program.myReader.Close();
                Program.conn.Close();
                return;
            }
            txtMaSV.Enabled = false;
            btnThem.Enabled = btnHieuChinh.Enabled = gbTTSV.Enabled = gvHocPhi.Visible = true;
            string sqlcmd = "SELECT MASV,NIENKHOA,HOCKY,HOCPHI,SOTIENDADONG FROM HOCPHI WHERE MASV = '" + txtMaSV.Text.Trim().ToString() + "'";
            dtHocPhi = Program.ExecSqlQuery(sqlcmd, Program.connstr);
            gvHocPhi.DataSource = dtHocPhi;
            gvHocPhi.Columns[0].Visible = false;
            soluong = gvHocPhi.RowCount;

            if (soluong == 0)
            {
                MessageBox.Show("Học phí của sinh viên chưa được khởi tạo, hãy khởi tạo", "Thông báo", MessageBoxButtons.OK);
                return;
            }
            for (int i = 0; i < soluong; i++)
            {
                gvHocPhi.Rows[i].ReadOnly = true;
            }
        }

        private void btnTailai_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            gvHocPhi.CancelEdit();
            txtMaSV.Text = txtMaLop.Text = txtHo.Text = txtTen.Text = "";
            gvHocPhi.Visible = gbTTSV.Enabled = btnGhi.Enabled = btnPhucHoi.Enabled = false;
            txtMaSV.Enabled = btnBatDau.Enabled = true;
        }
        private int CheckContraint_HocPhi(DataGridView gv)
        {
            if (gv.RowCount > 0)
            {
                 if (gv.Rows[gv.RowCount - 1].Cells[1].Value.ToString() == "" && gv.Rows[gv.RowCount - 1].Cells[2].Value.ToString() == "" && gv.Rows[gv.RowCount - 1].Cells[3].Value.ToString() == "" )                
                    gv.Rows.RemoveAt(gv.RowCount - 1);
                      
                if (gv.Rows[gv.RowCount - 1].Cells[1].Value.ToString() == "")
                {
                    MessageBox.Show("Niên khóa không được để trống", "Thông báo", MessageBoxButtons.OK);
                    gv.Rows[gv.RowCount - 1].Cells[1].Selected = true;
                    return 1;
                }
                else if (gv.Rows[gv.RowCount - 1].Cells[2].Value.ToString() == "")
                {
                    MessageBox.Show("Học kỳ không được để trống", "Thông báo", MessageBoxButtons.OK);
                    gv.Rows[gv.RowCount - 1].Cells[2].Selected = true;
                    return 1;
                }
                else if (gv.Rows[gv.RowCount - 1].Cells[3].Value.ToString() == "")
                {
                    MessageBox.Show("Chưa nhập học phí", "Thông báo", MessageBoxButtons.OK);
                    gv.Rows[gv.RowCount - 1].Cells[3].Selected = true;
                    return 1;
                }

                else if ((int)gv.Rows[gv.RowCount - 1].Cells[3].Value <= 0)
                {
                    MessageBox.Show("Học phí không hợp lệ", "Thông báo", MessageBoxButtons.OK);
                    gv.Rows[gv.RowCount - 1].Cells[3].Selected = true;
                    return 1;
                }
                
                
            }
            return 0;
        }

        private int Check_FK_ToSave(DataGridView gv, int Rowcount)
        {
            if (Rowcount <= 1) return -1;
            for (int i = 0; i < Rowcount; i++)
                for (int j = i + 1; j < Rowcount; j++)
                    if ((gvHocPhi.Rows[i].Cells[1].Value.ToString() == gvHocPhi.Rows[j].Cells[1].Value.ToString()) && (gvHocPhi.Rows[i].Cells[2].Value.ToString() == gvHocPhi.Rows[j].Cells[2].Value.ToString()))
                        return j;
            return -1;
        }
        private void btnThem_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            btnHieuChinh.Enabled = false;
            if (CheckContraint_HocPhi(gvHocPhi) == 1) return;
            if (gvHocPhi.RowCount > 1)
                for (int i = 0; i < gvHocPhi.RowCount - 1; i++)
                {
                    if ((gvHocPhi.Rows[i].Cells[1].Value.ToString() == gvHocPhi.Rows[gvHocPhi.RowCount - 1].Cells[1].Value.ToString()) && (gvHocPhi.Rows[i].Cells[2].Value.ToString() == gvHocPhi.Rows[gvHocPhi.RowCount - 1].Cells[2].Value.ToString()))
                    {
                        MessageBox.Show("Thông tin học phí của sinh viên bị trùng lặp", "Thông báo", MessageBoxButtons.OK);
                        return;
                    }
                }
            btnThem.Enabled = btnBatDau.Enabled = txtMaSV.Enabled = false;
            btnGhi.Enabled = true;
            dtHocPhi.Rows.Add();
            gvHocPhi.Rows[gvHocPhi.RowCount - 1].Cells[0].Value = txtMaSV.Text.Trim();
            gvHocPhi.Rows[gvHocPhi.RowCount - 1].Cells[4].Value = 0;
            thaotac = 1;
        }

        private void btnPhucHoi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (dtHocPhi != null)
            {
                dtHocPhi.Clear();
                Program.da.Fill(dtHocPhi);
            }
            gbDSHP.Visible = btnPhucHoi.Enabled = btnGhi.Enabled = false;
            btnThem.Enabled = btnHieuChinh.Enabled = true;
        }

        private void btnHieuChinh_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            btnPhucHoi.Enabled = false;
            btnThem.Enabled = btnHieuChinh.Enabled = false;
            for (int i = 0; i < gvHocPhi.RowCount; i++)
            {
                gvHocPhi.Rows[i].Cells[4].ReadOnly = false;
            }
            thaotac = 2;
        }

        private void btnIn_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            groupBox1.Enabled = gbDSHP.Visible = gbDSHP.Enabled = btnPhucHoi.Enabled = true;

        }



        private void btnPrint_Click(object sender, EventArgs e)
        {
            string nienkhoa = txtNienKhoa.Value.ToString();
            int hocky = (int)txtHocKy.Value;
            //if (Program.Ketnoi_HP() == 0) return;
            rptDanhSachDongHocPhi rpt = new rptDanhSachDongHocPhi(cmbLop.SelectedValue.ToString(), nienkhoa, hocky);
            rpt.lblTieuDe.Text = "DANH SÁCH ĐÓNG HỌC PHÍ CỦA LỚP " + cmbLop.Text;
            //rpt.lblHoTen.Text = cmbHoten.Text;
            ReportPrintTool print = new ReportPrintTool(rpt);
            print.ShowPreviewDialog();

        }



        private void frmHocPhi_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'dS_HOCPHI.SINHVIEN' table. You can move, or remove it, as needed.
            this.sINHVIENTableAdapter.Fill(this.dS_HOCPHI.SINHVIEN);
            // TODO: This line of code loads data into the 'dS_HOCPHI.LOP' table. You can move, or remove it, as needed.
            this.lOPTableAdapter.Fill(this.dS_HOCPHI.LOP);
        }

        private void gvHocPhi_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            e.Control.KeyPress -= new KeyPressEventHandler(gvHocPhi_KeyPress);

            TextBox txt = e.Control as TextBox;
            if (txt != null)
            {
                txt.KeyPress += new KeyPressEventHandler(gvHocPhi_KeyPress);
            }
        }

        private void gvHocPhi_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            if (gvHocPhi[2, e.RowIndex].Value.ToString() != String.Empty && Convert.ToInt32(gvHocPhi.Rows[e.RowIndex].Cells[2].Value) > 2)
            {
                gvHocPhi.Rows[e.RowIndex].Cells[2].Value = 2;
            }
            if (gvHocPhi.Rows[gvHocPhi.RowCount - 1].Cells[4].Value.ToString() == "")
            {
                gvHocPhi.Rows[gvHocPhi.RowCount - 1].Cells[4].Value = "0";
            }
            if (gvHocPhi[3, e.RowIndex].Value.ToString() != String.Empty && gvHocPhi[4, e.RowIndex].Value.ToString() != String.Empty && (Convert.ToInt32(gvHocPhi.Rows[e.RowIndex].Cells[4].Value) > Convert.ToInt32(gvHocPhi.Rows[e.RowIndex].Cells[3].Value)) )
            {
                MessageBox.Show("Số tiền đã đóng không thể lớn hơn học phí ", "Thông báo", MessageBoxButtons.OK);
                gvHocPhi.Rows[e.RowIndex].Cells[4].Value = gvHocPhi.Rows[e.RowIndex].Cells[3].Value;
                gvHocPhi.Rows[e.RowIndex].Cells[3].Selected = true;             
            }
            if((gvHocPhi[1, e.RowIndex].Value.ToString() != String.Empty) && (gvHocPhi[2, e.RowIndex].Value.ToString() != String.Empty) && (Convert.ToInt32(gvHocPhi.Rows[e.RowIndex].Cells[2].Value) == 2))
            {
                int row = e.RowIndex;
                for (int i = row - 1; i >= 0; i--)
                {
                    if (!((gvHocPhi[1, e.RowIndex].Value.ToString() == gvHocPhi[1, i].Value.ToString())&& Convert.ToInt32(gvHocPhi.Rows[e.RowIndex].Cells[2].Value) == 1)){
                        MessageBox.Show("Thông tin học phí học kỳ 1 của năm học này chưa được khởi tạo ", "Thông báo", MessageBoxButtons.OK);
                        gvHocPhi.Rows[e.RowIndex].Cells[2].Selected = true;
                        break;
                    }
                }
            }
            
            
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void gvHocPhi_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != (char)8)
            {
                if (!System.Text.RegularExpressions.Regex.IsMatch(e.KeyChar.ToString(), "\\d+"))
                {
                    e.Handled = true;
                }
            }
        }

        private void btnGhi_Click(object sender, EventArgs e)
        {           
                try
                {
                    if (CheckContraint_HocPhi(gvHocPhi) == 1) return;
                       int check = Check_FK_ToSave(gvHocPhi, gvHocPhi.RowCount);
                    if (check == -1)
                    {
                        if (Program.Ketnoi_HP() == 0) return;
                        //string cmddelete = "delete from HOCPHI where MASV ='" +txtMaSV.Text.ToString() + "' ";
                        //SqlCommand sqlcmd = new SqlCommand(cmddelete, Program.conn);
                        //sqlcmd.ExecuteNonQuery();
                        SqlCommandBuilder cmdbl = new SqlCommandBuilder(Program.da);
                        Program.da.Update(dtHocPhi);
                        MessageBox.Show("Đã ghi dữ liệu thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    if (dtHocPhi != null)
                    {
                        dtHocPhi.Clear();
                        Program.da.Fill(dtHocPhi);
                        txtHo.Text = txtTen.Text = txtMaSV.Text =txtMaLop.Text ="";
                        gvHocPhi.Visible = false;
                    }

                }
                    else
                    {                  
                        MessageBox.Show("Thông tin học phí của niên khóa trong năm học này đã tồn tại \n" , "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        gvHocPhi.CancelEdit();
                        gvHocPhi.CurrentCell = gvHocPhi.Rows[check].Cells[1];
                        //gvHocPhi.CurrentCell.Selected = true;
                        btnThem.Enabled = btnHieuChinh.Enabled = btnBatDau.Enabled = btnGhi.Enabled = true;
                        return;
                    }
                }
                catch (SqlException ex)
                {

                    MessageBox.Show("Thông tin học phí của niên khóa trong năm học này đã tồn tại \n" + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    col = gvHocPhi.CurrentCell.ColumnIndex;
                    row = gvHocPhi.CurrentCell.RowIndex;
                    gvHocPhi.RefreshEdit();
                    //Program.da.Fill(dtHocPhi);
                    gvHocPhi.CancelEdit();
                    gvHocPhi.CurrentCell = gvHocPhi.Rows[row].Cells[1];
                    gvHocPhi.CurrentCell.Selected = true;
                    btnThem.Enabled = btnHieuChinh.Enabled = btnBatDau.Enabled = btnGhi.Enabled = true;
                    return;
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.GetType().ToString() + "\n" + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    col = gvHocPhi.CurrentCell.ColumnIndex;
                    row = gvHocPhi.CurrentCell.RowIndex;
                    dtHocPhi.Clear();
                    Program.da.Fill(dtHocPhi);
                    gvHocPhi.CurrentCell = gvHocPhi.Rows[row].Cells[col];
                    gvHocPhi.CurrentCell.Selected = true;
                    btnThem.Enabled = btnHieuChinh.Enabled = btnBatDau.Enabled = btnGhi.Enabled = true;
                    return;
                }
                btnHieuChinh.Enabled = btnThem.Enabled = txtMaSV.Enabled= btnBatDau.Enabled= true;
                btnGhi.Enabled = btnPhucHoi.Enabled= false;
            }
        }
    }
