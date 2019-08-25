using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using DevExpress.UserSkins;
using DevExpress.Skins;
using DevExpress.LookAndFeel;
using System.Data.SqlClient;
using System.Data;

namespace DeTai_QLDSV
{
    static class Program
    {
        /// <summary>
        public static int flag = 1;
        public static SqlConnection conn;
        public static string connstr = "";
        public static SqlDataAdapter da;
        public static SqlDataReader myReader;
        public static string servername = "";
        public static string username = "";
        public static string remoteLogin = "HTKN";
        public static string remotepass = "htkn";
        public static string LoginDN = "";//luu lai Login dang nhap ban dau tai phan manh dau tien chon
        public static string PasswordDN = ""; //luu lai password dang nhap ban dau tai phan manh dau tien chon
        public static string mHoten = "";//in ho va ten user da dang nhap
        public static string database = "QLDSV";
        public static string mlogin = "";
        public static string mpassword = "";
        public static string mGroup = "";// de chon nhung muc phu hop voi group
        public static int mKhoa;
        public static frmDangNhap dangnhap;
        public static frmQuanLy fmain;
        //public static frmLop flop;
        public static frmLop1 flop;
        public static frmMonHoc fMonHoc;
        public static frmDiem fDiem;
        public static frmTaoTK fTaikhoan;
        public static frmHocPhi fHocPhi;
        public static BindingSource bds_dspm/* = new BindingSource()*/;
        public static int KetNoi()
        {
            if (Program.conn != null && Program.conn.State == ConnectionState.Open) Program.conn.Close();
            try
            {

                Program.connstr = "Data Source=" + Program.servername + ";Initial Catalog=" + Program.database + ";User ID=" +
                      Program.mlogin + ";password=" + Program.mpassword;

                conn = new SqlConnection(connstr);
                Program.conn.ConnectionString = Program.connstr;
                Program.conn.Open();
                return 1;
            }
            catch (Exception e)
            {
                MessageBox.Show("Lỗi kết nối cơ sở dữ liệu.\nBạn xem lại user name và password.\n " + e.Message, "", MessageBoxButtons.OK);
                return 0;
            }
        }
        public static int Ketnoi_HP()
        {

            if (Program.conn != null && Program.conn.State == ConnectionState.Open) Program.conn.Close();
            try
            {

                Program.connstr = @"Data Source= DESKTOP-FR28U9S\SERVER_04" + ";Initial Catalog=" + Program.database + ";User ID=" +
                      Program.remoteLogin + ";password=" + Program.remotepass;
                conn = new SqlConnection(connstr);
                Program.conn.ConnectionString = Program.connstr;
                Program.conn.Open();
                return 1;
            }
            catch (Exception e)
            {
                MessageBox.Show("Lỗi kết nối cơ sở dữ liệu.\nBạn xem lại user name và password.\n " + e.Message, "", MessageBoxButtons.OK);
                return 0;
            }
        }
        public static SqlDataReader ExecSqlDataReader(String cmd)
        {
            SqlDataReader myreader;
            SqlCommand sqlcmd = new SqlCommand(cmd, Program.conn);
            sqlcmd.CommandType = CommandType.Text;
            sqlcmd.CommandTimeout = 660;
            if (Program.conn.State == ConnectionState.Closed) Program.conn.Open();
            try
            {
                myreader = sqlcmd.ExecuteReader(); return myreader;
            }
            catch (SqlException ex)
            {
                Program.conn.Close();
                MessageBox.Show(ex.Message);
                return null;
            }
            catch(InvalidOperationException ex)
            {
                Program.conn.Close();
                return null;
            }
        }

        public static DataTable ExecSqlQuery(String cmd, String connectionstring)
        {
            DataTable dt1 = new DataTable();
            conn = new SqlConnection(connectionstring);
            da = new SqlDataAdapter(cmd, conn);
            da.Fill(dt1);
            return dt1;
        }


        public static int ExecSqlNonQuery(String cmd, String connectionstring)
        {
            conn = new SqlConnection(connectionstring);
            SqlCommand Sqlcmd = new SqlCommand();
            Sqlcmd.Connection = conn;
            Sqlcmd.CommandText = cmd;
            Sqlcmd.CommandType = CommandType.Text;
            Sqlcmd.CommandTimeout = 660;
            if (conn.State == ConnectionState.Closed) conn.Open();
            //try
            //{

                Sqlcmd.ExecuteNonQuery(); conn.Close(); return 1;
           //}
            //catch (SqlException ex)
            //{
            //    MessageBox.Show(ex.Message);
            //    conn.Close();
            //    return 0;
            //}
        }
        
