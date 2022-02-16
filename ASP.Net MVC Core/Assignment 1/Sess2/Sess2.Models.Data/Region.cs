using System;
using System.Collections.Generic;

#nullable disable

namespace Sess2.Models.Data
{
    public partial class Region
    {
        public Region()
        {
            Territories = new HashSet<Territory>();
        }

        public short Regionid { get; set; }
        public string Regiondescription { get; set; }

        public virtual ICollection<Territory> Territories { get; set; }
    }
}
