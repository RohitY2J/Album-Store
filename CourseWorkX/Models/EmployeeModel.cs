using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CourseWorkX.Models
{
    public class EmployeeModel
    {

        [Required(ErrorMessage ="You need to enter Id")]
        [Display(Name = "Enter your Id")]
        [Range(100, 999, ErrorMessage = "You need to enter a valid Id")]
        public int EmployeeId { get; set; }

        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }
        
        [DataType(DataType.EmailAddress, ErrorMessage = "It is not an email")]
        public string EmailAddress { get; set; }

        [Display(Name = "Password")]
        [Required(ErrorMessage = "You must have a password")]
        [DataType(DataType.Password)]
        [StringLength(100, MinimumLength = 10, ErrorMessage ="Password is not long enough")]
        public string Password { get; set; }

        [Display(Name = "Confirm Password")]
        [Required(ErrorMessage = "You must have a password")]
        [DataType(DataType.Password)]
        [StringLength(100, MinimumLength = 10, ErrorMessage = "Password is not long enough")]
        [Compare("Password", ErrorMessage = "Password Doesnot match")]
        public string ConfirmPassword { get; set; }
    }
}