using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sess2.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace Sess2.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {

            string heading = "Greetings", message = "Hi from Rutuja";
            ViewData["heading"] = heading;
            ViewData["message"] = message;
            return View();
        }

        public IActionResult Privacy()
        {
            //dynamic x = 10;

            ViewBag.Heading = "Privacy Policy";
            ViewBag.Message = "We take your Privacy very seriously! ";
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
