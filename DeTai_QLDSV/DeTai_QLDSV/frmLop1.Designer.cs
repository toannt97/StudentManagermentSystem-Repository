namespace DeTai_QLDSV
{
    partial class frmLop1
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
            System.Windows.Forms.Label mALOPLabel;
            System.Windows.Forms.Label tENLOPLabel;
            System.Windows.Forms.Label mAKHLabel;
            System.Windows.Forms.Label mASVLabel;
            System.Windows.Forms.Label hOLabel;
            System.Windows.Forms.Label tENLabel;
            System.Windows.Forms.Label mALOPLabel1;
            System.Windows.Forms.Label nGAYSINHLabel;
            System.Windows.Forms.Label nOISINHLabel;
            System.Windows.Forms.Label dIACHILabel;
            System.Windows.Forms.Label gHICHULabel;
            System.Windows.Forms.Label pHAILabel;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmLop1));
            this.barManager1 = new DevExpress.XtraBars.BarManager(this.components);
            this.bar1 = new DevExpress.XtraBars.Bar();
            this.btnThem = new DevExpress.XtraBars.BarButtonItem();
            this.btnXoa = new DevExpress.XtraBars.BarButtonItem();
            this.btnHieuChinh = new DevExpress.XtraBars.BarButtonItem();
            this.btnGhi = new DevExpress.XtraBars.BarButtonItem();
            this.btnPhucHoi = new DevExpress.XtraBars.BarButtonItem();
            this.btnTaiLai = new DevExpress.XtraBars.BarButtonItem();
            this.btnThoat = new DevExpress.XtraBars.BarButtonItem();
            this.barDockControlTop = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlBottom = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlLeft = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlRight = new DevExpress.XtraBars.BarDockControl();
            this.standaloneBarDockControl1 = new DevExpress.XtraBars.StandaloneBarDockControl();
            this.btnInDSSV = new DevExpress.XtraBars.BarButtonItem();
            this.btnInPDSV = new DevExpress.XtraBars.BarButtonItem();
            this.qLDSVDataSet = new DeTai_QLDSV.QLDSVDataSet();
            this.tableAdapterManager = new DeTai_QLDSV.QLDSVDataSetTableAdapters.TableAdapterManager();
            this.label1 = new System.Windows.Forms.Label();
            this.dS_DIEM = new DeTai_QLDSV.DS_DIEM();
            this.lOPTableAdapter = new DeTai_QLDSV.DS_DIEMTableAdapters.LOPTableAdapter();
            this.sINHVIENTableAdapter = new DeTai_QLDSV.DS_DIEMTableAdapters.SINHVIENTableAdapter();
            this.lOPBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.gcLop = new DevExpress.XtraGrid.GridControl();
            this.gvLop = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.colMALOP = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colTENLOP = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colMAKH = new DevExpress.XtraGrid.Columns.GridColumn();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.txtMaKhoa = new System.Windows.Forms.TextBox();
            this.txtTenLop = new System.Windows.Forms.TextBox();
            this.txtMaLop = new System.Windows.Forms.TextBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.nghiHoc = new DevExpress.XtraEditors.CheckEdit();
            this.sINHVIENBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.pHAICheckEdit = new DevExpress.XtraEditors.CheckEdit();
            this.txtGhiChu = new DevExpress.XtraEditors.TextEdit();
            this.txtDiaChi = new DevExpress.XtraEditors.TextEdit();
            this.txtNoiSinh = new DevExpress.XtraEditors.TextEdit();
            this.birthDay = new System.Windows.Forms.DateTimePicker();
            this.txtMaLopSv = new DevExpress.XtraEditors.TextEdit();
            this.txtTenSv = new DevExpress.XtraEditors.TextEdit();
            this.txtHoSv = new DevExpress.XtraEditors.TextEdit();
            this.txtMaSV = new DevExpress.XtraEditors.TextEdit();
            this.dgcSinhVien = new DevExpress.XtraGrid.GridControl();
            this.dgvSinhVien = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.colMASV = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colHO = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colTEN = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colMALOP1 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colPHAI = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colNGAYSINH = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colNOISINH = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colDIACHI = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colGHICHU = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colNGHIHOC = new DevExpress.XtraGrid.Columns.GridColumn();
            this.bar3 = new DevExpress.XtraBars.Bar();
            this.barManager2 = new DevExpress.XtraBars.BarManager(this.components);
            this.bar2 = new DevExpress.XtraBars.Bar();
            this.btnThemSv = new DevExpress.XtraBars.BarButtonItem();
            this.btnXoaSv = new DevExpress.XtraBars.BarButtonItem();
            this.btnHieuChinhSv = new DevExpress.XtraBars.BarButtonItem();
            this.btnGhiSv = new DevExpress.XtraBars.BarButtonItem();
            this.btnPhucHoiSv = new DevExpress.XtraBars.BarButtonItem();
            this.btnTaiLaiSv = new DevExpress.XtraBars.BarButtonItem();
            this.barDockControl1 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl2 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl3 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl4 = new DevExpress.XtraBars.BarDockControl();
            this.cmbKhoa = new System.Windows.Forms.ComboBox();
            this.tableAdapterManager1 = new DeTai_QLDSV.DS_DIEMTableAdapters.TableAdapterManager();
            mALOPLabel = new System.Windows.Forms.Label();
            tENLOPLabel = new System.Windows.Forms.Label();
            mAKHLabel = new System.Windows.Forms.Label();
            mASVLabel = new System.Windows.Forms.Label();
            hOLabel = new System.Windows.Forms.Label();
            tENLabel = new System.Windows.Forms.Label();
            mALOPLabel1 = new System.Windows.Forms.Label();
            nGAYSINHLabel = new System.Windows.Forms.Label();
            nOISINHLabel = new System.Windows.Forms.Label();
            dIACHILabel = new System.Windows.Forms.Label();
            gHICHULabel = new System.Windows.Forms.Label();
            pHAILabel = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.qLDSVDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dS_DIEM)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.lOPBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcLop)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvLop)).BeginInit();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nghiHoc.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sINHVIENBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pHAICheckEdit.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtGhiChu.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtDiaChi.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtNoiSinh.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMaLopSv.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtTenSv.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtHoSv.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMaSV.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgcSinhVien)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSinhVien)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager2)).BeginInit();
            this.SuspendLayout();
            // 
            // mALOPLabel
            // 
            mALOPLabel.AutoSize = true;
            mALOPLabel.Location = new System.Drawing.Point(12, 99);
            mALOPLabel.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            mALOPLabel.Name = "mALOPLabel";
            mALOPLabel.Size = new System.Drawing.Size(56, 19);
            mALOPLabel.TabIndex = 0;
            mALOPLabel.Text = "Mã lớp:";
            // 
            // tENLOPLabel
            // 
            tENLOPLabel.AutoSize = true;
            tENLOPLabel.Location = new System.Drawing.Point(12, 240);
            tENLOPLabel.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            tENLOPLabel.Name = "tENLOPLabel";
            tENLOPLabel.Size = new System.Drawing.Size(58, 19);
            tENLOPLabel.TabIndex = 2;
            tENLOPLabel.Text = "Tên lớp:";
            // 
            // mAKHLabel
            // 
            mAKHLabel.AutoSize = true;
            mAKHLabel.Location = new System.Drawing.Point(12, 384);
            mAKHLabel.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            mAKHLabel.Name = "mAKHLabel";
            mAKHLabel.Size = new System.Drawing.Size(67, 19);
            mAKHLabel.TabIndex = 4;
            mAKHLabel.Text = "Mã khoa:";
            // 
            // mASVLabel
            // 
            mASVLabel.AutoSize = true;
            mASVLabel.Location = new System.Drawing.Point(21, 38);
            mASVLabel.Name = "mASVLabel";
            mASVLabel.Size = new System.Drawing.Size(54, 19);
            mASVLabel.TabIndex = 0;
            mASVLabel.Text = "Mã SV";
            // 
            // hOLabel
            // 
            hOLabel.AutoSize = true;
            hOLabel.Location = new System.Drawing.Point(21, 126);
            hOLabel.Name = "hOLabel";
            hOLabel.Size = new System.Drawing.Size(28, 19);
            hOLabel.TabIndex = 2;
            hOLabel.Text = "Họ";
            // 
            // tENLabel
            // 
            tENLabel.AutoSize = true;
            tENLabel.Location = new System.Drawing.Point(21, 219);
            tENLabel.Name = "tENLabel";
            tENLabel.Size = new System.Drawing.Size(32, 19);
            tENLabel.TabIndex = 4;
            tENLabel.Text = "Tên";
            // 
            // mALOPLabel1
            // 
            mALOPLabel1.AutoSize = true;
            mALOPLabel1.Location = new System.Drawing.Point(21, 302);
            mALOPLabel1.Name = "mALOPLabel1";
            mALOPLabel1.Size = new System.Drawing.Size(59, 19);
            mALOPLabel1.TabIndex = 6;
            mALOPLabel1.Text = "Mã Lớp";
            // 
            // nGAYSINHLabel
            // 
            nGAYSINHLabel.AutoSize = true;
            nGAYSINHLabel.Location = new System.Drawing.Point(469, 122);
            nGAYSINHLabel.Name = "nGAYSINHLabel";
            nGAYSINHLabel.Size = new System.Drawing.Size(72, 19);
            nGAYSINHLabel.TabIndex = 10;
            nGAYSINHLabel.Text = "Ngày Sinh";
            // 
            // nOISINHLabel
            // 
            nOISINHLabel.AutoSize = true;
            nOISINHLabel.Location = new System.Drawing.Point(882, 124);
            nOISINHLabel.Name = "nOISINHLabel";
            nOISINHLabel.Size = new System.Drawing.Size(62, 19);
            nOISINHLabel.TabIndex = 12;
            nOISINHLabel.Text = "Nơi Sinh";
            // 
            // dIACHILabel
            // 
            dIACHILabel.AutoSize = true;
            dIACHILabel.Location = new System.Drawing.Point(469, 219);
            dIACHILabel.Name = "dIACHILabel";
            dIACHILabel.Size = new System.Drawing.Size(55, 19);
            dIACHILabel.TabIndex = 14;
            dIACHILabel.Text = "Địa Chỉ";
            // 
            // gHICHULabel
            // 
            gHICHULabel.AutoSize = true;
            gHICHULabel.Location = new System.Drawing.Point(469, 302);
            gHICHULabel.Name = "gHICHULabel";
            gHICHULabel.Size = new System.Drawing.Size(59, 19);
            gHICHULabel.TabIndex = 16;
            gHICHULabel.Text = "Ghi Chú";
            // 
            // pHAILabel
            // 
            pHAILabel.AutoSize = true;
            pHAILabel.Location = new System.Drawing.Point(469, 38);
            pHAILabel.Name = "pHAILabel";
            pHAILabel.Size = new System.Drawing.Size(38, 19);
            pHAILabel.TabIndex = 19;
            pHAILabel.Text = "Phái:";
            // 
            // barManager1
            // 
            this.barManager1.Bars.AddRange(new DevExpress.XtraBars.Bar[] {
            this.bar1});
            this.barManager1.DockControls.Add(this.barDockControlTop);
            this.barManager1.DockControls.Add(this.barDockControlBottom);
            this.barManager1.DockControls.Add(this.barDockControlLeft);
            this.barManager1.DockControls.Add(this.barDockControlRight);
            this.barManager1.DockControls.Add(this.standaloneBarDockControl1);
            this.barManager1.Form = this;
            this.barManager1.Items.AddRange(new DevExpress.XtraBars.BarItem[] {
            this.btnThem,
            this.btnXoa,
            this.btnHieuChinh,
            this.btnGhi,
            this.btnPhucHoi,
            this.btnTaiLai,
            this.btnThoat,
            this.btnInDSSV,
            this.btnInPDSV});
            this.barManager1.MaxItemId = 9;
            // 
            // bar1
            // 
            this.bar1.BarName = "Tools";
            this.bar1.DockCol = 0;
            this.bar1.DockRow = 0;
            this.bar1.DockStyle = DevExpress.XtraBars.BarDockStyle.Top;
            this.bar1.FloatLocation = new System.Drawing.Point(322, 108);
            this.bar1.LinksPersistInfo.AddRange(new DevExpress.XtraBars.LinkPersistInfo[] {
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnThem, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnXoa, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnHieuChinh, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnGhi, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnPhucHoi, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnTaiLai, "", true, true, true, 0, null, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnThoat, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph)});
            this.bar1.OptionsBar.DrawBorder = false;
            this.bar1.OptionsBar.DrawDragBorder = false;
            this.bar1.Text = "Tools";
            // 
            // btnThem
            // 
            this.btnThem.Caption = "Thêm";
            this.btnThem.Id = 0;
            this.btnThem.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnThem.ImageOptions.Image")));
            this.btnThem.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnThem.ImageOptions.LargeImage")));
            this.btnThem.Name = "btnThem";
            this.btnThem.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnThem_ItemClick);
            // 
            // btnXoa
            // 
            this.btnXoa.Caption = "Xoá";
            this.btnXoa.Id = 1;
            this.btnXoa.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnXoa.ImageOptions.Image")));
            this.btnXoa.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnXoa.ImageOptions.LargeImage")));
            this.btnXoa.Name = "btnXoa";
            this.btnXoa.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnXoa_ItemClick);
            // 
            // btnHieuChinh
            // 
            this.btnHieuChinh.Caption = "Hiệu Chỉnh";
            this.btnHieuChinh.Id = 2;
            this.btnHieuChinh.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnHieuChinh.ImageOptions.Image")));
            this.btnHieuChinh.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnHieuChinh.ImageOptions.LargeImage")));
            this.btnHieuChinh.Name = "btnHieuChinh";
            this.btnHieuChinh.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnHieuChinh_ItemClick);
            // 
            // btnGhi
            // 
            this.btnGhi.Caption = "Ghi";
            this.btnGhi.Id = 3;
            this.btnGhi.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnGhi.ImageOptions.Image")));
            this.btnGhi.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnGhi.ImageOptions.LargeImage")));
            this.btnGhi.Name = "btnGhi";
            this.btnGhi.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnGhi_ItemClick);
            // 
            // btnPhucHoi
            // 
            this.btnPhucHoi.Caption = "Phục Hôì";
            this.btnPhucHoi.Id = 4;
            this.btnPhucHoi.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnPhucHoi.ImageOptions.Image")));
            this.btnPhucHoi.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnPhucHoi.ImageOptions.LargeImage")));
            this.btnPhucHoi.Name = "btnPhucHoi";
            this.btnPhucHoi.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnPhucHoi_ItemClick);
            // 
            // btnTaiLai
            // 
            this.btnTaiLai.Caption = "Tải lại";
            this.btnTaiLai.Id = 5;
            this.btnTaiLai.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnTaiLai.ImageOptions.Image")));
            this.btnTaiLai.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnTaiLai.ImageOptions.LargeImage")));
            this.btnTaiLai.Name = "btnTaiLai";
            this.btnTaiLai.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnTaiLai_ItemClick);
            // 
            // btnThoat
            // 
            this.btnThoat.Caption = "Thoát";
            this.btnThoat.Id = 6;
            this.btnThoat.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnThoat.ImageOptions.Image")));
            this.btnThoat.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnThoat.ImageOptions.LargeImage")));
            this.btnThoat.Name = "btnThoat";
            this.btnThoat.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnThoat_ItemClick);
            // 
            // barDockControlTop
            // 
            this.barDockControlTop.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.barDockControlTop.Appearance.Options.UseBackColor = true;
            this.barDockControlTop.CausesValidation = false;
            this.barDockControlTop.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControlTop.Location = new System.Drawing.Point(0, 0);
            this.barDockControlTop.Manager = this.barManager1;
            this.barDockControlTop.Margin = new System.Windows.Forms.Padding(4);
            this.barDockControlTop.Size = new System.Drawing.Size(1604, 31);
            // 
            // barDockControlBottom
            // 
            this.barDockControlBottom.CausesValidation = false;
            this.barDockControlBottom.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControlBottom.Location = new System.Drawing.Point(0, 881);
            this.barDockControlBottom.Manager = this.barManager1;
            this.barDockControlBottom.Margin = new System.Windows.Forms.Padding(4);
            this.barDockControlBottom.Size = new System.Drawing.Size(1604, 0);
            // 
            // barDockControlLeft
            // 
            this.barDockControlLeft.CausesValidation = false;
            this.barDockControlLeft.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControlLeft.Location = new System.Drawing.Point(0, 31);
            this.barDockControlLeft.Manager = this.barManager1;
            this.barDockControlLeft.Margin = new System.Windows.Forms.Padding(4);
            this.barDockControlLeft.Size = new System.Drawing.Size(0, 850);
            // 
            // barDockControlRight
            // 
            this.barDockControlRight.CausesValidation = false;
            this.barDockControlRight.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControlRight.Location = new System.Drawing.Point(1604, 31);
            this.barDockControlRight.Manager = this.barManager1;
            this.barDockControlRight.Margin = new System.Windows.Forms.Padding(4);
            this.barDockControlRight.Size = new System.Drawing.Size(0, 850);
            // 
            // standaloneBarDockControl1
            // 
            this.standaloneBarDockControl1.CausesValidation = false;
            this.standaloneBarDockControl1.Dock = System.Windows.Forms.DockStyle.Top;
            this.standaloneBarDockControl1.Location = new System.Drawing.Point(4, 23);
            this.standaloneBarDockControl1.Manager = this.barManager1;
            this.standaloneBarDockControl1.Name = "standaloneBarDockControl1";
            this.standaloneBarDockControl1.Size = new System.Drawing.Size(1014, 34);
            this.standaloneBarDockControl1.Text = "standaloneBarDockControl1";
            this.standaloneBarDockControl1.Click += new System.EventHandler(this.standaloneBarDockControl1_Click_1);
            // 
            // btnInDSSV
            // 
            this.btnInDSSV.Caption = "In DSSV";
            this.btnInDSSV.Id = 7;
            this.btnInDSSV.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnInDSSV.ImageOptions.Image")));
            this.btnInDSSV.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnInDSSV.ImageOptions.LargeImage")));
            this.btnInDSSV.Name = "btnInDSSV";
            this.btnInDSSV.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.barButtonItem1_ItemClick);
            // 
            // btnInPDSV
            // 
            this.btnInPDSV.Caption = "In phiếu điểm SV";
            this.btnInPDSV.Id = 8;
            this.btnInPDSV.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnInPDSV.ImageOptions.Image")));
            this.btnInPDSV.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnInPDSV.ImageOptions.LargeImage")));
            this.btnInPDSV.Name = "btnInPDSV";
            this.btnInPDSV.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnInPDSV_ItemClick);
            // 
            // qLDSVDataSet
            // 
            this.qLDSVDataSet.DataSetName = "QLDSVDataSet";
            this.qLDSVDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // tableAdapterManager
            // 
            this.tableAdapterManager.BackupDataSetBeforeUpdate = false;
            this.tableAdapterManager.Connection = null;
            this.tableAdapterManager.UpdateOrder = DeTai_QLDSV.QLDSVDataSetTableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.label1.Location = new System.Drawing.Point(804, 7);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(55, 19);
            this.label1.TabIndex = 2;
            this.label1.Text = "KHOA";
            // 
            // dS_DIEM
            // 
            this.dS_DIEM.DataSetName = "DS_DIEM";
            this.dS_DIEM.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // lOPTableAdapter
            // 
            this.lOPTableAdapter.ClearBeforeFill = true;
            // 
            // sINHVIENTableAdapter
            // 
            this.sINHVIENTableAdapter.ClearBeforeFill = true;
            // 
            // lOPBindingSource
            // 
            this.lOPBindingSource.DataMember = "LOP";
            this.lOPBindingSource.DataSource = this.dS_DIEM;
            // 
            // gcLop
            // 
            this.gcLop.DataSource = this.lOPBindingSource;
            this.gcLop.Dock = System.Windows.Forms.DockStyle.Top;
            this.gcLop.EmbeddedNavigator.Margin = new System.Windows.Forms.Padding(1);
            this.gcLop.Location = new System.Drawing.Point(0, 31);
            this.gcLop.MainView = this.gvLop;
            this.gcLop.Margin = new System.Windows.Forms.Padding(4);
            this.gcLop.MenuManager = this.barManager1;
            this.gcLop.Name = "gcLop";
            this.gcLop.Size = new System.Drawing.Size(1604, 263);
            this.gcLop.TabIndex = 5;
            this.gcLop.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gvLop});
            // 
            // gvLop
            // 
            this.gvLop.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.colMALOP,
            this.colTENLOP,
            this.colMAKH});
            this.gvLop.FocusRectStyle = DevExpress.XtraGrid.Views.Grid.DrawFocusRectStyle.RowFullFocus;
            this.gvLop.GridControl = this.gcLop;
            this.gvLop.Name = "gvLop";
            this.gvLop.OptionsBehavior.ReadOnly = true;
            this.gvLop.OptionsCustomization.AllowColumnMoving = false;
            this.gvLop.OptionsDetail.EnableMasterViewMode = false;
            this.gvLop.OptionsView.ShowGroupPanel = false;
            this.gvLop.FocusedRowChanged += new DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventHandler(this.gvLop_FocusedRowChanged);
            this.gvLop.FocusedRowObjectChanged += new DevExpress.XtraGrid.Views.Base.FocusedRowObjectChangedEventHandler(this.gvLop_FocusedRowObjectChanged);
            // 
            // colMALOP
            // 
            this.colMALOP.Caption = "Mã lớp";
            this.colMALOP.FieldName = "MALOP";
            this.colMALOP.Name = "colMALOP";
            this.colMALOP.OptionsColumn.AllowEdit = false;
            this.colMALOP.Visible = true;
            this.colMALOP.VisibleIndex = 0;
            // 
            // colTENLOP
            // 
            this.colTENLOP.Caption = "Tên lớp";
            this.colTENLOP.FieldName = "TENLOP";
            this.colTENLOP.Name = "colTENLOP";
            this.colTENLOP.OptionsColumn.AllowEdit = false;
            this.colTENLOP.Visible = true;
            this.colTENLOP.VisibleIndex = 1;
            // 
            // colMAKH
            // 
            this.colMAKH.Caption = "Mã khoa";
            this.colMAKH.FieldName = "MAKH";
            this.colMAKH.Name = "colMAKH";
            this.colMAKH.OptionsColumn.AllowEdit = false;
            this.colMAKH.Visible = true;
            this.colMAKH.VisibleIndex = 2;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(mAKHLabel);
            this.groupBox1.Controls.Add(this.txtMaKhoa);
            this.groupBox1.Controls.Add(tENLOPLabel);
            this.groupBox1.Controls.Add(this.txtTenLop);
            this.groupBox1.Controls.Add(mALOPLabel);
            this.groupBox1.Controls.Add(this.txtMaLop);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Left;
            this.groupBox1.Enabled = false;
            this.groupBox1.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(0, 294);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(4);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(4);
            this.groupBox1.Size = new System.Drawing.Size(582, 587);
            this.groupBox1.TabIndex = 6;
            this.groupBox1.TabStop = false;
            // 
            // txtMaKhoa
            // 
            this.txtMaKhoa.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.lOPBindingSource, "MAKH", true));
            this.txtMaKhoa.Enabled = false;
            this.txtMaKhoa.Location = new System.Drawing.Point(112, 381);
            this.txtMaKhoa.Margin = new System.Windows.Forms.Padding(4);
            this.txtMaKhoa.Name = "txtMaKhoa";
            this.txtMaKhoa.Size = new System.Drawing.Size(308, 26);
            this.txtMaKhoa.TabIndex = 5;
            // 
            // txtTenLop
            // 
            this.txtTenLop.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.lOPBindingSource, "TENLOP", true));
            this.txtTenLop.Location = new System.Drawing.Point(112, 235);
            this.txtTenLop.Margin = new System.Windows.Forms.Padding(4);
            this.txtTenLop.Name = "txtTenLop";
            this.txtTenLop.Size = new System.Drawing.Size(435, 26);
            this.txtTenLop.TabIndex = 3;
            // 
            // txtMaLop
            // 
            this.txtMaLop.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.txtMaLop.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.lOPBindingSource, "MALOP", true));
            this.txtMaLop.Enabled = false;
            this.txtMaLop.Location = new System.Drawing.Point(112, 96);
            this.txtMaLop.Margin = new System.Windows.Forms.Padding(4);
            this.txtMaLop.Name = "txtMaLop";
            this.txtMaLop.Size = new System.Drawing.Size(308, 26);
            this.txtMaLop.TabIndex = 1;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.groupBox4);
            this.groupBox2.Controls.Add(this.dgcSinhVien);
            this.groupBox2.Controls.Add(this.standaloneBarDockControl1);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox2.Location = new System.Drawing.Point(582, 294);
            this.groupBox2.Margin = new System.Windows.Forms.Padding(4);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Padding = new System.Windows.Forms.Padding(4);
            this.groupBox2.Size = new System.Drawing.Size(1022, 587);
            this.groupBox2.TabIndex = 12;
            this.groupBox2.TabStop = false;
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.nghiHoc);
            this.groupBox4.Controls.Add(pHAILabel);
            this.groupBox4.Controls.Add(this.pHAICheckEdit);
            this.groupBox4.Controls.Add(gHICHULabel);
            this.groupBox4.Controls.Add(this.txtGhiChu);
            this.groupBox4.Controls.Add(dIACHILabel);
            this.groupBox4.Controls.Add(this.txtDiaChi);
            this.groupBox4.Controls.Add(nOISINHLabel);
            this.groupBox4.Controls.Add(this.txtNoiSinh);
            this.groupBox4.Controls.Add(nGAYSINHLabel);
            this.groupBox4.Controls.Add(this.birthDay);
            this.groupBox4.Controls.Add(mALOPLabel1);
            this.groupBox4.Controls.Add(this.txtMaLopSv);
            this.groupBox4.Controls.Add(tENLabel);
            this.groupBox4.Controls.Add(this.txtTenSv);
            this.groupBox4.Controls.Add(hOLabel);
            this.groupBox4.Controls.Add(this.txtHoSv);
            this.groupBox4.Controls.Add(mASVLabel);
            this.groupBox4.Controls.Add(this.txtMaSV);
            this.groupBox4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox4.Enabled = false;
            this.groupBox4.Location = new System.Drawing.Point(4, 262);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(1014, 321);
            this.groupBox4.TabIndex = 2;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Thông tin sinh viên";
            this.groupBox4.Enter += new System.EventHandler(this.groupBox4_Enter);
            // 
            // nghiHoc
            // 
            this.nghiHoc.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.sINHVIENBindingSource, "NGHIHOC", true));
            this.nghiHoc.EditValue = true;
            this.nghiHoc.Location = new System.Drawing.Point(694, 36);
            this.nghiHoc.MenuManager = this.barManager1;
            this.nghiHoc.Name = "nghiHoc";
            this.nghiHoc.Properties.Appearance.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.nghiHoc.Properties.Appearance.Options.UseFont = true;
            this.nghiHoc.Properties.Caption = " Nghỉ học";
            this.nghiHoc.Size = new System.Drawing.Size(124, 23);
            this.nghiHoc.TabIndex = 21;
            // 
            // sINHVIENBindingSource
            // 
            this.sINHVIENBindingSource.DataMember = "FK_SINHVIEN_LOP";
            this.sINHVIENBindingSource.DataSource = this.lOPBindingSource;
            // 
            // pHAICheckEdit
            // 
            this.pHAICheckEdit.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.sINHVIENBindingSource, "PHAI", true));
            this.pHAICheckEdit.EditValue = true;
            this.pHAICheckEdit.Location = new System.Drawing.Point(549, 39);
            this.pHAICheckEdit.MenuManager = this.barManager1;
            this.pHAICheckEdit.Name = "pHAICheckEdit";
            this.pHAICheckEdit.Properties.Caption = "Nam";
            this.pHAICheckEdit.Size = new System.Drawing.Size(82, 19);
            this.pHAICheckEdit.TabIndex = 20;
            // 
            // txtGhiChu
            // 
            this.txtGhiChu.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.sINHVIENBindingSource, "GHICHU", true));
            this.txtGhiChu.Location = new System.Drawing.Point(603, 304);
            this.txtGhiChu.MenuManager = this.barManager1;
            this.txtGhiChu.Name = "txtGhiChu";
            this.txtGhiChu.Size = new System.Drawing.Size(633, 20);
            this.txtGhiChu.TabIndex = 17;
            // 
            // txtDiaChi
            // 
            this.txtDiaChi.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.sINHVIENBindingSource, "DIACHI", true));
            this.txtDiaChi.Location = new System.Drawing.Point(603, 221);
            this.txtDiaChi.MenuManager = this.barManager1;
            this.txtDiaChi.Name = "txtDiaChi";
            this.txtDiaChi.Size = new System.Drawing.Size(701, 20);
            this.txtDiaChi.TabIndex = 15;
            // 
            // txtNoiSinh
            // 
            this.txtNoiSinh.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.sINHVIENBindingSource, "NOISINH", true));
            this.txtNoiSinh.Location = new System.Drawing.Point(980, 119);
            this.txtNoiSinh.MenuManager = this.barManager1;
            this.txtNoiSinh.Name = "txtNoiSinh";
            this.txtNoiSinh.Properties.Appearance.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtNoiSinh.Properties.Appearance.Options.UseFont = true;
            this.txtNoiSinh.Size = new System.Drawing.Size(360, 26);
            this.txtNoiSinh.TabIndex = 13;
            // 
            // birthDay
            // 
            this.birthDay.DataBindings.Add(new System.Windows.Forms.Binding("Value", this.sINHVIENBindingSource, "NGAYSINH", true));
            this.birthDay.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.birthDay.ImeMode = System.Windows.Forms.ImeMode.AlphaFull;
            this.birthDay.Location = new System.Drawing.Point(603, 118);
            this.birthDay.MaxDate = new System.DateTime(2018, 11, 29, 0, 0, 0, 0);
            this.birthDay.Name = "birthDay";
            this.birthDay.Size = new System.Drawing.Size(148, 26);
            this.birthDay.TabIndex = 11;
            this.birthDay.Value = new System.DateTime(2018, 11, 29, 0, 0, 0, 0);
            // 
            // txtMaLopSv
            // 
            this.txtMaLopSv.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.sINHVIENBindingSource, "MALOP", true));
            this.txtMaLopSv.Enabled = false;
            this.txtMaLopSv.Location = new System.Drawing.Point(120, 304);
            this.txtMaLopSv.MenuManager = this.barManager1;
            this.txtMaLopSv.Name = "txtMaLopSv";
            this.txtMaLopSv.Size = new System.Drawing.Size(183, 20);
            this.txtMaLopSv.TabIndex = 7;
            // 
            // txtTenSv
            // 
            this.txtTenSv.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.sINHVIENBindingSource, "TEN", true));
            this.txtTenSv.Location = new System.Drawing.Point(120, 221);
            this.txtTenSv.MenuManager = this.barManager1;
            this.txtTenSv.Name = "txtTenSv";
            this.txtTenSv.Size = new System.Drawing.Size(229, 20);
            this.txtTenSv.TabIndex = 5;
            // 
            // txtHoSv
            // 
            this.txtHoSv.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.sINHVIENBindingSource, "HO", true));
            this.txtHoSv.Location = new System.Drawing.Point(120, 125);
            this.txtHoSv.MenuManager = this.barManager1;
            this.txtHoSv.Name = "txtHoSv";
            this.txtHoSv.Size = new System.Drawing.Size(229, 20);
            this.txtHoSv.TabIndex = 3;
            // 
            // txtMaSV
            // 
            this.txtMaSV.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.sINHVIENBindingSource, "MASV", true));
            this.txtMaSV.Location = new System.Drawing.Point(120, 39);
            this.txtMaSV.MenuManager = this.barManager1;
            this.txtMaSV.Name = "txtMaSV";
            this.txtMaSV.Properties.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.txtMaSV.Size = new System.Drawing.Size(183, 20);
            this.txtMaSV.TabIndex = 1;
            // 
            // dgcSinhVien
            // 
            this.dgcSinhVien.DataSource = this.sINHVIENBindingSource;
            this.dgcSinhVien.Dock = System.Windows.Forms.DockStyle.Top;
            this.dgcSinhVien.EmbeddedNavigator.Margin = new System.Windows.Forms.Padding(1);
            this.dgcSinhVien.Location = new System.Drawing.Point(4, 57);
            this.dgcSinhVien.MainView = this.dgvSinhVien;
            this.dgcSinhVien.MenuManager = this.barManager1;
            this.dgcSinhVien.Name = "dgcSinhVien";
            this.dgcSinhVien.Size = new System.Drawing.Size(1014, 205);
            this.dgcSinhVien.TabIndex = 1;
            this.dgcSinhVien.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.dgvSinhVien});
            // 
            // dgvSinhVien
            // 
            this.dgvSinhVien.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.colMASV,
            this.colHO,
            this.colTEN,
            this.colMALOP1,
            this.colPHAI,
            this.colNGAYSINH,
            this.colNOISINH,
            this.colDIACHI,
            this.colGHICHU,
            this.colNGHIHOC});
            this.dgvSinhVien.GridControl = this.dgcSinhVien;
            this.dgvSinhVien.Name = "dgvSinhVien";
            this.dgvSinhVien.OptionsBehavior.ReadOnly = true;
            this.dgvSinhVien.OptionsDetail.EnableMasterViewMode = false;
            this.dgvSinhVien.OptionsView.ShowGroupPanel = false;
            // 
            // colMASV
            // 
            this.colMASV.Caption = "Mã Sinh Viên";
            this.colMASV.FieldName = "MASV";
            this.colMASV.Name = "colMASV";
            this.colMASV.OptionsColumn.AllowEdit = false;
            this.colMASV.OptionsColumn.ReadOnly = true;
            this.colMASV.Visible = true;
            this.colMASV.VisibleIndex = 0;
            // 
            // colHO
            // 
            this.colHO.Caption = "Họ";
            this.colHO.FieldName = "HO";
            this.colHO.Name = "colHO";
            this.colHO.OptionsColumn.AllowEdit = false;
            this.colHO.OptionsColumn.ReadOnly = true;
            this.colHO.Visible = true;
            this.colHO.VisibleIndex = 1;
            // 
            // colTEN
            // 
            this.colTEN.Caption = "Tên";
            this.colTEN.FieldName = "TEN";
            this.colTEN.Name = "colTEN";
            this.colTEN.OptionsColumn.AllowEdit = false;
            this.colTEN.OptionsColumn.ReadOnly = true;
            this.colTEN.Visible = true;
            this.colTEN.VisibleIndex = 2;
            // 
            // colMALOP1
            // 
            this.colMALOP1.Caption = "Mã Lớp";
            this.colMALOP1.FieldName = "MALOP";
            this.colMALOP1.Name = "colMALOP1";
            this.colMALOP1.OptionsColumn.AllowEdit = false;
            this.colMALOP1.OptionsColumn.ReadOnly = true;
            this.colMALOP1.Visible = true;
            this.colMALOP1.VisibleIndex = 3;
            // 
            // colPHAI
            // 
            this.colPHAI.Caption = "Phái";
            this.colPHAI.FieldName = "PHAI";
            this.colPHAI.Name = "colPHAI";
            this.colPHAI.OptionsColumn.AllowEdit = false;
            this.colPHAI.OptionsColumn.ReadOnly = true;
            this.colPHAI.Visible = true;
            this.colPHAI.VisibleIndex = 4;
            // 
            // colNGAYSINH
            // 
            this.colNGAYSINH.Caption = "Ngày Sinh";
            this.colNGAYSINH.FieldName = "NGAYSINH";
            this.colNGAYSINH.Name = "colNGAYSINH";
            this.colNGAYSINH.OptionsColumn.AllowEdit = false;
            this.colNGAYSINH.OptionsColumn.ReadOnly = true;
            this.colNGAYSINH.Visible = true;
            this.colNGAYSINH.VisibleIndex = 5;
            // 
            // colNOISINH
            // 
            this.colNOISINH.Caption = "Nơi Sinh";
            this.colNOISINH.FieldName = "NOISINH";
            this.colNOISINH.Name = "colNOISINH";
            this.colNOISINH.OptionsColumn.AllowEdit = false;
            this.colNOISINH.OptionsColumn.ReadOnly = true;
            this.colNOISINH.Visible = true;
            this.colNOISINH.VisibleIndex = 6;
            // 
            // colDIACHI
            // 
            this.colDIACHI.Caption = "Địa Chỉ";
            this.colDIACHI.FieldName = "DIACHI";
            this.colDIACHI.Name = "colDIACHI";
            this.colDIACHI.OptionsColumn.AllowEdit = false;
            this.colDIACHI.OptionsColumn.ReadOnly = true;
            this.colDIACHI.Visible = true;
            this.colDIACHI.VisibleIndex = 7;
            // 
            // colGHICHU
            // 
            this.colGHICHU.Caption = "Ghi Chú";
            this.colGHICHU.FieldName = "GHICHU";
            this.colGHICHU.Name = "colGHICHU";
            this.colGHICHU.OptionsColumn.AllowEdit = false;
            this.colGHICHU.OptionsColumn.ReadOnly = true;
            this.colGHICHU.Visible = true;
            this.colGHICHU.VisibleIndex = 8;
            // 
            // colNGHIHOC
            // 
            this.colNGHIHOC.Caption = "Nghỉ Học";
            this.colNGHIHOC.FieldName = "NGHIHOC";
            this.colNGHIHOC.Name = "colNGHIHOC";
            this.colNGHIHOC.OptionsColumn.AllowEdit = false;
            this.colNGHIHOC.OptionsColumn.ReadOnly = true;
            this.colNGHIHOC.Visible = true;
            this.colNGHIHOC.VisibleIndex = 9;
            // 
            // bar3
            // 
            this.bar3.BarName = "Status bar";
            this.bar3.CanDockStyle = DevExpress.XtraBars.BarCanDockStyle.Bottom;
            this.bar3.DockCol = 0;
            this.bar3.DockRow = 0;
            this.bar3.DockStyle = DevExpress.XtraBars.BarDockStyle.Bottom;
            this.bar3.OptionsBar.AllowQuickCustomization = false;
            this.bar3.OptionsBar.DrawDragBorder = false;
            this.bar3.OptionsBar.UseWholeRow = true;
            this.bar3.Text = "Status bar";
            // 
            // barManager2
            // 
            this.barManager2.Bars.AddRange(new DevExpress.XtraBars.Bar[] {
            this.bar2});
            this.barManager2.DockControls.Add(this.barDockControl1);
            this.barManager2.DockControls.Add(this.barDockControl2);
            this.barManager2.DockControls.Add(this.barDockControl3);
            this.barManager2.DockControls.Add(this.barDockControl4);
            this.barManager2.Form = this;
            this.barManager2.Items.AddRange(new DevExpress.XtraBars.BarItem[] {
            this.btnThemSv,
            this.btnXoaSv,
            this.btnHieuChinhSv,
            this.btnGhiSv,
            this.btnPhucHoiSv,
            this.btnTaiLaiSv});
            this.barManager2.MaxItemId = 7;
            // 
            // bar2
            // 
            this.bar2.BarAppearance.Hovered.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.bar2.BarAppearance.Hovered.Options.UseBackColor = true;
            this.bar2.BarName = "Tools";
            this.bar2.DockCol = 0;
            this.bar2.DockRow = 0;
            this.bar2.DockStyle = DevExpress.XtraBars.BarDockStyle.Standalone;
            this.bar2.FloatLocation = new System.Drawing.Point(878, 256);
            this.bar2.FloatSize = new System.Drawing.Size(481, 31);
            this.bar2.LinksPersistInfo.AddRange(new DevExpress.XtraBars.LinkPersistInfo[] {
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnThemSv, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnXoaSv, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnHieuChinhSv, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnGhiSv, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnPhucHoiSv, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnTaiLaiSv, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnInDSSV, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnInPDSV, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph)});
            this.bar2.OptionsBar.DrawBorder = false;
            this.bar2.OptionsBar.DrawDragBorder = false;
            this.bar2.StandaloneBarDockControl = this.standaloneBarDockControl1;
            this.bar2.Text = "Tools";
            // 
            // btnThemSv
            // 
            this.btnThemSv.Caption = "Thêm";
            this.btnThemSv.Id = 0;
            this.btnThemSv.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnThemSv.ImageOptions.Image")));
            this.btnThemSv.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnThemSv.ImageOptions.LargeImage")));
            this.btnThemSv.Name = "btnThemSv";
            this.btnThemSv.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnThemSv_ItemClick);
            // 
            // btnXoaSv
            // 
            this.btnXoaSv.Caption = "Xoá";
            this.btnXoaSv.Id = 1;
            this.btnXoaSv.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnXoaSv.ImageOptions.Image")));
            this.btnXoaSv.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnXoaSv.ImageOptions.LargeImage")));
            this.btnXoaSv.Name = "btnXoaSv";
            this.btnXoaSv.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnXoaSv_ItemClick);
            // 
            // btnHieuChinhSv
            // 
            this.btnHieuChinhSv.Caption = "Hiệu Chỉnh";
            this.btnHieuChinhSv.Id = 2;
            this.btnHieuChinhSv.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnHieuChinhSv.ImageOptions.Image")));
            this.btnHieuChinhSv.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnHieuChinhSv.ImageOptions.LargeImage")));
            this.btnHieuChinhSv.Name = "btnHieuChinhSv";
            this.btnHieuChinhSv.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnHieuChinhSv_ItemClick);
            // 
            // btnGhiSv
            // 
            this.btnGhiSv.Caption = "Ghi";
            this.btnGhiSv.Id = 3;
            this.btnGhiSv.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnGhiSv.ImageOptions.Image")));
            this.btnGhiSv.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnGhiSv.ImageOptions.LargeImage")));
            this.btnGhiSv.Name = "btnGhiSv";
            this.btnGhiSv.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnGhiSv_ItemClick);
            // 
            // btnPhucHoiSv
            // 
            this.btnPhucHoiSv.Caption = "Phục Hồi";
            this.btnPhucHoiSv.Id = 4;
            this.btnPhucHoiSv.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnPhucHoiSv.ImageOptions.Image")));
            this.btnPhucHoiSv.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnPhucHoiSv.ImageOptions.LargeImage")));
            this.btnPhucHoiSv.Name = "btnPhucHoiSv";
            this.btnPhucHoiSv.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnPhucHoiSv_ItemClick);
            // 
            // btnTaiLaiSv
            // 
            this.btnTaiLaiSv.Caption = "Tải Lại";
            this.btnTaiLaiSv.Id = 5;
            this.btnTaiLaiSv.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnTaiLaiSv.ImageOptions.Image")));
            this.btnTaiLaiSv.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnTaiLaiSv.ImageOptions.LargeImage")));
            this.btnTaiLaiSv.Name = "btnTaiLaiSv";
            this.btnTaiLaiSv.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnTaiLaiSv_ItemClick);
            // 
            // barDockControl1
            // 
            this.barDockControl1.CausesValidation = false;
            this.barDockControl1.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControl1.Location = new System.Drawing.Point(0, 0);
            this.barDockControl1.Manager = this.barManager2;
            this.barDockControl1.Margin = new System.Windows.Forms.Padding(4);
            this.barDockControl1.Size = new System.Drawing.Size(1604, 0);
            // 
            // barDockControl2
            // 
            this.barDockControl2.CausesValidation = false;
            this.barDockControl2.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControl2.Location = new System.Drawing.Point(0, 881);
            this.barDockControl2.Manager = this.barManager2;
            this.barDockControl2.Margin = new System.Windows.Forms.Padding(4);
            this.barDockControl2.Size = new System.Drawing.Size(1604, 0);
            // 
            // barDockControl3
            // 
            this.barDockControl3.CausesValidation = false;
            this.barDockControl3.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControl3.Location = new System.Drawing.Point(0, 0);
            this.barDockControl3.Manager = this.barManager2;
            this.barDockControl3.Margin = new System.Windows.Forms.Padding(4);
            this.barDockControl3.Size = new System.Drawing.Size(0, 881);
            // 
            // barDockControl4
            // 
            this.barDockControl4.CausesValidation = false;
            this.barDockControl4.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControl4.Location = new System.Drawing.Point(1604, 0);
            this.barDockControl4.Manager = this.barManager2;
            this.barDockControl4.Margin = new System.Windows.Forms.Padding(4);
            this.barDockControl4.Size = new System.Drawing.Size(0, 881);
            // 
            // cmbKhoa
            // 
            this.cmbKhoa.DisplayMember = "TENSERVER";
            this.cmbKhoa.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbKhoa.FormattingEnabled = true;
            this.cmbKhoa.Location = new System.Drawing.Point(946, 4);
            this.cmbKhoa.Margin = new System.Windows.Forms.Padding(4);
            this.cmbKhoa.Name = "cmbKhoa";
            this.cmbKhoa.Size = new System.Drawing.Size(458, 27);
            this.cmbKhoa.TabIndex = 1;
            this.cmbKhoa.ValueMember = "TENSERVER";
            this.cmbKhoa.SelectedIndexChanged += new System.EventHandler(this.cmbKhoa_SelectedIndexChanged);
            // 
            // tableAdapterManager1
            // 
            this.tableAdapterManager1.BackupDataSetBeforeUpdate = false;
            this.tableAdapterManager1.DIEMTableAdapter = null;
            this.tableAdapterManager1.GIANGVIENTableAdapter = null;
            this.tableAdapterManager1.KHOATableAdapter = null;
            this.tableAdapterManager1.LOPTableAdapter = this.lOPTableAdapter;
            this.tableAdapterManager1.MONHOCTableAdapter = null;
            this.tableAdapterManager1.SINHVIENTableAdapter = this.sINHVIENTableAdapter;
            this.tableAdapterManager1.UpdateOrder = DeTai_QLDSV.DS_DIEMTableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
            // 
            // frmLop1
            // 
            this.Appearance.Options.UseFont = true;
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 19F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1604, 881);
            this.Controls.Add(this.cmbKhoa);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.gcLop);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.Controls.Add(this.barDockControl3);
            this.Controls.Add(this.barDockControl4);
            this.Controls.Add(this.barDockControl2);
            this.Controls.Add(this.barDockControl1);
            this.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "frmLop1";
            this.Text = "Lớp & Sinh viên";
            this.Load += new System.EventHandler(this.frmLop1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.qLDSVDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dS_DIEM)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.lOPBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcLop)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvLop)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nghiHoc.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sINHVIENBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pHAICheckEdit.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtGhiChu.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtDiaChi.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtNoiSinh.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMaLopSv.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtTenSv.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtHoSv.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMaSV.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgcSinhVien)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSinhVien)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager2)).EndInit();
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
        private DevExpress.XtraBars.BarButtonItem btnThem;
        private DevExpress.XtraBars.BarButtonItem btnXoa;
        private DevExpress.XtraBars.BarButtonItem btnHieuChinh;
        private DevExpress.XtraBars.BarButtonItem btnGhi;
        private DevExpress.XtraBars.BarButtonItem btnPhucHoi;
        private DevExpress.XtraBars.BarButtonItem btnTaiLai;
        private DevExpress.XtraBars.BarButtonItem btnThoat;
        private QLDSVDataSet qLDSVDataSet;
        private QLDSVDataSetTableAdapters.TableAdapterManager tableAdapterManager;
        private DS_DIEM dS_DIEM;
        private DS_DIEMTableAdapters.LOPTableAdapter lOPTableAdapter;
        private System.Windows.Forms.BindingSource lOPBindingSource;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox txtMaKhoa;
        private System.Windows.Forms.TextBox txtTenLop;
        private System.Windows.Forms.TextBox txtMaLop;
        private DevExpress.XtraGrid.GridControl gcLop;
        private DevExpress.XtraGrid.Views.Grid.GridView gvLop;
        private DevExpress.XtraGrid.Columns.GridColumn colMALOP;
        private DevExpress.XtraGrid.Columns.GridColumn colTENLOP;
        private DevExpress.XtraGrid.Columns.GridColumn colMAKH;
        private DS_DIEMTableAdapters.SINHVIENTableAdapter sINHVIENTableAdapter;
        private System.Windows.Forms.GroupBox groupBox2;
        private DevExpress.XtraBars.BarDockControl barDockControl3;
        private DevExpress.XtraBars.BarManager barManager2;
        private DevExpress.XtraBars.Bar bar2;
        private DevExpress.XtraBars.BarButtonItem btnThemSv;
        private DevExpress.XtraBars.BarButtonItem btnXoaSv;
        private DevExpress.XtraBars.BarButtonItem btnHieuChinhSv;
        private DevExpress.XtraBars.BarButtonItem btnGhiSv;
        private DevExpress.XtraBars.BarButtonItem btnPhucHoiSv;
        private DevExpress.XtraBars.BarButtonItem btnTaiLaiSv;
        private DevExpress.XtraBars.BarDockControl barDockControl1;
        private DevExpress.XtraBars.BarDockControl barDockControl2;
        private DevExpress.XtraBars.BarDockControl barDockControl4;
        private DevExpress.XtraBars.Bar bar3;
        private System.Windows.Forms.Label label1;
        private DevExpress.XtraBars.StandaloneBarDockControl standaloneBarDockControl1;
        private DevExpress.XtraGrid.GridControl dgcSinhVien;
        private System.Windows.Forms.BindingSource sINHVIENBindingSource;
        private DevExpress.XtraGrid.Views.Grid.GridView dgvSinhVien;
        private System.Windows.Forms.GroupBox groupBox4;
        private DevExpress.XtraGrid.Columns.GridColumn colMASV;
        private DevExpress.XtraGrid.Columns.GridColumn colHO;
        private DevExpress.XtraGrid.Columns.GridColumn colTEN;
        private DevExpress.XtraGrid.Columns.GridColumn colMALOP1;
        private DevExpress.XtraGrid.Columns.GridColumn colPHAI;
        private DevExpress.XtraGrid.Columns.GridColumn colNGAYSINH;
        private DevExpress.XtraGrid.Columns.GridColumn colNOISINH;
        private DevExpress.XtraGrid.Columns.GridColumn colDIACHI;
        private DevExpress.XtraGrid.Columns.GridColumn colGHICHU;
        private DevExpress.XtraGrid.Columns.GridColumn colNGHIHOC;
        private DevExpress.XtraEditors.TextEdit txtGhiChu;
        private DevExpress.XtraEditors.TextEdit txtDiaChi;
        private DevExpress.XtraEditors.TextEdit txtNoiSinh;
        private System.Windows.Forms.DateTimePicker birthDay;
        private DevExpress.XtraEditors.TextEdit txtMaLopSv;
        private DevExpress.XtraEditors.TextEdit txtTenSv;
        private DevExpress.XtraEditors.TextEdit txtHoSv;
        private DevExpress.XtraEditors.TextEdit txtMaSV;
        private DevExpress.XtraEditors.CheckEdit pHAICheckEdit;
        private DevExpress.XtraEditors.CheckEdit nghiHoc;
        private System.Windows.Forms.ComboBox cmbKhoa;
        private DS_DIEMTableAdapters.TableAdapterManager tableAdapterManager1;
        private DevExpress.XtraBars.BarButtonItem btnInDSSV;
        private DevExpress.XtraBars.BarButtonItem btnInPDSV;
    }
}