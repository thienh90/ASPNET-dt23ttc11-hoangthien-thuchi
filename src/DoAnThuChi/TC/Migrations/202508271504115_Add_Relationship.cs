namespace TC.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Add_Relationship : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Categories", "CategoryName", c => c.String(maxLength: 4000));
            AlterColumn("dbo.Categories", "Type", c => c.String(maxLength: 4000));
            AlterColumn("dbo.Transactions", "Description", c => c.String(maxLength: 4000));
            AlterColumn("dbo.Users", "Username", c => c.String(maxLength: 4000));
            AlterColumn("dbo.Users", "Password", c => c.String(maxLength: 4000));
            AlterColumn("dbo.Users", "Email", c => c.String(maxLength: 4000));
            AlterColumn("dbo.Users", "FullName", c => c.String(maxLength: 4000));
            CreateIndex("dbo.Categories", "UserId");
            CreateIndex("dbo.Transactions", "UserId");
            CreateIndex("dbo.Transactions", "CategoryId");
            AddForeignKey("dbo.Transactions", "CategoryId", "dbo.Categories", "CategoryId", cascadeDelete: true);
            AddForeignKey("dbo.Categories", "UserId", "dbo.Users", "UserId", cascadeDelete: false);
            AddForeignKey("dbo.Transactions", "UserId", "dbo.Users", "UserId", cascadeDelete: false);
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Transactions", "UserId", "dbo.Users");
            DropForeignKey("dbo.Categories", "UserId", "dbo.Users");
            DropForeignKey("dbo.Transactions", "CategoryId", "dbo.Categories");
            DropIndex("dbo.Transactions", new[] { "CategoryId" });
            DropIndex("dbo.Transactions", new[] { "UserId" });
            DropIndex("dbo.Categories", new[] { "UserId" });
            AlterColumn("dbo.Users", "FullName", c => c.String());
            AlterColumn("dbo.Users", "Email", c => c.String());
            AlterColumn("dbo.Users", "Password", c => c.String());
            AlterColumn("dbo.Users", "Username", c => c.String());
            AlterColumn("dbo.Transactions", "Description", c => c.String());
            AlterColumn("dbo.Categories", "Type", c => c.String());
            AlterColumn("dbo.Categories", "CategoryName", c => c.String());
        }
    }
}
