using System;
using System.Collections.Generic;

#nullable disable

namespace Sess2.Models.Data
{
    public partial class SalaryEmployee
    {
        public string Name { get; set; }
        public int[] PayByQuarter { get; set; }
        public string[] Schedule { get; set; }
    }
}
