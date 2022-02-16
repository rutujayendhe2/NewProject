using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Sess2.Models.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;

namespace Sess2.Models
{
    public class NorthwindCustomerRepository // : ICustomerRepository 
    {
        NorthwindDbContext.northwindContext context = new NorthwindDbContext.northwindContext();
        public IEnumerable<Sess2.Models.Data.Customer> GetCustomers()
        {
            return context.Customers.ToList();
        }
    }
}

