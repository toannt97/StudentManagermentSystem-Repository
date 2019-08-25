namespace DeTai_QLDSV
{
    partial class frmQuanLy
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmQuanLy));
            this.ribbon = new DevExpress.XtraBars.Ribbon.RibbonControl();
            this.btnLop = new DevExpress.XtraBars.BarButtonItem();
            this.btnMonHoc = new DevExpress.XtraBars.BarButtonItem();
            this.btnDangXuat = new DevExpress.XtraBars.BarButtonItem();
            this.btnDiem = new DevExpress.XtraBars.BarButtonItem();
            this.btnTaoTK = new DevExpress.XtraBars.BarButtonItem();
            this.btnHP = new DevExpress.XtraBars.BarButtonItem();
            this.btnThoat = new DevExpress.XtraBars.BarButtonItem();
            this.ribbonPage1 = new DevExpress.XtraBars.Ribbon.RibbonPage();
            this.ribbonPageGroup1 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.ribbonPageGroup4 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.ribbonPageGroup5 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.ribbonPageGroup7 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.ribbonPageGroup3 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.ribbonPageGroup8 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.sttMaGv = new System.Windows.Forms.ToolStripStatusLabel();
            this.sttHoten = new System.Windows.Forms.ToolStripStatusLabel();
            this.sttNhom = new System.Windows.Forms.ToolStripStatusLabel();
            this.xtraTabbedMdiManager1 = new DevExpress.XtraTabbedMdi.XtraTabbedMdiManager(this.components);
            this.ribbonPageGroup6 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.btnHocPhi = new DevExpress.XtraBars.BarButtonItem();
            ((System.ComponentModel.ISupportInitialize)(this.ribbon)).BeginInit();
            this.statusStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xtraTabbedMdiManager1)).BeginInit();
            this.SuspendLayout();
            // 
            // ribbon
            // 
            this.ribbon.ExpandCollapseItem.Id = 0;
            this.ribbon.Items.AddRange(new DevExpress.XtraBars.BarItem[] {
            this.ribbon.ExpandCollapseItem,
            this.btnLop,
            this.btnMonHoc,
            this.btnDangXuat,
            this.btnDiem,
            this.btnTaoTK,
            this.btnHP,
            this.btnThoat});
            this.ribbon.Location = new System.Drawing.Point(0, 0);
            this.ribbon.Margin = new System.Windows.Forms.Padding(4);
            this.ribbon.MaxItemId = 10;
            this.ribbon.Name = "ribbon";
            this.ribbon.Pages.AddRange(new DevExpress.XtraBars.Ribbon.RibbonPage[] {
            this.ribbonPage1});
            this.ribbon.Size = new System.Drawing.Size(663, 143);
            // 
            // btnLop
            // 
            this.btnLop.Alignment = DevExpress.XtraBars.BarItemLinkAlignment.Left;
            this.btnLop.ButtonStyle = DevExpress.XtraBars.BarButtonStyle.Check;
            this.btnLop.Caption = "Lớp & Sinh viên";
            this.btnLop.Id = 1;
            this.btnLop.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnLop.ImageOptions.Image")));
            this.btnLop.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnLop.ImageOptions.LargeImage")));
            this.btnLop.Name = "btnLop";
            this.btnLop.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnLop_ItemClick);
            // 
            // btnMonHoc
            // 
            this.btnMonHoc.Caption = "Môn học";
            this.btnMonHoc.Id = 2;
            this.btnMonHoc.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnMonHoc.ImageOptions.Image")));
            this.btnMonHoc.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnMonHoc.ImageOptions.LargeImage")));
            this.btnMonHoc.Name = "btnMonHoc";
            this.btnMonHoc.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnMonHoc_ItemClick);
            // 
            // btnDangXuat
            // 
            this.btnDangXuat.Caption = "Đăng xuất";
            this.btnDangXuat.Id = 3;
            this.btnDangXuat.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnDangXuat.ImageOptions.Image")));
            this.btnDangXuat.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnDangXuat.ImageOptions.LargeImage")));
            this.btnDangXuat.Name = "btnDangXuat";
            this.btnDangXuat.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnDangXuat_ItemClick);
            // 
            // btnDiem
            // 
            this.btnDiem.Caption = "Điểm";
            this.btnDiem.Id = 4;
            this.btnDiem.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnDiem.ImageOptions.Image")));
            this.btnDiem.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnDiem.ImageOptions.LargeImage")));
            this.btnDiem.Name = "btnDiem";
            this.btnDiem.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnDiem_ItemClick);
            // 
            // btnTaoTK
            // 
            this.btnTaoTK.Caption = "Tạo tài khoản";
            this.btnTaoTK.Id = 5;
            this.btnTaoTK.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnTaoTK.ImageOptions.Image")));
            this.btnTaoTK.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnTaoTK.ImageOptions.LargeImage")));
            this.btnTaoTK.Name = "btnTaoTK";
            this.btnTaoTK.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnTaoTK_ItemClick);
            // 
            // btnHP
            // 
            this.btnHP.Caption = "Học phí";
            this.btnHP.Id = 7;
            this.btnHP.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnHP.ImageOptions.Image")));
            this.btnHP.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnHP.ImageOptions.LargeImage")));
            this.btnHP.Name = "btnHP";
            this.btnHP.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnHP_ItemClick);
            // 
            // btnThoat
            // 
            this.btnThoat.Caption = "Đăng xuất";
            this.btnThoat.Id = 9;
            this.btnThoat.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnThoat.ImageOptions.Image")));
            this.btnThoat.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnThoat.ImageOptions.LargeImage")));
            this.btnThoat.Name = "btnThoat";
            this.btnThoat.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnDangXuat_ItemClick);
            // 
            // ribbonPage1
            // 
            this.ribbonPage1.Groups.AddRange(new DevExpress.XtraBars.Ribbon.RibbonPageGroup[] {
            this.ribbonPageGroup1,
            this.ribbonPageGroup4,
            this.ribbonPageGroup5,
            this.ribbonPageGroup7,
            this.ribbonPageGroup3,
            this.ribbonPageGroup8});
            this.ribbonPage1.Name = "ribbonPage1";
            this.ribbonPage1.Text = "Danh mục";
            // 
            // ribbonPageGroup1
            // 
            this.ribbonPageGroup1.ItemLinks.Add(this.btnLop);
            this.ribbonPageGroup1.Name = "ribbonPageGroup1";
            // 
            // ribbonPageGroup4
            // 
            this.ribbonPageGroup4.ItemLinks.Add(this.btnMonHoc);
            this.ribbonPageGroup4.Name = "ribbonPageGroup4";
            // 
            // ribbonPageGroup5
            // 
            this.ribbonPageGroup5.ItemLinks.Add(this.btnDiem);
            this.ribbonPageGroup5.Name = "ribbonPageGroup5";
            // 
            // ribbonPageGroup7
            // 
            this.ribbonPageGroup7.ItemLinks.Add(this.btnHP);
            this.ribbonPageGroup7.Name = "ribbonPageGroup7";
            // 
            // ribbonPageGroup3
            // 
            this.ribbonPageGroup3.ItemLinks.Add(this.btnTaoTK);
            this.ribbonPageGroup3.Name = "ribbonPageGroup3";
            // 
            // ribbonPageGroup8
            // 
            this.ribbonPageGroup8.ItemLinks.Add(this.btnThoat);
            this.ribbonPageGroup8.Name = "ribbonPageGroup8";
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.sttMaGv,
            this.sttHoten,
            this.sttNhom});
            this.statusStrip1.Location = new System.Drawing.Point(0, 630);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(663, 22);
            this.statusStrip1.TabIndex = 2;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // sttMaGv
            // 
            this.sttMaGv.Name = "sttMaGv";
            this.sttMaGv.Size = new System.Drawing.Size(45, 17);
            this.sttMaGv.Text = "MaGV: ";
            // 
            // sttHoten
            // 
            this.sttHoten.Name = "sttHoten";
            this.sttHoten.Size = new System.Drawing.Size(49, 17);
            this.sttHoten.Text = "Họ tên: ";
            // 
            // sttNhom
            // 
            this.sttNhom.Name = "sttNhom";
            this.sttNhom.Size = new System.Drawing.Size(83, 17);
            this.sttNhom.Text = "Nhóm quyền: ";
            // 
            // xtraTabbedMdiManager1
            // 
            this.xtraTabbedMdiManager1.MdiParent = this;
            // 
            // ribbonPageGroup6
            // 
            this.ribbonPageGroup6.Name = "ribbonPageGroup6";
            // 
            // btnHocPhi
            // 
            this.btnHocPhi.Caption = "Học phí";
            this.btnHocPhi.Id = 6;
            this.btnHocPhi.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnHocPhi.ImageOptions.Image")));
            this.btnHocPhi.ImageOptions.LargeImage = ((System.Drawing.Image)(resources.GetObject("btnHocPhi.ImageOptions.LargeImage")));
            this.btnHocPhi.Name = "btnHocPhi";
            // 
            // frmQuanLy
            // 
            this.Appearance.Options.UseFont = true;
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 19F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(663, 652);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.ribbon);
            this.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.IsMdiContainer = true;
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "frmQuanLy";
            this.Ribbon = this.ribbon;
            this.Text = "Quản lý điểm sinh viên";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.frmQuanLy_FormClosed);
            this.Load += new System.EventHandler(this.frmQuanLy_Load);
            ((System.ComponentModel.ISupportInitialize)(this.ribbon)).EndInit();
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xtraTabbedMdiManager1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraBars.Ribbon.RibbonControl ribbon;
        private DevExpress.XtraBars.Ribbon.RibbonPage ribbonPage1;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup1;
        private DevExpress.XtraBars.BarButtonItem btnLop;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel sttMaGv;
        private System.Windows.Forms.ToolStripStatusLabel sttHoten;
        private System.Windows.Forms.ToolStripStatusLabel sttNhom;
        private DevExpress.XtraTabbedMdi.XtraTabbedMdiManager xtraTabbedMdiManager1;
        private DevExpress.XtraBars.BarButtonItem btnMonHoc;
        private DevExpress.XtraBars.BarButtonItem btnDangXuat;
        private DevExpress.XtraBars.BarButtonItem btnDiem;
        private DevExpress.XtraBars.BarButtonItem btnTaoTK;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup4;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup5;
        private DevExpress.XtraBars.BarButtonItem btnHP;
        private DevExpress.XtraBars.BarButtonItem btnThoat;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup7;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup3;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup8;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup6;
        private DevExpress.XtraBars.BarButtonItem btnHocPhi;
    }
}