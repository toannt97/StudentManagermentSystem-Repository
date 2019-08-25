namespace DeTai_QLDSV
{
    partial class frmTaoTK
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
            System.Windows.Forms.Label mAGVLabel;
            System.Windows.Forms.Label hOLabel;
            System.Windows.Forms.Label tENLabel;
            System.Windows.Forms.Label mAKHLabel;
            System.Windows.Forms.Label mAGVLabel1;
            System.Windows.Forms.Label nAMELabel;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmTaoTK));
            this.cmbNhomQuyen = new System.Windows.Forms.ComboBox();
            this.vDSNHOMBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.dS_DIEM = new DeTai_QLDSV.DS_DIEM();
            this.v_DSNHOMTableAdapter = new DeTai_QLDSV.DS_DIEMTableAdapters.V_DSNHOMTableAdapter();
            this.barManager1 = new DevExpress.XtraBars.BarManager(this.components);
            this.bar1 = new DevExpress.XtraBars.Bar();
            this.btnCapQuyen = new DevExpress.XtraBars.BarButtonItem();
            this.btnThuHoi = new DevExpress.XtraBars.BarButtonItem();
            this.btnPhucHoi = new DevExpress.XtraBars.BarButtonItem();
            this.btnTaiLai = new DevExpress.XtraBars.BarButtonItem();
            this.btnThoat = new DevExpress.XtraBars.BarButtonItem();
            this.barDockControlTop = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlBottom = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlLeft = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlRight = new DevExpress.XtraBars.BarDockControl();
            this.bdsGiangVien = new System.Windows.Forms.BindingSource(this.components);
            this.gIANGVIENTableAdapter = new DeTai_QLDSV.DS_DIEMTableAdapters.GIANGVIENTableAdapter();
            this.tableAdapterManager = new DeTai_QLDSV.DS_DIEMTableAdapters.TableAdapterManager();
            this.panel1 = new System.Windows.Forms.Panel();
            this.cmbKhoa = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.gcGiangVien = new DevExpress.XtraGrid.GridControl();
            this.gvGiangVien = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.colMAGV = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colHO = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colTEN = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colMAKH = new DevExpress.XtraGrid.Columns.GridColumn();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.lblNhomQuyen = new System.Windows.Forms.Label();
            this.sp_InNhomQuyenBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.txtMaKhoa = new DevExpress.XtraEditors.TextEdit();
            this.txtTen = new DevExpress.XtraEditors.TextEdit();
            this.txtHo = new DevExpress.XtraEditors.TextEdit();
            this.txtMaGV = new DevExpress.XtraEditors.TextEdit();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.lblMaGV = new System.Windows.Forms.Label();
            this.btnHoanTat = new System.Windows.Forms.Button();
            this.txtXacNhan = new System.Windows.Forms.TextBox();
            this.txtMatKhau = new System.Windows.Forms.TextBox();
            this.txtTaiKhoan = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.sp_InNhomQuyenTableAdapter = new DeTai_QLDSV.DS_DIEMTableAdapters.sp_InNhomQuyenTableAdapter();
            mAGVLabel = new System.Windows.Forms.Label();
            hOLabel = new System.Windows.Forms.Label();
            tENLabel = new System.Windows.Forms.Label();
            mAKHLabel = new System.Windows.Forms.Label();
            mAGVLabel1 = new System.Windows.Forms.Label();
            nAMELabel = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.vDSNHOMBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dS_DIEM)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bdsGiangVien)).BeginInit();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gcGiangVien)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvGiangVien)).BeginInit();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.sp_InNhomQuyenBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMaKhoa.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtTen.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtHo.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMaGV.Properties)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // mAGVLabel
            // 
            mAGVLabel.AutoSize = true;
            mAGVLabel.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            mAGVLabel.Location = new System.Drawing.Point(37, 14);
            mAGVLabel.Name = "mAGVLabel";
            mAGVLabel.Size = new System.Drawing.Size(66, 21);
            mAGVLabel.TabIndex = 1;
            mAGVLabel.Text = "Mã GV";
            // 
            // hOLabel
            // 
            hOLabel.AutoSize = true;
            hOLabel.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            hOLabel.Location = new System.Drawing.Point(37, 73);
            hOLabel.Name = "hOLabel";
            hOLabel.Size = new System.Drawing.Size(33, 21);
            hOLabel.TabIndex = 3;
            hOLabel.Text = "Họ";
            // 
            // tENLabel
            // 
            tENLabel.AutoSize = true;
            tENLabel.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            tENLabel.Location = new System.Drawing.Point(37, 135);
            tENLabel.Name = "tENLabel";
            tENLabel.Size = new System.Drawing.Size(39, 21);
            tENLabel.TabIndex = 5;
            tENLabel.Text = "Tên";
            // 
            // mAKHLabel
            // 
            mAKHLabel.AutoSize = true;
            mAKHLabel.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            mAKHLabel.Location = new System.Drawing.Point(37, 200);
            mAKHLabel.Name = "mAKHLabel";
            mAKHLabel.Size = new System.Drawing.Size(75, 21);
            mAKHLabel.TabIndex = 7;
            mAKHLabel.Text = "Mã khoa";
            // 
            // mAGVLabel1
            // 
            mAGVLabel1.AutoSize = true;
            mAGVLabel1.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            mAGVLabel1.Location = new System.Drawing.Point(76, 250);
            mAGVLabel1.Name = "mAGVLabel1";
            mAGVLabel1.Size = new System.Drawing.Size(66, 21);
            mAGVLabel1.TabIndex = 9;
            mAGVLabel1.Text = "Mã GV";
            // 
            // nAMELabel
            // 
            nAMELabel.AutoSize = true;
            nAMELabel.Location = new System.Drawing.Point(37, 286);
            nAMELabel.Name = "nAMELabel";
            nAMELabel.Size = new System.Drawing.Size(106, 21);
            nAMELabel.TabIndex = 12;
            nAMELabel.Text = "Nhóm quyền";
            // 
            // cmbNhomQuyen
            // 
            this.cmbNhomQuyen.DataSource = this.vDSNHOMBindingSource;
            this.cmbNhomQuyen.DisplayMember = "name";
            this.cmbNhomQuyen.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbNhomQuyen.FormattingEnabled = true;
            this.cmbNhomQuyen.Location = new System.Drawing.Point(260, 312);
            this.cmbNhomQuyen.Name = "cmbNhomQuyen";
            this.cmbNhomQuyen.Size = new System.Drawing.Size(184, 29);
            this.cmbNhomQuyen.TabIndex = 0;
            this.cmbNhomQuyen.ValueMember = "name";
            // 
            // vDSNHOMBindingSource
            // 
            this.vDSNHOMBindingSource.DataMember = "V_DSNHOM";
            this.vDSNHOMBindingSource.DataSource = this.dS_DIEM;
            // 
            // dS_DIEM
            // 
            this.dS_DIEM.DataSetName = "DS_DIEM";
            this.dS_DIEM.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // v_DSNHOMTableAdapter
            // 
            this.v_DSNHOMTableAdapter.ClearBeforeFill = true;
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
            this.btnPhucHoi,
            this.btnThoat,
            this.btnTaiLai,
            this.btnCapQuyen,
            this.btnThuHoi});
            this.barManager1.MaxItemId = 10;
            // 
            // bar1
            // 
            this.bar1.BarAppearance.Hovered.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.bar1.BarAppearance.Hovered.Options.UseBackColor = true;
            this.bar1.BarAppearance.Normal.Options.UseTextOptions = true;
            this.bar1.BarAppearance.Normal.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.bar1.BarName = "Tools";
            this.bar1.DockCol = 0;
            this.bar1.DockRow = 0;
            this.bar1.DockStyle = DevExpress.XtraBars.BarDockStyle.Top;
            this.bar1.LinksPersistInfo.AddRange(new DevExpress.XtraBars.LinkPersistInfo[] {
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnCapQuyen, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnThuHoi, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnPhucHoi, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnTaiLai, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph),
            new DevExpress.XtraBars.LinkPersistInfo(DevExpress.XtraBars.BarLinkUserDefines.PaintStyle, this.btnThoat, DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph)});
            this.bar1.Offset = 1;
            this.bar1.OptionsBar.AllowQuickCustomization = false;
            this.bar1.OptionsBar.DrawDragBorder = false;
            this.bar1.Text = "Tools";
            // 
            // btnCapQuyen
            // 
            this.btnCapQuyen.Caption = "Cấp quyền";
            this.btnCapQuyen.Id = 8;
            this.btnCapQuyen.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnCapQuyen.ImageOptions.Image")));
            this.btnCapQuyen.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnCapQuyen.ImageOptions.LargeImage")));
            this.btnCapQuyen.Name = "btnCapQuyen";
            this.btnCapQuyen.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnCapQuyen_ItemClick);
            // 
            // btnThuHoi
            // 
            this.btnThuHoi.Caption = "Thu hồi quyền";
            this.btnThuHoi.Id = 9;
            this.btnThuHoi.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnThuHoi.ImageOptions.Image")));
            this.btnThuHoi.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnThuHoi.ImageOptions.LargeImage")));
            this.btnThuHoi.Name = "btnThuHoi";
            this.btnThuHoi.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnThuHoi_ItemClick);
            // 
            // btnPhucHoi
            // 
            this.btnPhucHoi.Caption = "Phục hồi";
            this.btnPhucHoi.Id = 4;
            this.btnPhucHoi.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnPhucHoi.ImageOptions.Image")));
            this.btnPhucHoi.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnPhucHoi.ImageOptions.LargeImage")));
            this.btnPhucHoi.Name = "btnPhucHoi";
            this.btnPhucHoi.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnPhucHoi_ItemClick);
            // 
            // btnTaiLai
            // 
            this.btnTaiLai.Caption = "Tải lại";
            this.btnTaiLai.Id = 7;
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
            this.barDockControlTop.CausesValidation = false;
            this.barDockControlTop.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControlTop.Location = new System.Drawing.Point(0, 0);
            this.barDockControlTop.Manager = this.barManager1;
            this.barDockControlTop.Size = new System.Drawing.Size(1333, 31);
            // 
            // barDockControlBottom
            // 
            this.barDockControlBottom.CausesValidation = false;
            this.barDockControlBottom.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControlBottom.Location = new System.Drawing.Point(0, 735);
            this.barDockControlBottom.Manager = this.barManager1;
            this.barDockControlBottom.Size = new System.Drawing.Size(1333, 0);
            // 
            // barDockControlLeft
            // 
            this.barDockControlLeft.CausesValidation = false;
            this.barDockControlLeft.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControlLeft.Location = new System.Drawing.Point(0, 31);
            this.barDockControlLeft.Manager = this.barManager1;
            this.barDockControlLeft.Size = new System.Drawing.Size(0, 704);
            // 
            // barDockControlRight
            // 
            this.barDockControlRight.CausesValidation = false;
            this.barDockControlRight.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControlRight.Location = new System.Drawing.Point(1333, 31);
            this.barDockControlRight.Manager = this.barManager1;
            this.barDockControlRight.Size = new System.Drawing.Size(0, 704);
            // 
            // bdsGiangVien
            // 
            this.bdsGiangVien.DataMember = "GIANGVIEN";
            this.bdsGiangVien.DataSource = this.dS_DIEM;
            // 
            // gIANGVIENTableAdapter
            // 
            this.gIANGVIENTableAdapter.ClearBeforeFill = true;
            // 
            // tableAdapterManager
            // 
            this.tableAdapterManager.BackupDataSetBeforeUpdate = false;
            this.tableAdapterManager.DIEMTableAdapter = null;
            this.tableAdapterManager.GIANGVIENTableAdapter = this.gIANGVIENTableAdapter;
            this.tableAdapterManager.KHOATableAdapter = null;
            this.tableAdapterManager.LOPTableAdapter = null;
            this.tableAdapterManager.MONHOCTableAdapter = null;
            this.tableAdapterManager.SINHVIENTableAdapter = null;
            this.tableAdapterManager.UpdateOrder = DeTai_QLDSV.DS_DIEMTableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.cmbKhoa);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 31);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(1333, 70);
            this.panel1.TabIndex = 6;
            // 
            // cmbKhoa
            // 
            this.cmbKhoa.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbKhoa.FormattingEnabled = true;
            this.cmbKhoa.Location = new System.Drawing.Point(147, 18);
            this.cmbKhoa.Name = "cmbKhoa";
            this.cmbKhoa.Size = new System.Drawing.Size(349, 29);
            this.cmbKhoa.TabIndex = 1;
            this.cmbKhoa.SelectedIndexChanged += new System.EventHandler(this.cmbKhoa_SelectedIndexChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(56, 21);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(63, 21);
            this.label1.TabIndex = 0;
            this.label1.Text = "KHOA";
            // 
            // gcGiangVien
            // 
            this.gcGiangVien.DataSource = this.bdsGiangVien;
            this.gcGiangVien.Dock = System.Windows.Forms.DockStyle.Top;
            this.gcGiangVien.Location = new System.Drawing.Point(0, 101);
            this.gcGiangVien.MainView = this.gvGiangVien;
            this.gcGiangVien.MenuManager = this.barManager1;
            this.gcGiangVien.Name = "gcGiangVien";
            this.gcGiangVien.Size = new System.Drawing.Size(1333, 182);
            this.gcGiangVien.TabIndex = 6;
            this.gcGiangVien.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gvGiangVien});
            // 
            // gvGiangVien
            // 
            this.gvGiangVien.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.colMAGV,
            this.colHO,
            this.colTEN,
            this.colMAKH});
            this.gvGiangVien.GridControl = this.gcGiangVien;
            this.gvGiangVien.Name = "gvGiangVien";
            this.gvGiangVien.OptionsCustomization.AllowColumnMoving = false;
            this.gvGiangVien.OptionsView.ShowGroupPanel = false;
            this.gvGiangVien.RowClick += new DevExpress.XtraGrid.Views.Grid.RowClickEventHandler(this.gvGiangVien_RowClick);
            this.gvGiangVien.RowCellClick += new DevExpress.XtraGrid.Views.Grid.RowCellClickEventHandler(this.gvGiangVien_RowClick);
            this.gvGiangVien.FocusedRowChanged += new DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventHandler(this.gvGiangVien_FocusedRowChanged);
            this.gvGiangVien.FocusedRowObjectChanged += new DevExpress.XtraGrid.Views.Base.FocusedRowObjectChangedEventHandler(this.gvGiangVien_FocusedRowObjectChanged);
            // 
            // colMAGV
            // 
            this.colMAGV.Caption = "Mã GV";
            this.colMAGV.FieldName = "MAGV";
            this.colMAGV.Name = "colMAGV";
            this.colMAGV.OptionsColumn.AllowEdit = false;
            this.colMAGV.Visible = true;
            this.colMAGV.VisibleIndex = 0;
            // 
            // colHO
            // 
            this.colHO.Caption = "Họ";
            this.colHO.FieldName = "HO";
            this.colHO.Name = "colHO";
            this.colHO.OptionsColumn.AllowEdit = false;
            this.colHO.Visible = true;
            this.colHO.VisibleIndex = 1;
            // 
            // colTEN
            // 
            this.colTEN.Caption = "Tên";
            this.colTEN.FieldName = "TEN";
            this.colTEN.Name = "colTEN";
            this.colTEN.OptionsColumn.AllowEdit = false;
            this.colTEN.Visible = true;
            this.colTEN.VisibleIndex = 2;
            // 
            // colMAKH
            // 
            this.colMAKH.Caption = "Mã khoa";
            this.colMAKH.FieldName = "MAKH";
            this.colMAKH.Name = "colMAKH";
            this.colMAKH.OptionsColumn.AllowEdit = false;
            this.colMAKH.Visible = true;
            this.colMAKH.VisibleIndex = 3;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(nAMELabel);
            this.groupBox1.Controls.Add(this.lblNhomQuyen);
            this.groupBox1.Controls.Add(mAKHLabel);
            this.groupBox1.Controls.Add(this.txtMaKhoa);
            this.groupBox1.Controls.Add(tENLabel);
            this.groupBox1.Controls.Add(this.txtTen);
            this.groupBox1.Controls.Add(hOLabel);
            this.groupBox1.Controls.Add(this.txtHo);
            this.groupBox1.Controls.Add(mAGVLabel);
            this.groupBox1.Controls.Add(this.txtMaGV);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Left;
            this.groupBox1.Location = new System.Drawing.Point(0, 283);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(526, 452);
            this.groupBox1.TabIndex = 7;
            this.groupBox1.TabStop = false;
            // 
            // lblNhomQuyen
            // 
            this.lblNhomQuyen.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.sp_InNhomQuyenBindingSource, "NAME", true));
            this.lblNhomQuyen.Location = new System.Drawing.Point(174, 286);
            this.lblNhomQuyen.Name = "lblNhomQuyen";
            this.lblNhomQuyen.Size = new System.Drawing.Size(100, 23);
            this.lblNhomQuyen.TabIndex = 13;
            this.lblNhomQuyen.Text = "       ";
            // 
            // sp_InNhomQuyenBindingSource
            // 
            this.sp_InNhomQuyenBindingSource.DataMember = "sp_InNhomQuyen";
            this.sp_InNhomQuyenBindingSource.DataSource = this.dS_DIEM;
            // 
            // txtMaKhoa
            // 
            this.txtMaKhoa.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.bdsGiangVien, "MAKH", true));
            this.txtMaKhoa.Enabled = false;
            this.txtMaKhoa.Location = new System.Drawing.Point(178, 202);
            this.txtMaKhoa.MenuManager = this.barManager1;
            this.txtMaKhoa.Name = "txtMaKhoa";
            this.txtMaKhoa.Properties.Appearance.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtMaKhoa.Properties.Appearance.Options.UseFont = true;
            this.txtMaKhoa.Size = new System.Drawing.Size(164, 28);
            this.txtMaKhoa.TabIndex = 8;
            // 
            // txtTen
            // 
            this.txtTen.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.bdsGiangVien, "TEN", true));
            this.txtTen.Location = new System.Drawing.Point(178, 137);
            this.txtTen.MenuManager = this.barManager1;
            this.txtTen.Name = "txtTen";
            this.txtTen.Properties.Appearance.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtTen.Properties.Appearance.Options.UseFont = true;
            this.txtTen.Size = new System.Drawing.Size(298, 28);
            this.txtTen.TabIndex = 6;
            // 
            // txtHo
            // 
            this.txtHo.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.bdsGiangVien, "HO", true));
            this.txtHo.Location = new System.Drawing.Point(178, 75);
            this.txtHo.MenuManager = this.barManager1;
            this.txtHo.Name = "txtHo";
            this.txtHo.Properties.Appearance.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtHo.Properties.Appearance.Options.UseFont = true;
            this.txtHo.Size = new System.Drawing.Size(298, 28);
            this.txtHo.TabIndex = 4;
            // 
            // txtMaGV
            // 
            this.txtMaGV.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.bdsGiangVien, "MAGV", true));
            this.txtMaGV.Location = new System.Drawing.Point(178, 16);
            this.txtMaGV.MenuManager = this.barManager1;
            this.txtMaGV.Name = "txtMaGV";
            this.txtMaGV.Properties.Appearance.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtMaGV.Properties.Appearance.Options.UseFont = true;
            this.txtMaGV.Size = new System.Drawing.Size(92, 28);
            this.txtMaGV.TabIndex = 2;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.lblMaGV);
            this.groupBox2.Controls.Add(mAGVLabel1);
            this.groupBox2.Controls.Add(this.btnHoanTat);
            this.groupBox2.Controls.Add(this.txtXacNhan);
            this.groupBox2.Controls.Add(this.txtMatKhau);
            this.groupBox2.Controls.Add(this.txtTaiKhoan);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.label3);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Controls.Add(this.cmbNhomQuyen);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox2.Location = new System.Drawing.Point(526, 283);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(807, 452);
            this.groupBox2.TabIndex = 8;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Tạo tài khoản đăng nhập";
            // 
            // lblMaGV
            // 
            this.lblMaGV.AutoSize = true;
            this.lblMaGV.Location = new System.Drawing.Point(256, 250);
            this.lblMaGV.Name = "lblMaGV";
            this.lblMaGV.Size = new System.Drawing.Size(0, 21);
            this.lblMaGV.TabIndex = 10;
            // 
            // btnHoanTat
            // 
            this.btnHoanTat.Location = new System.Drawing.Point(675, 130);
            this.btnHoanTat.Name = "btnHoanTat";
            this.btnHoanTat.Size = new System.Drawing.Size(104, 31);
            this.btnHoanTat.TabIndex = 7;
            this.btnHoanTat.Text = "Hoàn tất";
            this.btnHoanTat.UseVisualStyleBackColor = true;
            this.btnHoanTat.Click += new System.EventHandler(this.btnHoanTat_Click);
            // 
            // txtXacNhan
            // 
            this.txtXacNhan.Location = new System.Drawing.Point(260, 179);
            this.txtXacNhan.MaxLength = 15;
            this.txtXacNhan.Name = "txtXacNhan";
            this.txtXacNhan.PasswordChar = '*';
            this.txtXacNhan.Size = new System.Drawing.Size(302, 29);
            this.txtXacNhan.TabIndex = 2;
            // 
            // txtMatKhau
            // 
            this.txtMatKhau.Location = new System.Drawing.Point(260, 108);
            this.txtMatKhau.MaxLength = 15;
            this.txtMatKhau.Name = "txtMatKhau";
            this.txtMatKhau.PasswordChar = '*';
            this.txtMatKhau.Size = new System.Drawing.Size(302, 29);
            this.txtMatKhau.TabIndex = 2;
            // 
            // txtTaiKhoan
            // 
            this.txtTaiKhoan.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.txtTaiKhoan.Location = new System.Drawing.Point(260, 38);
            this.txtTaiKhoan.MaxLength = 15;
            this.txtTaiKhoan.Name = "txtTaiKhoan";
            this.txtTaiKhoan.Size = new System.Drawing.Size(302, 29);
            this.txtTaiKhoan.TabIndex = 2;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(76, 315);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(106, 21);
            this.label5.TabIndex = 1;
            this.label5.Text = "Nhóm quyền";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(76, 182);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(152, 21);
            this.label4.TabIndex = 1;
            this.label4.Text = "Xác nhận mật khẩu";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(76, 111);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(79, 21);
            this.label3.TabIndex = 1;
            this.label3.Text = "Mật khẩu";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(76, 41);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(84, 21);
            this.label2.TabIndex = 1;
            this.label2.Text = "Tài khoản";
            // 
            // sp_InNhomQuyenTableAdapter
            // 
            this.sp_InNhomQuyenTableAdapter.ClearBeforeFill = true;
            // 
            // frmTaoTK
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 21F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1333, 735);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.gcGiangVien);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "frmTaoTK";
            this.Text = "Tài khoản";
            this.Load += new System.EventHandler(this.frmTaoTK_Load);
            ((System.ComponentModel.ISupportInitialize)(this.vDSNHOMBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dS_DIEM)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bdsGiangVien)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gcGiangVien)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvGiangVien)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.sp_InNhomQuyenBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMaKhoa.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtTen.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtHo.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMaGV.Properties)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox cmbNhomQuyen;
        private DS_DIEM dS_DIEM;
        private System.Windows.Forms.BindingSource vDSNHOMBindingSource;
        private DS_DIEMTableAdapters.V_DSNHOMTableAdapter v_DSNHOMTableAdapter;
        private DevExpress.XtraBars.BarManager barManager1;
        private DevExpress.XtraBars.Bar bar1;
        private DevExpress.XtraBars.BarButtonItem btnPhucHoi;
        private DevExpress.XtraBars.BarButtonItem btnTaiLai;
        private DevExpress.XtraBars.BarButtonItem btnThoat;
        private DevExpress.XtraBars.BarDockControl barDockControlTop;
        private DevExpress.XtraBars.BarDockControl barDockControlBottom;
        private DevExpress.XtraBars.BarDockControl barDockControlLeft;
        private DevExpress.XtraBars.BarDockControl barDockControlRight;
        private System.Windows.Forms.BindingSource bdsGiangVien;
        private DS_DIEMTableAdapters.GIANGVIENTableAdapter gIANGVIENTableAdapter;
        private DS_DIEMTableAdapters.TableAdapterManager tableAdapterManager;
        private DevExpress.XtraGrid.GridControl gcGiangVien;
        private DevExpress.XtraGrid.Views.Grid.GridView gvGiangVien;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.ComboBox cmbKhoa;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private DevExpress.XtraGrid.Columns.GridColumn colMAGV;
        private DevExpress.XtraGrid.Columns.GridColumn colHO;
        private DevExpress.XtraGrid.Columns.GridColumn colTEN;
        private DevExpress.XtraGrid.Columns.GridColumn colMAKH;
        private DevExpress.XtraEditors.TextEdit txtMaKhoa;
        private DevExpress.XtraEditors.TextEdit txtTen;
        private DevExpress.XtraEditors.TextEdit txtHo;
        private DevExpress.XtraEditors.TextEdit txtMaGV;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox txtXacNhan;
        private System.Windows.Forms.TextBox txtMatKhau;
        private System.Windows.Forms.TextBox txtTaiKhoan;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnHoanTat;
        private System.Windows.Forms.Label lblMaGV;
        private DevExpress.XtraBars.BarButtonItem btnCapQuyen;
        private DevExpress.XtraBars.BarButtonItem btnThuHoi;
        private System.Windows.Forms.BindingSource sp_InNhomQuyenBindingSource;
        private DS_DIEMTableAdapters.sp_InNhomQuyenTableAdapter sp_InNhomQuyenTableAdapter;
        private System.Windows.Forms.Label lblNhomQuyen;
    }
}