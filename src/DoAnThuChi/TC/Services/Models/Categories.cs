using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TC.Services.Models
{
    [Table("Categories")]
    public class Categories
    {
        public Categories()
        {
            Transactions = new HashSet<Transactions>();
        }

        [Key]
        public int CategoryId { get; set; }

        [Column(TypeName = "nvarchar")]
        public string CategoryName { get; set; }

        public int UserId { get; set; }

        [Column(TypeName = "nvarchar")]
        public string Type { get; set; }

        [ForeignKey("UserId")]
        public virtual Users User { get; set; }
        
        public virtual ICollection<Transactions> Transactions { get; set; }
    }
}