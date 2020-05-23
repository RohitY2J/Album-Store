using System;
using System.Collections.Generic;
using System.Text;

namespace DataLibrary.Models
{
    public class LoanModel
    {
        public int Loan_ID { get; set; }
        public string Date_out { get; set; }
        public int Amount_paid { get; set; }
        public string Date_returned { get; set; }
        public int Penalty_Charge { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int User_ID { get; set; }
        public string Title { get; set; }
    }
}
