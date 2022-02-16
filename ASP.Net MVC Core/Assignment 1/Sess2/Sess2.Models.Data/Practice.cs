using System;
using System.Collections.Generic;

#nullable disable

namespace Sess2.Models.Data
{
    public partial class Practice
    {
        public int Practiceid { get; set; }
        public string Fieldname { get; set; }
        public int Employeeid { get; set; }
        public int? Cost { get; set; }
    }
}
