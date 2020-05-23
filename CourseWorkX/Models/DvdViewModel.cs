using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CourseWorkX.Models
{
    public class DvdViewModel
    {
        [Required]
        public  string Title { get; set; }

        [Required]
        public  string Genres { get; set; }

        [Required]
        public  int Stock { get; set; }

        [Range(1900, 3000)]
        [Required]
        public int Year { get; set; }

        [Range(1, 12)]
        [Required]
        public int Month { get; set; }
        
        [Range(1, 31)]
        [Required]
        public int Day { get; set; }

        [Required]
        [Display(Name = "First Name")]
        public string Cast_Fname { get; set; }

        [Required]
        [Display(Name = "Last Name")]
        public string Cast_Lname { get; set; }

        [Required]
        [Display(Name = "Studio Name")]
        public string Studio_Name { get; set; }

        [Required]
        [Display(Name = "Producer Name")]
        public string Producer_Name { get; set; }
    }
}