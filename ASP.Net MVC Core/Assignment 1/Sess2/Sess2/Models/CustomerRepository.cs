using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sess2.Models
{
    public class CustomerRepository : ICustomerRepository
    {
        List<Customer> allCustomer = new List<Customer>();

        public CustomerRepository()
        {
            allCustomer.AddRange(new Customer[]
                {
                    new Customer{ Customerid ="P001",Companyname="abc",Address="pune"},
                    new Customer{ Customerid ="P002",Companyname="dai",Address="mumbai"},


                });
        }
        public IEnumerable<Customer> GetCustomers()
        {
            return allCustomer;
        }
    }

}
