using System;
using System.Collections.Generic;

#nullable disable

namespace Sess2.Models.Data
{
    public partial class OrderDetailAudit
    {
        public char Operation { get; set; }
        public string Userid { get; set; }
        public DateTime Stamp { get; set; }
        public short Orderid { get; set; }
        public short Productid { get; set; }
        public float Unitprice { get; set; }
        public short Quantity { get; set; }
        public float? Discount { get; set; }
    }
}
