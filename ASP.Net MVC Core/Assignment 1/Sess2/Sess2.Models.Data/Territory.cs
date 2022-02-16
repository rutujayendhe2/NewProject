using System;
using System.Collections.Generic;

#nullable disable

namespace Sess2.Models.Data
{
    public partial class Territory
    {
        public string Territoryid { get; set; }
        public string Territorydescription { get; set; }
        public short Regionid { get; set; }

        public virtual Region Region { get; set; }
    }
}
