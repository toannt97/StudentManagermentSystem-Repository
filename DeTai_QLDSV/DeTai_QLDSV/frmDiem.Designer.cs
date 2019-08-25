namespace DeTai_QLDSV
{
    partial class frmDiem
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.Label tENLOPLabel;
            System.Windows.Forms.Label tENMHLabel;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmDiem));
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle8 = new System.Windows.Forms.DataGridViewCellStyle();
            this.barManager1 = new DevExpress.XtraBars.BarManager(this.components);
            this.bar1 = new DevExpress.XtraBars.Bar();
            this.btnBatDau = new DevExpress.XtraBars.BarLargeButtonItem();
            this.btnGhi = new DevExpress.XtraBars.BarLargeButtonItem();
            this.btnUndo = new DevExpress.XtraBars.BarLargeButtonItem();
            this.btnPrint = new DevExpress.XtraBars.BarLargeButtonItem();
            this.btnThoat = new DevExpress.XtraBars.BarLargeButtonItem();
            this.barDockControlTop = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlBottom = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlLeft = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlRight = new DevExpress.XtraBars.BarDockControl();
            this.btnPhuchoi = new DevExpress.XtraBars.BarButtonItem();
            this.barButtonItem1 = new DevExpress.XtraBars.BarButtonItem();
            this.panel1 = new System.Windows.Forms.Panel();
            this.cmbKhoa = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnXem = new System.Windows.Forms.Button();
            this.cmbMonHoc = new System.Windows.Forms.ComboBox();
            this.bdsDSMonHoc = new System.Windows.Forms.BindingSource(this.components);
            this.dS_DIEM = new DeTai_QLDSV.DS_DIEM();
            this.cmbLop = new System.Windows.Forms.ComboBox();
            this.bdsDSLop = new System.Windows.Forms.BindingSource(this.components);
            this.txtLanThi = new System.Windows.Forms.NumericUpDown();
            this.label4 = new System.Windows.Forms.Label();
            this.v_DSLOP_Tontai_SVTableAdapter = new DeTai_QLDSV.DS_DIEMTableAdapters.V_DSLOP_Tontai_SVTableAdapter();
            this.tableAdapterManager = new DeTai_QLDSV.DS_DIEMTableAdapters.TableAdapterManager();
            this.v_DS_MonHocTableAdapter = new DeTai_QLDSV.DS_DIEMTableAdapters.V_DS_MonHocTableAdapter();
            this.dtgvDiem = new System.Windows.Forms.DataGridView();
            this.MASV = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.HOTEN = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DIEM = new System.Windows.Forms.DataGridViewTextBoxColumn();
            tENLOPLabel = new System.Windows.Forms.Label();
            tENMHLabel = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            this.panel1.SuspendLayout();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bdsDSMonHoc)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dS_DIEM)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bdsDSLop)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtLanThi)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtgvDiem)).BeginInit();
            this.SuspendLayout();
            // 
            // tENLOPLabel
            // 
            tENLOPLabel.AutoSize = true;
            tENLOPLabel.Location = new System.Drawing.Point(129, 69);
            tENLOPLabel.Name = "tENLOPLabel";
            tENLOPLabel.Size = new System.Drawing.Size(68, 21);
            tENLOPLabel.TabIndex = 6;
            tENLOPLabel.Text = "Tên lớp";
            // 
            // tENMHLabel
            // 
            tENMHLabel.AutoSize = true;
            tENMHLabel.Location = new System.Drawing.Point(129, 193);
            tENMHLabel.Name = "tENMHLabel";
            tENMHLabel.Size = new System.Drawing.Size(110, 21);
            tENMHLabel.TabIndex = 7;
            tENMHLabel.Text = "Tên môn học";
            // 
            // barManager1
            // 
            this.barManager1.Bars.AddRange(new DevExpress.XtraBars.Bar[] {
            this.bar1});
            this.barManager1.DockControls.Add(this.barDockControlTop);
            this.barManager1.DockControls.Add(this.barDockControlBottom);
            this.barManager1.DockControls.Add(this.barDockControlLeft);
            this.barManager1.DockControls.Add(this.barDockControlRight);
            this.barManager1.Form = this;
            this.barManager1.Items.AddRange(new DevExpress.XtraBars.BarItem[] {
            this.btnBatDau,
            this.btnGhi,
            this.btnThoat,
            this.btnPhuchoi,
            this.barButtonItem1,
            this.btnUndo,
            this.btnPrint});
            this.barManager1.MaxItemId = 9;
            // 
            // bar1
            // 
            this.bar1.BarAppearance.Hovered.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.bar1.BarAppearance.Hovered.Options.UseBackColor = true;
            this.bar1.BarName = "Tools";
            this.bar1.DockCol = 0;
            this.bar1.DockRow = 0;
            this.bar1.DockStyle = DevExpress.XtraBars.BarDockStyle.Top;
            this.bar1.LinksPersistInfo.AddRange(new DevExpress.XtraBars.LinkPersistInfo[] {
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnBatDau, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnGhi, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnUndo, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnPrint, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnThoat, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph)});
            this.bar1.OptionsBar.AllowQuickCustomization = false;
            this.bar1.OptionsBar.DrawBorder = false;
            this.bar1.Text = "Tools";
            // 
            // btnBatDau
            // 
            this.btnBatDau.Caption = "Bắt đầu";
            this.btnBatDau.Id = 0;
            this.btnBatDau.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnBatDau.ImageOptions.Image")));
            this.btnBatDau.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnBatDau.ImageOptions.LargeImage")));
            this.btnBatDau.Name = "btnBatDau";
            this.btnBatDau.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnBatDau_ItemClick);
            // 
            // btnGhi
            // 
            this.btnGhi.Caption = "Ghi";
            this.btnGhi.Id = 1;
            this.btnGhi.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnGhi.ImageOptions.Image")));
            this.btnGhi.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnGhi.ImageOptions.LargeImage")));
            this.btnGhi.Name = "btnGhi";
            this.btnGhi.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnGhi_ItemClick);
            // 
            // btnUndo
            // 
            this.btnUndo.Caption = "Phục hồi";
            this.btnUndo.Id = 6;
            this.btnUndo.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnUndo.ImageOptions.Image")));
            this.btnUndo.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnUndo.ImageOptions.LargeImage")));
            this.btnUndo.Name = "btnUndo";
            this.btnUndo.Size = new System.Drawing.Size(50, 0);
            this.btnUndo.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnUndo_ItemClick);
            // 
            // btnPrint
            // 
            this.btnPrint.Caption = "In Bảng điểm";
            this.btnPrint.Id = 8;
            this.btnPrint.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnPrint.ImageOptions.Image")));
            this.btnPrint.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnPrint.ImageOptions.LargeImage")));
            this.btnPrint.Name = "btnPrint";
            this.btnPrint.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnPrint_ItemClick);
            // 
            // btnThoat
            // 
            this.btnThoat.Caption = "Thoát";
            this.btnThoat.Id = 2;
            this.btnThoat.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnThoat.ImageOptions.Image")));
            this.btnThoat.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnThoat.ImageOptions.LargeImage")));
            this.btnThoat.Name = "btnThoat";
            this.btnThoat.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnThoat_ItemClick);
            // 
            // barDockControlTop
            // 
            this.barDockControlTop.CausesValidation = false;
            this.barDockControlTop.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControlTop.Location = new System.Drawing.Point(0, 0);
            this.barDockControlTop.Manager = this.barManager1;
            this.barDockControlTop.Size = new System.Drawing.Size(1604, 63);
            // 
            // barDockControlBottom
            // 
            this.barDockControlBottom.CausesValidation = false;
            this.barDockControlBottom.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControlBottom.Location = new System.Drawing.Point(0, 683);
            this.barDockControlBottom.Manager = this.barManager1;
            this.barDockControlBottom.Size = new System.Drawing.Size(1604, 0);
            // 
            // barDockControlLeft
            // 
            this.barDockControlLeft.CausesValidation = false;
            this.barDockControlLeft.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControlLeft.Location = new System.Drawing.Point(0, 63);
            this.barDockControlLeft.Manager = this.barManager1;
            this.barDockControlLeft.Size = new System.Drawing.Size(0, 620);
            // 
            // barDockControlRight
            // 
            this.barDockControlRight.CausesValidation = false;
            this.barDockControlRight.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControlRight.Location = new System.Drawing.Point(1604, 63);
            this.barDockControlRight.Manager = this.barManager1;
            this.barDockControlRight.Size = new System.Drawing.Size(0, 620);
            // 
            // btnPhuchoi
            // 
            this.btnPhuchoi.Caption = "Phục hồi";
            this.btnPhuchoi.Id = 3;
            this.btnPhuchoi.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnPhuchoi.ImageOptions.Image")));
            this.btnPhuchoi.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnPhuchoi.ImageOptions.LargeImage")));
            this.btnPhuchoi.Name = "btnPhuchoi";
            // 
            // barButtonItem1
            // 
            this.barButtonItem1.Caption = "Phục hồi";
            this.barButtonItem1.Id = 4;
            this.barButtonItem1.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("barButtonItem1.ImageOptions.Image")));
            this.barButtonItem1.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("barButtonItem1.ImageOptions.LargeImage")));
            this.barButtonItem1.Name = "barButtonItem1";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.cmbKhoa);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 63);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(1604, 61);
            this.panel1.TabIndex = 4;
            // 
            // cmbKhoa
            // 
            this.cmbKhoa.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbKhoa.FormattingEnabled = true;
            this.cmbKhoa.Location = new System.Drawing.Point(143, 16);
            this.cmbKhoa.Name = "cmbKhoa";
            this.cmbKhoa.Size = new System.Drawing.Size(330, 29);
            this.cmbKhoa.TabIndex = 1;
            this.cmbKhoa.SelectedIndexChanged += new System.EventHandler(this.cmbKhoa_SelectedIndexChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(32, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(63, 21);
            this.label1.TabIndex = 0;
            this.label1.Text = "KHOA";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btnXem);
            this.groupBox1.Controls.Add(tENMHLabel);
            this.groupBox1.Controls.Add(this.cmbMonHoc);
            this.groupBox1.Controls.Add(tENLOPLabel);
            this.groupBox1.Controls.Add(this.cmbLop);
            this.groupBox1.Controls.Add(this.txtLanThi);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Top;
            this.groupBox1.Location = new System.Drawing.Point(0, 124);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(1604, 213);
            this.groupBox1.TabIndex = 5;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Thông tin sinh viên";
            // 
            // btnXem
            // 
            this.btnXem.Enabled = false;
            this.btnXem.Location = new System.Drawing.Point(1300, 190);
            this.btnXem.Name = "btnXem";
            this.btnXem.Size = new System.Drawing.Size(251, 47);
            this.btnXem.TabIndex = 9;
            this.btnXem.Text = "Xem Bảng điểm";
            this.btnXem.UseVisualStyleBackColor = true;
            this.btnXem.Click += new System.EventHandler(this.btnXem_Click);
            // 
            // cmbMonHoc
            // 
            this.cmbMonHoc.DataSource = this.bdsDSMonHoc;
            this.cmbMonHoc.DisplayMember = "TENMH";
            this.cmbMonHoc.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbMonHoc.FormattingEnabled = true;
            this.cmbMonHoc.Location = new System.Drawing.Point(359, 190);
            this.cmbMonHoc.Name = "cmbMonHoc";
            this.cmbMonHoc.Size = new System.Drawing.Size(602, 29);
            this.cmbMonHoc.TabIndex = 8;
            this.cmbMonHoc.ValueMember = "MAMH";
            // 
            // bdsDSMonHoc
            // 
            this.bdsDSMonHoc.DataMember = "V_DS_MonHoc";
            this.bdsDSMonHoc.DataSource = this.dS_DIEM;
            // 
            // dS_DIEM
            // 
            this.dS_DIEM.DataSetName = "DS_DIEM";
            this.dS_DIEM.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // cmbLop
            // 
            this.cmbLop.AccessibleRole = System.Windows.Forms.AccessibleRole.TitleBar;
            this.cmbLop.DataSource = this.bdsDSLop;
            this.cmbLop.DisplayMember = "TENLOP";
            this.cmbLop.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbLop.FormattingEnabled = true;
            this.cmbLop.Location = new System.Drawing.Point(359, 66);
            this.cmbLop.Name = "cmbLop";
            this.cmbLop.Size = new System.Drawing.Size(875, 29);
            this.cmbLop.TabIndex = 7;
            this.cmbLop.ValueMember = "MALOP";
            // 
            // bdsDSLop
            // 
            this.bdsDSLop.DataMember = "V_DSLOP_Tontai_SV";
            this.bdsDSLop.DataSource = this.dS_DIEM;
            // 
            // txtLanThi
            // 
            this.txtLanThi.Location = new System.Drawing.Point(1581, 67);
            this.txtLanThi.Maximum = new decimal(new int[] {
            2,
            0,
            0,
            0});
            this.txtLanThi.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.txtLanThi.Name = "txtLanThi";
            this.txtLanThi.ReadOnly = true;
            this.txtLanThi.Size = new System.Drawing.Size(77, 29);
            this.txtLanThi.TabIndex = 2;
            this.txtLanThi.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.txtLanThi.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(1351, 69);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(61, 21);
            this.label4.TabIndex = 0;
            this.label4.Text = "Lần thi";
            // 
            // v_DSLOP_Tontai_SVTableAdapter
            // 
            this.v_DSLOP_Tontai_SVTableAdapter.ClearBeforeFill = true;
            // 
            // tableAdapterManager
            // 
            this.tableAdapterManager.BackupDataSetBeforeUpdate = false;
            this.tableAdapterManager.Connection = null;
            this.tableAdapterManager.DIEMTableAdapter = null;
            this.tableAdapterManager.GIANGVIENTableAdapter = null;
            this.tableAdapterManager.KHOATableAdapter = null;
            this.tableAdapterManager.LOPTableAdapter = null;
            this.tableAdapterManager.MONHOCTableAdapter = null;
            this.tableAdapterManager.SINHVIENTableAdapter = null;
            this.tableAdapterManager.UpdateOrder = DeTai_QLDSV.DS_DIEMTableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
            // 
            // v_DS_MonHocTableAdapter
            // 
            this.v_DS_MonHocTableAdapter.ClearBeforeFill = true;
            // 
            // dtgvDiem
            // 
            this.dtgvDiem.AllowUserToAddRows = false;
            this.dtgvDiem.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dtgvDiem.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.MASV,
            this.HOTEN,
            this.DIEM});
            this.dtgvDiem.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dtgvDiem.Location = new System.Drawing.Point(0, 337);
            this.dtgvDiem.Name = "dtgvDiem";
            this.dtgvDiem.Size = new System.Drawing.Size(1604, 346);
            this.dtgvDiem.TabIndex = 6;
            this.dtgvDiem.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dtgvDiem_CellEndEdit);
            this.dtgvDiem.EditingControlShowing += new System.Windows.Forms.DataGridViewEditingControlShowingEventHandler(this.dtgvDiem_EditingControlShowing);
            this.dtgvDiem.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.dtgvDiem_KeyPress);
            // 
            // MASV
            // 
            this.MASV.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.MASV.DataPropertyName = "MASV";
            this.MASV.Frozen = true;
            this.MASV.HeaderText = "Mã SV";
            this.MASV.MaxInputLength = 15;
            this.MASV.Name = "MASV";
            this.MASV.ReadOnly = true;
            this.MASV.Width = 520;
            // 
            // HOTEN
            // 
            this.HOTEN.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.HOTEN.DataPropertyName = "HOTEN";
            this.HOTEN.Frozen = true;
            this.HOTEN.HeaderText = "Họ & Tên SV";
            this.HOTEN.MaxInputLength = 50;
            this.HOTEN.Name = "HOTEN";
            this.HOTEN.ReadOnly = true;
            this.HOTEN.Width = 521;
            // 
            // DIEM
            // 
            this.DIEM.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.DIEM.DataPropertyName = "DIEM";
            dataGridViewCellStyle8.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle8.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle8.ForeColor = System.Drawing.Color.Red;
            this.DIEM.DefaultCellStyle = dataGridViewCellStyle8;
            this.DIEM.HeaderText = "Điểm";
            this.DIEM.MaxInputLength = 3;
            this.DIEM.Name = "DIEM";
            // 
            // frmDiem
            // 
            this.Appearance.Options.UseFont = true;
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 21F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1604, 683);
            this.Controls.Add(this.dtgvDiem);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(5);
            this.Name = "frmDiem";
            this.Text = "Điểm";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.frmDiem_Load);
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bdsDSMonHoc)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dS_DIEM)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bdsDSLop)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtLanThi)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtgvDiem)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraBars.BarManager barManager1;
        private DevExpress.XtraBars.Bar bar1;
        private DevExpress.XtraBars.BarDockControl barDockControlTop;
        private DevExpress.XtraBars.BarDockControl barDockControlBottom;
        private DevExpress.XtraBars.BarDockControl barDockControlLeft;
        private DevExpress.XtraBars.BarDockControl barDockControlRight;
        private DevExpress.XtraBars.BarLargeButtonItem btnBatDau;
        private DevExpress.XtraBars.BarLargeButtonItem btnGhi;
        private DevExpress.XtraBars.BarLargeButtonItem btnThoat;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.ComboBox cmbKhoa;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.NumericUpDown txtLanThi;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.BindingSource bdsDSLop;
        private DS_DIEM dS_DIEM;
        private DS_DIEMTableAdapters.V_DSLOP_Tontai_SVTableAdapter v_DSLOP_Tontai_SVTableAdapter;
        private DS_DIEMTableAdapters.TableAdapterManager tableAdapterManager;
        private System.Windows.Forms.ComboBox cmbLop;
        private System.Windows.Forms.BindingSource bdsDSMonHoc;
        private DS_DIEMTableAdapters.V_DS_MonHocTableAdapter v_DS_MonHocTableAdapter;
        private System.Windows.Forms.ComboBox cmbMonHoc;
        private DevExpress.XtraBars.BarLargeButtonItem btnUndo;
        private DevExpress.XtraBars.BarButtonItem btnPhuchoi;
        private DevExpress.XtraBars.BarButtonItem barButtonItem1;
        private System.Windows.Forms.DataGridView dtgvDiem;
        private System.Windows.Forms.DataGridViewTextBoxColumn MASV;
        private System.Windows.Forms.DataGridViewTextBoxColumn HOTEN;
        private System.Windows.Forms.DataGridViewTextBoxColumn DIEM;
        private DevExpress.XtraBars.BarLargeButtonItem btnPrint;
        private System.Windows.Forms.Button btnXem;
    }
}