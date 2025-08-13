using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using TC.Services.Models;

namespace TC.Services.Context
{
    public class TCDbContext : DbContext
    {
        public TCDbContext() : base("name=TCDbContext")
        {
            // Configuration settings can be added here if needed
            // For example, to disable lazy loading:
            // this.Configuration.LazyLoadingEnabled = false;
        }
        public DbSet<Users> Users { get; set; }
        public DbSet<Categories> Categories { get; set; }
        public DbSet<Transactions> Transactions { get; set; }
    }
}