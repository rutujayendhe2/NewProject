using System;
using System.Collections.Generic;

#nullable disable

namespace Sess2.Models.Data
{
    public partial class Category
    {
        public short Categoryid { get; set; }
        public string Categoryname { get; set; }
        public string Description { get; set; }
        public byte[] Picture { get; set; }
    }
}
