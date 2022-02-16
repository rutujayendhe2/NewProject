using System;
using System.Collections.Generic;

#nullable disable

namespace Sess2.Models.Data
{
    public partial class OrderDetail
    {
        public int Orderid { get; set; }
        public short Productid { get; set; }
        public float Unitprice { get; set; }
        public short Quantity { get; set; }
        public float Discount { get; set; }
    }
}
