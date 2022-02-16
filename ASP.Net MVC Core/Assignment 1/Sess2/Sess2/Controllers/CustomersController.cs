using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Sess2.Models;


namespace Sess2.Controllers
{
    public class CustomersController : Controller
    {
        CustomerRepository customerRepository = new CustomerRepository();
        NorthwindCustomerRepository northwindRepository = new NorthwindCustomerRepository();

        public IActionResult Class()
        {
            //pass data as a view model
            var customers = northwindRepository.GetCustomers();
            return View(customers);
        }
    }
    
}
