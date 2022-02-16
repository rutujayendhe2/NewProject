using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Sess2.Models;

namespace Sess2.Controllers
{
    public class ProductsController : Controller
    {
        ProductRepository productRepository = new ProductRepository();
        NorthwindProductRepository northwindRepository = new NorthwindProductRepository();
        public IActionResult Index()
        {
            //pass data as a view model
            var products = northwindRepository.GetProducts();
            return View(products);
        }
    }
}
