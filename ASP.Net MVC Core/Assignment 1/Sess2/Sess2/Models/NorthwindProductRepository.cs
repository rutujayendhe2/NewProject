using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Sess2.Models.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;


namespace Sess2.Models
{
    public class NorthwindProductRepository //: IProductRepository
    {
        NorthwindDbContext.northwindContext context = new NorthwindDbContext.northwindContext();
        public IEnumerable<Sess2.Models.Data.Product> GetProducts()
        {
            return context.Products.ToList();
        }
    }
}