        ///// The main entry point for the application.
        public static int GetReturnValue_TimID(string SP_Name, string ID, int solan)
        {
            int value = -1;
            string strLenh = "DECLARE @return_value int EXEC  @return_value =" + SP_Name + "'" + ID.ToUpper().Trim() + "', " + solan + " SELECT 'Return Value' = @return_value";
            SqlDataReader myReader;
            myReader = Program.ExecSqlDataReader(strLenh);
            if (myReader == null) return value;
            myReader.Read();
            value = myReader.GetInt32(0);
            myReader.Close();
            Program.conn.Close();
            return value;
        }

        public static int GetReturnValueById(string SP_Name, string ID)
        {
            int value = -1;
            string strLenh = "DECLARE @return_value int EXEC  @return_value =" + SP_Name + "'" + ID.ToUpper().Trim() +  " SELECT 'Return Value' = @return_value";
            SqlDataReader myReader;
            myReader = Program.ExecSqlDataReader(strLenh);
            if (myReader == null) return value;
            myReader.Read();
            value = myReader.GetInt32(0);
            myReader.Close();
            Program.conn.Close();
            return value;
        }
        private static string Chu(string gNumber)
        {
            string result = "";
            switch (gNumber)
            {
                case "0":
                    result = "không";
                    break;
                case "1":
                    result = "một";
                    break;
                case "2":
                    result = "hai";
                    break;
                case "3":
                    result = "ba";
                    break;
                case "4":
                    result = "bốn";
                    break;
                case "5":
                    result = "năm";
                    break;
                case "6":
                    result = "sáu";
                    break;
                case "7":
                    result = "bảy";
                    break;
                case "8":
                    result = "tám";
                    break;
                case "9":
                    result = "chín";
                    break;
            }
            return result;
        }
        private static string Donvi(int so)
        {
            string donvi = "";

            if (so==1)
                donvi = "";
            if (so==2)
                donvi = "nghìn";
            if (so==3)
                donvi = "triệu";
            if (so==4)
                donvi = "tỷ";
            return donvi;
        }
        private static string Tach(string tach3)
        {
            string Ktach = "";
            if (tach3.Equals("000"))
                return "";
            if (tach3.Length == 3)
            {
                string tr = tach3.Trim().Substring(0, 1).ToString().Trim();
                string ch = tach3.Trim().Substring(1, 1).ToString().Trim();
                string dv = tach3.Trim().Substring(2, 1).ToString().Trim();
                if (tr.Equals("0") && ch.Equals("0"))
                    Ktach = " không trăm lẻ " + Chu(dv.ToString().Trim()) + " ";
                if (!tr.Equals("0") && ch.Equals("0") && dv.Equals("0"))
                    Ktach = Chu(tr.ToString().Trim()).Trim() + " trăm ";
                if (!tr.Equals("0") && ch.Equals("0") && !dv.Equals("0"))
                    Ktach = Chu(tr.ToString().Trim()).Trim() + " trăm lẻ " + Chu(dv.Trim()).Trim() + " ";
                if (tr.Equals("0") && Convert.ToInt32(ch) > 1 && Convert.ToInt32(dv) > 0 && !dv.Equals("5"))
                    Ktach = " không trăm " + Chu(ch.Trim()).Trim() + " mươi " + Chu(dv.Trim()).Trim() + " ";
                if (tr.Equals("0") && Convert.ToInt32(ch) > 1 && dv.Equals("0"))
                    Ktach = " không trăm " + Chu(ch.Trim()).Trim() + " mươi ";
                if (tr.Equals("0") && Convert.ToInt32(ch) > 1 && dv.Equals("5"))
                    Ktach = " không trăm " + Chu(ch.Trim()).Trim() + " mươi lăm ";
                if (tr.Equals("0") && ch.Equals("1") && Convert.ToInt32(dv) > 0 && !dv.Equals("5"))
                    Ktach = " không trăm mười " + Chu(dv.Trim()).Trim() + " ";
                if (tr.Equals("0") && ch.Equals("1") && dv.Equals("0"))
                    Ktach = " không trăm mười ";
                if (tr.Equals("0") && ch.Equals("1") && dv.Equals("5"))
                    Ktach = " không trăm mười lăm ";
                if (Convert.ToInt32(tr) > 0 && Convert.ToInt32(ch) > 1 && Convert.ToInt32(dv) > 0 && !dv.Equals("5"))
                    Ktach = Chu(tr.Trim()).Trim() + " trăm " + Chu(ch.Trim()).Trim() + " mươi " + Chu(dv.Trim()).Trim() + " ";
                if (Convert.ToInt32(tr) > 0 && Convert.ToInt32(ch) > 1 && dv.Equals("0"))
                    Ktach = Chu(tr.Trim()).Trim() + " trăm " + Chu(ch.Trim()).Trim() + " mươi ";
                if (Convert.ToInt32(tr) > 0 && Convert.ToInt32(ch) > 1 && dv.Equals("5"))
                    Ktach = Chu(tr.Trim()).Trim() + " trăm " + Chu(ch.Trim()).Trim() + " mươi lăm ";
                if (Convert.ToInt32(tr) > 0 && ch.Equals("1") && Convert.ToInt32(dv) > 0 && !dv.Equals("5"))
                    Ktach = Chu(tr.Trim()).Trim() + " trăm mười " + Chu(dv.Trim()).Trim() + " ";

                if (Convert.ToInt32(tr) > 0 && ch.Equals("1") && dv.Equals("0"))
                    Ktach = Chu(tr.Trim()).Trim() + " trăm mười ";
                if (Convert.ToInt32(tr) > 0 && ch.Equals("1") && dv.Equals("5"))
                    Ktach = Chu(tr.Trim()).Trim() + " trăm mười lăm ";

            }


            return Ktach;

        }
        public static string So_chu(double gNum)
        {
            if (gNum == 0)
                return "Không đồng";

            string lso_chu = "";
            string tach_mod = "";
            string tach_conlai = "";
            double Num = Math.Round(gNum, 0);
            string gN = Convert.ToString(Num);
            int m = Convert.ToInt32(gN.Length / 3);
            int mod = gN.Length - m * 3;
            //string dau = "[+]";

            // Dau [+ , - ]

            //if (gNum < 0)
            //    dau = "[-]";
            //dau = "";

            // Tach hang lon nhat
            if (mod.Equals(1))
                tach_mod = "00" + Convert.ToString(Num.ToString().Trim().Substring(0, 1)).Trim();
            if (mod.Equals(2))
                tach_mod = "0" + Convert.ToString(Num.ToString().Trim().Substring(0, 2)).Trim();
            if (mod.Equals(0))
                tach_mod = "000";
            // Tach hang con lai sau mod :
            if (Num.ToString().Length > 2)
                tach_conlai = Convert.ToString(Num.ToString().Trim().Substring(mod, Num.ToString().Length - mod)).Trim();

            ///don vi hang mod
            int im = m + 1;
            if (mod > 0)
                lso_chu = Tach(tach_mod).ToString().Trim() + " " + Donvi(im);
            /// Tach 3 trong tach_conlai

            int i = m;
            //int _m = m;
            int j = 1;
            string tach3 = "";
            string tach3_ = "";

            while (i > 0)
            {
                tach3 = tach_conlai.Trim().Substring(0, 3).Trim();
                tach3_ = tach3;
                lso_chu = lso_chu.Trim() + " " + Tach(tach3.Trim()).Trim();
                m = im - j;
                if (!tach3_.Equals("000"))
                    lso_chu = lso_chu.Trim() + " " + Donvi(m).Trim();
                tach_conlai = tach_conlai.Trim().Substring(3, tach_conlai.Trim().Length - 3);

                i = i - 1;
                j = j + 1;
            }
            if (lso_chu.Trim().Substring(0, 1).Equals("k"))
                lso_chu = lso_chu.Trim().Substring(10, lso_chu.Trim().Length - 10).Trim();
            if (lso_chu.Trim().Substring(0, 1).Equals("l"))
                lso_chu = lso_chu.Trim().Substring(2, lso_chu.Trim().Length - 2).Trim();
            if (lso_chu.Trim().Length > 0)
                lso_chu = /*dau.Trim() + " " +*/ lso_chu.Trim().Substring(0, 1).Trim().ToUpper() + lso_chu.Trim().Substring(1, lso_chu.Trim().Length - 1).Trim() + " đồng ";

            return lso_chu.ToString().Trim();

        }
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            BonusSkins.Register();
            SkinManager.EnableFormSkins();
            UserLookAndFeel.Default.SetSkinStyle("DevExpress Style");
           
            while (flag == 1)
            {
                dangnhap = new frmDangNhap();
                Application.Run(dangnhap);                              
            }
        }
    }
}
