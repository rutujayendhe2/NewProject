#pragma checksum "D:\Dotnet\Asp.net MVC core\day1\Sess2\Sess2\Views\Customers\Class.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "f5ddd8fed8cbfb5b161ee85209910ca535047c06"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Customers_Class), @"mvc.1.0.view", @"/Views/Customers/Class.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "D:\Dotnet\Asp.net MVC core\day1\Sess2\Sess2\Views\_ViewImports.cshtml"
using Sess2;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "D:\Dotnet\Asp.net MVC core\day1\Sess2\Sess2\Views\_ViewImports.cshtml"
using Sess2.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"f5ddd8fed8cbfb5b161ee85209910ca535047c06", @"/Views/Customers/Class.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"7faac253c81f5b64a011d93f568b936e9dfb882c", @"/Views/_ViewImports.cshtml")]
    public class Views_Customers_Class : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<List<Sess2.Models.Data.Customer>>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n<h2>Customer</h2>\r\n<hr />\r\n\r\n<div>\r\n    <h4 class=\"alert-heading\">Customer List</h4>\r\n    <ul class=\"list list-unstyled\">\r\n");
#nullable restore
#line 10 "D:\Dotnet\Asp.net MVC core\day1\Sess2\Sess2\Views\Customers\Class.cshtml"
         foreach (var customer in Model)
        {

#line default
#line hidden
#nullable disable
            WriteLiteral("            <li>\r\n                ");
#nullable restore
#line 13 "D:\Dotnet\Asp.net MVC core\day1\Sess2\Sess2\Views\Customers\Class.cshtml"
           Write(customer.Customerid);

#line default
#line hidden
#nullable disable
            WriteLiteral(" : ");
#nullable restore
#line 13 "D:\Dotnet\Asp.net MVC core\day1\Sess2\Sess2\Views\Customers\Class.cshtml"
                                  Write(customer.Companyname);

#line default
#line hidden
#nullable disable
            WriteLiteral(" And ");
#nullable restore
#line 13 "D:\Dotnet\Asp.net MVC core\day1\Sess2\Sess2\Views\Customers\Class.cshtml"
                                                            Write(customer.Address);

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </li>\r\n");
#nullable restore
#line 15 "D:\Dotnet\Asp.net MVC core\day1\Sess2\Sess2\Views\Customers\Class.cshtml"
        }

#line default
#line hidden
#nullable disable
            WriteLiteral("    </ul>\r\n\r\n\r\n</div>");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<List<Sess2.Models.Data.Customer>> Html { get; private set; }
    }
}
#pragma warning restore 1591