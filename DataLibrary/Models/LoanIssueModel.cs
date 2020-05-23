using System;
using System.Collections.Generic;
using System.Text;

namespace DataLibrary.Models
{
    public class LoanIssueModel
    {
        public int Loan_ID { get; set; }

        public string Date_out { get; set; }
        public int Amount_paid { get; set; }
        public string Date_returned { get; set; }
        public int Penalty_Charge { get; set; }
        public int Dvd_ID { get; set; }
        public int Member_ID { get; set; }
    }
}
