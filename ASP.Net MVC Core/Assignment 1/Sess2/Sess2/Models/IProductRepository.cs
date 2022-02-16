using System.Collections.Generic;

namespace Sess2.Models
{
    public interface IProductRepository
    {
        IEnumerable<Product> GetProducts();
    }
}