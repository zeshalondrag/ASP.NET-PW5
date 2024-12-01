using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace SORAPC.Models;

public partial class PcstoreContext : DbContext
{
    public PcstoreContext()
    {
    }

    public PcstoreContext(DbContextOptions<PcstoreContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Cart> Carts { get; set; }

    public virtual DbSet<Catalog> Catalogs { get; set; }

    public virtual DbSet<Category> Categorys { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<PosOrder> PosOrders { get; set; }

    public virtual DbSet<Statuss> Statusses { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=ZESHALONDRAG\\SQLEXPRESS;Initial Catalog=PCstore;Integrated Security=True;Trust Server Certificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Cart>(entity =>
        {
            entity.HasKey(e => e.IdCart).HasName("PK__Cart__72140ECF5789B510");

            entity.ToTable("Cart");

            entity.Property(e => e.IdCart).HasColumnName("ID_Cart");
            entity.Property(e => e.CatalogId).HasColumnName("Catalog_ID");
            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.UsersId).HasColumnName("Users_ID");

            entity.HasOne(d => d.Catalog).WithMany(p => p.Carts)
                .HasForeignKey(d => d.CatalogId)
                .HasConstraintName("FK__Cart__Catalog_ID__5BE2A6F2");

            entity.HasOne(d => d.Users).WithMany(p => p.Carts)
                .HasForeignKey(d => d.UsersId)
                .HasConstraintName("FK__Cart__Users_ID__5CD6CB2B");
        });

        modelBuilder.Entity<Catalog>(entity =>
        {
            entity.HasKey(e => e.IdCatalog).HasName("PK__Catalogs__38D620C502FB6402");

            entity.Property(e => e.IdCatalog).HasColumnName("ID_Catalog");
            entity.Property(e => e.CategoryId).HasColumnName("Category_ID");
            entity.Property(e => e.Descriptions).HasColumnType("text");
            entity.Property(e => e.ImageUrl)
                .HasColumnType("text")
                .HasColumnName("Image_url");
            entity.Property(e => e.Names)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.Category).WithMany(p => p.Catalogs)
                .HasForeignKey(d => d.CategoryId)
                .HasConstraintName("FK__Catalogs__Catego__4F7CD00D");
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.IdCategory).HasName("PK__Category__6DB3A68AC7A79F03");

            entity.Property(e => e.IdCategory).HasColumnName("ID_Category");
            entity.Property(e => e.Names)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.IdOrder).HasName("PK__Orders__EC9FA955802B0F47");

            entity.Property(e => e.IdOrder).HasColumnName("ID_Order");
            entity.Property(e => e.Dates)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.StatusId).HasColumnName("Status_ID");
            entity.Property(e => e.TotalSum).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.UsersId).HasColumnName("Users_ID");

            entity.HasOne(d => d.Status).WithMany(p => p.Orders)
                .HasForeignKey(d => d.StatusId)
                .HasConstraintName("FK__Orders__Status_I__5535A963");

            entity.HasOne(d => d.Users).WithMany(p => p.Orders)
                .HasForeignKey(d => d.UsersId)
                .HasConstraintName("FK__Orders__Users_ID__5441852A");
        });

        modelBuilder.Entity<PosOrder>(entity =>
        {
            entity.HasKey(e => e.IdPosOrder).HasName("PK__PosOrder__D77BC1CB9A1CE2EA");

            entity.Property(e => e.IdPosOrder).HasColumnName("ID_PosOrder");
            entity.Property(e => e.CatalogsId).HasColumnName("Catalogs_ID");
            entity.Property(e => e.OrdersId).HasColumnName("Orders_ID");
            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.Catalogs).WithMany(p => p.PosOrders)
                .HasForeignKey(d => d.CatalogsId)
                .HasConstraintName("FK__PosOrders__Catal__59063A47");

            entity.HasOne(d => d.Orders).WithMany(p => p.PosOrders)
                .HasForeignKey(d => d.OrdersId)
                .HasConstraintName("FK__PosOrders__Order__5812160E");
        });

        modelBuilder.Entity<Statuss>(entity =>
        {
            entity.HasKey(e => e.IdStatus).HasName("PK__Statuss__5AC2A734511FEB83");

            entity.ToTable("Statuss");

            entity.Property(e => e.IdStatus).HasColumnName("ID_Status");
            entity.Property(e => e.StatusName)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.IdUser).HasName("PK__Users__ED4DE442C47A8F8A");

            entity.HasIndex(e => e.Phone, "UQ__Users__5C7E359E689C220E").IsUnique();

            entity.HasIndex(e => e.Logins, "UQ__Users__D00D063204EBFB45").IsUnique();

            entity.Property(e => e.IdUser).HasColumnName("ID_User");
            entity.Property(e => e.Logins)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Passwords)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Phone)
                .HasMaxLength(12)
                .IsUnicode(false);
            entity.Property(e => e.UserMiddleName)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.UserName)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.UserSurname)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
