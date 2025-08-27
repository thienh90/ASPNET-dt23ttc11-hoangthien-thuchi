using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TC.Services.Models
{
    [Table("Transactions")]
    public class Transactions
    {
        [Key]
        public int TransactionId { get; set; }

        public int UserId { get; set; }

        public int CategoryId { get; set; }

        public decimal Amount { get; set; }

        [Column(TypeName = "nvarchar")]
        public string Description { get; set; }

        public DateTime TransactionDate { get; set; }

        [ForeignKey("UserId")]
        public virtual Users User { get; set; }

        [ForeignKey("CategoryId")]
        public virtual Categories Category { get; set; }
    }
}