using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TC.Services.Models
{
    [Table("Users")]
    public class Users
    {
        public Users()
        {
            Transactions = new HashSet<Transactions>();
            Categories = new HashSet<Categories>();
        }

        [Key]
        public int UserId { get; set; }
        
        [Column(TypeName = "nvarchar")]
        public string Username { get; set; }
        
        [Column(TypeName = "nvarchar")]
        public string Password { get; set; }
        
        [Column(TypeName = "nvarchar")]
        public string Email { get; set; }
        
        [Column(TypeName = "nvarchar")]
        public string FullName { get; set; }

        public virtual ICollection<Transactions> Transactions { get; set; }
        public virtual ICollection<Categories> Categories { get; set; }
    }
}