namespace DeTai_QLDSV
{
    partial class frmHocPhi
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmHocPhi));
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnGhi = new System.Windows.Forms.Button();
            this.btnBatDau = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.txtMaSV = new System.Windows.Forms.TextBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.gbTTSV = new System.Windows.Forms.GroupBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtTen = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtMaLop = new System.Windows.Forms.TextBox();
            this.txtHo = new System.Windows.Forms.TextBox();
            this.gbDSHP = new System.Windows.Forms.GroupBox();
            this.cmbLop = new System.Windows.Forms.ComboBox();
            this.lOPBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.dS_HOCPHI = new DeTai_QLDSV.DS_HOCPHI();
            this.label4 = new System.Windows.Forms.Label();
            this.btnPrint = new System.Windows.Forms.Button();
            this.txtNienKhoa = new System.Windows.Forms.NumericUpDown();
            this.txtHocKy = new System.Windows.Forms.NumericUpDown();
            this.label5 = new System.Windows.Forms.Label();
            this.gvHocPhi = new System.Windows.Forms.DataGridView();
            this.NIENKHOA = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.HOCKY = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.HOCPHI = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.SOTIENDADONG = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.barManager1 = new DevExpress.XtraBars.BarManager(this.components);
            this.bar1 = new DevExpress.XtraBars.Bar();
            this.btnThem = new DevExpress.XtraBars.BarLargeButtonItem();
            this.btnHieuChinh = new DevExpress.XtraBars.BarButtonItem();
            this.btnPhucHoi = new DevExpress.XtraBars.BarButtonItem();
            this.btnIn = new DevExpress.XtraBars.BarButtonItem();
            this.btnTailai = new DevExpress.XtraBars.BarLargeButtonItem();
            this.barDockControlTop = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlBottom = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlLeft = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlRight = new DevExpress.XtraBars.BarDockControl();
            this.lOPTableAdapter = new DeTai_QLDSV.DS_HOCPHITableAdapters.LOPTableAdapter();
            this.tableAdapterManager = new DeTai_QLDSV.DS_HOCPHITableAdapters.TableAdapterManager();
            this.sINHVIENBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.sINHVIENTableAdapter = new DeTai_QLDSV.DS_HOCPHITableAdapters.SINHVIENTableAdapter();
            tENLOPLabel = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.gbTTSV.SuspendLayout();
            this.gbDSHP.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.lOPBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dS_HOCPHI)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtNienKhoa)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtHocKy)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvHocPhi)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sINHVIENBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // tENLOPLabel
            // 
            tENLOPLabel.AutoSize = true;
            tENLOPLabel.Location = new System.Drawing.Point(71, 37);
            tENLOPLabel.Name = "tENLOPLabel";
            tENLOPLabel.Size = new System.Drawing.Size(55, 19);
            tENLOPLabel.TabIndex = 5;
            tENLOPLabel.Text = "Tên lớp";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btnGhi);
            this.groupBox1.Controls.Add(this.btnBatDau);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.txtMaSV);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Top;
            this.groupBox1.Location = new System.Drawing.Point(0, 65);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(1604, 88);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Enter += new System.EventHandler(this.groupBox1_Enter);
            // 
            // btnGhi
            // 
            this.btnGhi.Location = new System.Drawing.Point(880, 38);
            this.btnGhi.Name = "btnGhi";
            this.btnGhi.Size = new System.Drawing.Size(102, 32);
            this.btnGhi.TabIndex = 2;
            this.btnGhi.Text = "Ghi";
            this.btnGhi.UseVisualStyleBackColor = true;
            this.btnGhi.Click += new System.EventHandler(this.btnGhi_Click);
            // 
            // btnBatDau
            // 
            this.btnBatDau.Location = new System.Drawing.Point(695, 34);
            this.btnBatDau.Name = "btnBatDau";
            this.btnBatDau.Size = new System.Drawing.Size(102, 32);
            this.btnBatDau.TabIndex = 2;
            this.btnBatDau.Text = "Bắt đầu";
            this.btnBatDau.UseVisualStyleBackColor = true;
            this.btnBatDau.Click += new System.EventHandler(this.btnBatDau_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(92, 41);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(85, 19);
            this.label1.TabIndex = 1;
            this.label1.Text = "Mã sinh viên";
            // 
            // txtMaSV
            // 
            this.txtMaSV.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.txtMaSV.Location = new System.Drawing.Point(218, 38);
            this.txtMaSV.MaxLength = 15;
            this.txtMaSV.Name = "txtMaSV";
            this.txtMaSV.Size = new System.Drawing.Size(390, 26);
            this.txtMaSV.TabIndex = 0;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.gbTTSV);
            this.groupBox2.Controls.Add(this.gbDSHP);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Top;
            this.groupBox2.Location = new System.Drawing.Point(0, 153);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(1604, 213);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            // 
            // gbTTSV
            // 
            this.gbTTSV.Controls.Add(this.label2);
            this.gbTTSV.Controls.Add(this.txtTen);
            this.gbTTSV.Controls.Add(this.label3);
            this.gbTTSV.Controls.Add(this.txtMaLop);
            this.gbTTSV.Controls.Add(this.txtHo);
            this.gbTTSV.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gbTTSV.Location = new System.Drawing.Point(3, 22);
            this.gbTTSV.Name = "gbTTSV";
            this.gbTTSV.Size = new System.Drawing.Size(692, 188);
            this.gbTTSV.TabIndex = 5;
            this.gbTTSV.TabStop = false;
            this.gbTTSV.Text = "Thông tin sinh viên";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(36, 67);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(68, 19);
            this.label2.TabIndex = 0;
            this.label2.Text = "Họ và tên";
            // 
            // txtTen
            // 
            this.txtTen.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.txtTen.Location = new System.Drawing.Point(421, 64);
            this.txtTen.MaxLength = 15;
            this.txtTen.Name = "txtTen";
            this.txtTen.Size = new System.Drawing.Size(164, 26);
            this.txtTen.TabIndex = 0;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(36, 146);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(53, 19);
            this.label3.TabIndex = 0;
            this.label3.Text = "Mã lớp";
            // 
            // txtMaLop
            // 
            this.txtMaLop.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.txtMaLop.Location = new System.Drawing.Point(140, 143);
            this.txtMaLop.MaxLength = 15;
            this.txtMaLop.Name = "txtMaLop";
            this.txtMaLop.Size = new System.Drawing.Size(296, 26);
            this.txtMaLop.TabIndex = 0;
            // 
            // txtHo
            // 
            this.txtHo.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.txtHo.Location = new System.Drawing.Point(142, 64);
            this.txtHo.MaxLength = 15;
            this.txtHo.Name = "txtHo";
            this.txtHo.Size = new System.Drawing.Size(273, 26);
            this.txtHo.TabIndex = 0;
            // 
            // gbDSHP
            // 
            this.gbDSHP.Controls.Add(tENLOPLabel);
            this.gbDSHP.Controls.Add(this.cmbLop);
            this.gbDSHP.Controls.Add(this.label4);
            this.gbDSHP.Controls.Add(this.btnPrint);
            this.gbDSHP.Controls.Add(this.txtNienKhoa);
            this.gbDSHP.Controls.Add(this.txtHocKy);
            this.gbDSHP.Controls.Add(this.label5);
            this.gbDSHP.Dock = System.Windows.Forms.DockStyle.Right;
            this.gbDSHP.Location = new System.Drawing.Point(695, 22);
            this.gbDSHP.Name = "gbDSHP";
            this.gbDSHP.Size = new System.Drawing.Size(906, 188);
            this.gbDSHP.TabIndex = 4;
            this.gbDSHP.TabStop = false;
            this.gbDSHP.Text = "Thông tin in danh sách";
            // 
            // cmbLop
            // 
            this.cmbLop.DataSource = this.lOPBindingSource;
            this.cmbLop.DisplayMember = "TENLOP";
            this.cmbLop.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbLop.FormattingEnabled = true;
            this.cmbLop.Location = new System.Drawing.Point(190, 34);
            this.cmbLop.Name = "cmbLop";
            this.cmbLop.Size = new System.Drawing.Size(541, 27);
            this.cmbLop.TabIndex = 6;
            this.cmbLop.ValueMember = "MALOP";
            // 
            // lOPBindingSource
            // 
            this.lOPBindingSource.DataMember = "LOP";
            this.lOPBindingSource.DataSource = this.dS_HOCPHI;
            // 
            // dS_HOCPHI
            // 
            this.dS_HOCPHI.DataSetName = "DS_HOCPHI";
            this.dS_HOCPHI.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(71, 95);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(72, 19);
            this.label4.TabIndex = 1;
            this.label4.Text = "Niên khóa";
            // 
            // btnPrint
            // 
            this.btnPrint.Location = new System.Drawing.Point(478, 108);
            this.btnPrint.Name = "btnPrint";
            this.btnPrint.Size = new System.Drawing.Size(94, 34);
            this.btnPrint.TabIndex = 3;
            this.btnPrint.Text = "Xem DS";
            this.btnPrint.UseVisualStyleBackColor = true;
            this.btnPrint.Click += new System.EventHandler(this.btnPrint_Click);
            // 
            // txtNienKhoa
            // 
            this.txtNienKhoa.Location = new System.Drawing.Point(190, 95);
            this.txtNienKhoa.Maximum = new decimal(new int[] {
            9999,
            0,
            0,
            0});
            this.txtNienKhoa.Minimum = new decimal(new int[] {
            1990,
            0,
            0,
            0});
            this.txtNienKhoa.MinimumSize = new System.Drawing.Size(4, 0);
            this.txtNienKhoa.Name = "txtNienKhoa";
            this.txtNienKhoa.Size = new System.Drawing.Size(82, 26);
            this.txtNienKhoa.TabIndex = 2;
            this.txtNienKhoa.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.txtNienKhoa.Value = new decimal(new int[] {
            1990,
            0,
            0,
            0});
            // 
            // txtHocKy
            // 
            this.txtHocKy.Location = new System.Drawing.Point(190, 148);
            this.txtHocKy.Maximum = new decimal(new int[] {
            2,
            0,
            0,
            0});
            this.txtHocKy.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.txtHocKy.Name = "txtHocKy";
            this.txtHocKy.Size = new System.Drawing.Size(48, 26);
            this.txtHocKy.TabIndex = 2;
            this.txtHocKy.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(72, 150);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(54, 19);
            this.label5.TabIndex = 1;
            this.label5.Text = "Học kỳ";
            // 
            // gvHocPhi
            // 
            this.gvHocPhi.AllowUserToAddRows = false;
            this.gvHocPhi.AllowUserToDeleteRows = false;
            this.gvHocPhi.AllowUserToResizeColumns = false;
            this.gvHocPhi.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gvHocPhi.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.NIENKHOA,
            this.HOCKY,
            this.HOCPHI,
            this.SOTIENDADONG});
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle2.Format = "N0";
            dataGridViewCellStyle2.NullValue = null;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.gvHocPhi.DefaultCellStyle = dataGridViewCellStyle2;
            this.gvHocPhi.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gvHocPhi.Location = new System.Drawing.Point(0, 366);
            this.gvHocPhi.Name = "gvHocPhi";
            this.gvHocPhi.Size = new System.Drawing.Size(1604, 309);
            this.gvHocPhi.TabIndex = 2;
            this.gvHocPhi.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.gvHocPhi_CellEndEdit);
            this.gvHocPhi.EditingControlShowing += new System.Windows.Forms.DataGridViewEditingControlShowingEventHandler(this.gvHocPhi_EditingControlShowing);
            this.gvHocPhi.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.gvHocPhi_KeyPress);
            // 
            // NIENKHOA
            // 
            this.NIENKHOA.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.NIENKHOA.DataPropertyName = "NIENKHOA";
            this.NIENKHOA.HeaderText = "Niên khóa";
            this.NIENKHOA.MaxInputLength = 4;
            this.NIENKHOA.Name = "NIENKHOA";
            this.NIENKHOA.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
            // 
            // HOCKY
            // 
            this.HOCKY.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.HOCKY.DataPropertyName = "HOCKY";
            this.HOCKY.HeaderText = "Học kỳ";
            this.HOCKY.MaxInputLength = 1;
            this.HOCKY.Name = "HOCKY";
            this.HOCKY.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
            // 
            // HOCPHI
            // 
            this.HOCPHI.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.HOCPHI.DataPropertyName = "HOCPHI";
            this.HOCPHI.HeaderText = "Học phí";
            this.HOCPHI.MaxInputLength = 9;
            this.HOCPHI.Name = "HOCPHI";
            this.HOCPHI.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
            // 
            // SOTIENDADONG
            // 
            this.SOTIENDADONG.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.SOTIENDADONG.DataPropertyName = "SOTIENDADONG";
            this.SOTIENDADONG.HeaderText = "Số tiền đã đóng";
            this.SOTIENDADONG.MaxInputLength = 9;
            this.SOTIENDADONG.Name = "SOTIENDADONG";
            this.SOTIENDADONG.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
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
            this.btnThem,
            this.btnHieuChinh,
            this.btnTailai,
            this.btnPhucHoi,
            this.btnIn});
            this.barManager1.MaxItemId = 6;
            // 
            // bar1
            // 
            this.bar1.BarName = "Tools";
            this.bar1.DockCol = 0;
            this.bar1.DockRow = 0;
            this.bar1.DockStyle = DevExpress.XtraBars.BarDockStyle.Top;
            this.bar1.LinksPersistInfo.AddRange(new DevExpress.XtraBars.LinkPersistInfo[] {
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnThem, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnHieuChinh, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnPhucHoi, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnIn, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnTailai, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph)});
            this.bar1.Text = "Tools";
            // 
            // btnThem
            // 
            this.btnThem.Caption = "Thêm";
            this.btnThem.Id = 0;
            this.btnThem.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnThem.ImageOptions.Image")));
            this.btnThem.Name = "btnThem";
            this.btnThem.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnThem_ItemClick);
            // 
            // btnHieuChinh
            // 
            this.btnHieuChinh.Caption = "Hiệu chỉnh";
            this.btnHieuChinh.Id = 1;
            this.btnHieuChinh.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnHieuChinh.ImageOptions.Image")));
            this.btnHieuChinh.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnHieuChinh.ImageOptions.LargeImage")));
            this.btnHieuChinh.Name = "btnHieuChinh";
            this.btnHieuChinh.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnHieuChinh_ItemClick);
            // 
            // btnPhucHoi
            // 
            this.btnPhucHoi.Caption = "Phục hồi";
            this.btnPhucHoi.Id = 3;
            this.btnPhucHoi.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnPhucHoi.ImageOptions.Image")));
            this.btnPhucHoi.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnPhucHoi.ImageOptions.LargeImage")));
            this.btnPhucHoi.Name = "btnPhucHoi";
            this.btnPhucHoi.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnPhucHoi_ItemClick);
            // 
            // btnIn
            // 
            this.btnIn.Caption = "In DSHP";
            this.btnIn.Id = 5;
            this.btnIn.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnIn.ImageOptions.Image")));
            this.btnIn.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnIn.ImageOptions.LargeImage")));
            this.btnIn.Name = "btnIn";
            this.btnIn.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnIn_ItemClick);
            // 
            // btnTailai
            // 
            this.btnTailai.Caption = "Tải lại";
            this.btnTailai.Id = 2;
            this.btnTailai.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnTailai.ImageOptions.Image")));
            this.btnTailai.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnTailai.ImageOptions.LargeImage")));
            this.btnTailai.Name = "btnTailai";
            this.btnTailai.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnTailai_ItemClick);
            // 
            // barDockControlTop
            // 
            this.barDockControlTop.CausesValidation = false;
            this.barDockControlTop.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControlTop.Location = new System.Drawing.Point(0, 0);
            this.barDockControlTop.Manager = this.barManager1;
            this.barDockControlTop.Size = new System.Drawing.Size(1604, 65);
            // 
            // barDockControlBottom
            // 
            this.barDockControlBottom.CausesValidation = false;
            this.barDockControlBottom.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControlBottom.Location = new System.Drawing.Point(0, 675);
            this.barDockControlBottom.Manager = this.barManager1;
            this.barDockControlBottom.Size = new System.Drawing.Size(1604, 0);
            // 
            // barDockControlLeft
            // 
            this.barDockControlLeft.CausesValidation = false;
            this.barDockControlLeft.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControlLeft.Location = new System.Drawing.Point(0, 65);
            this.barDockControlLeft.Manager = this.barManager1;
            this.barDockControlLeft.Size = new System.Drawing.Size(0, 610);
            // 
            // barDockControlRight
            // 
            this.barDockControlRight.CausesValidation = false;
            this.barDockControlRight.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControlRight.Location = new System.Drawing.Point(1604, 65);
            this.barDockControlRight.Manager = this.barManager1;
            this.barDockControlRight.Size = new System.Drawing.Size(0, 610);
            // 
            // lOPTableAdapter
            // 
            this.lOPTableAdapter.ClearBeforeFill = true;
            // 
            // tableAdapterManager
            // 
            this.tableAdapterManager.BackupDataSetBeforeUpdate = false;
            this.tableAdapterManager.GIANGVIENTableAdapter = null;
            this.tableAdapterManager.HOCPHITableAdapter = null;
            this.tableAdapterManager.LOPTableAdapter = this.lOPTableAdapter;
            this.tableAdapterManager.SINHVIENTableAdapter = null;
            this.tableAdapterManager.UpdateOrder = DeTai_QLDSV.DS_HOCPHITableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
            // 
            // sINHVIENBindingSource
            // 
            this.sINHVIENBindingSource.DataMember = "FK_SINHVIEN_LOP";
            this.sINHVIENBindingSource.DataSource = this.lOPBindingSource;
            // 
            // sINHVIENTableAdapter
            // 
            this.sINHVIENTableAdapter.ClearBeforeFill = true;
            // 
            // frmHocPhi
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 19F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = true;
            this.ClientSize = new System.Drawing.Size(1604, 675);
            this.Controls.Add(this.gvHocPhi);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "frmHocPhi";
            this.Text = "Học phí";
            this.Load += new System.EventHandler(this.frmHocPhi_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.gbTTSV.ResumeLayout(false);
            this.gbTTSV.PerformLayout();
            this.gbDSHP.ResumeLayout(false);
            this.gbDSHP.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.lOPBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dS_HOCPHI)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtNienKhoa)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtHocKy)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvHocPhi)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sINHVIENBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtMaSV;
        private System.Windows.Forms.Button btnGhi;
        private System.Windows.Forms.Button btnBatDau;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtHo;
        private System.Windows.Forms.TextBox txtMaLop;
        private System.Windows.Forms.TextBox txtTen;
        private System.Windows.Forms.DataGridView gvHocPhi;
        private DevExpress.XtraBars.BarManager barManager1;
        private DevExpress.XtraBars.Bar bar1;
        private DevExpress.XtraBars.BarLargeButtonItem btnThem;
        private DevExpress.XtraBars.BarButtonItem btnHieuChinh;
        private DevExpress.XtraBars.BarLargeButtonItem btnTailai;
        private DevExpress.XtraBars.BarDockControl barDockControlTop;
        private DevExpress.XtraBars.BarDockControl barDockControlBottom;
        private DevExpress.XtraBars.BarDockControl barDockControlLeft;
        private DevExpress.XtraBars.BarDockControl barDockControlRight;
        private DevExpress.XtraBars.BarButtonItem btnPhucHoi;
        private DevExpress.XtraBars.BarButtonItem btnIn;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.NumericUpDown txtHocKy;
        private System.Windows.Forms.NumericUpDown txtNienKhoa;
        private System.Windows.Forms.Button btnPrint;
        private System.Windows.Forms.GroupBox gbDSHP;
        private System.Windows.Forms.BindingSource lOPBindingSource;
        private DS_HOCPHI dS_HOCPHI;
        private DS_HOCPHITableAdapters.LOPTableAdapter lOPTableAdapter;
        private DS_HOCPHITableAdapters.TableAdapterManager tableAdapterManager;
        private System.Windows.Forms.ComboBox cmbLop;
        private System.Windows.Forms.GroupBox gbTTSV;
        private System.Windows.Forms.DataGridViewTextBoxColumn NIENKHOA;
        private System.Windows.Forms.DataGridViewTextBoxColumn HOCKY;
        private System.Windows.Forms.DataGridViewTextBoxColumn HOCPHI;
        private System.Windows.Forms.DataGridViewTextBoxColumn SOTIENDADONG;
        private System.Windows.Forms.BindingSource sINHVIENBindingSource;
        private DS_HOCPHITableAdapters.SINHVIENTableAdapter sINHVIENTableAdapter;
    }
}