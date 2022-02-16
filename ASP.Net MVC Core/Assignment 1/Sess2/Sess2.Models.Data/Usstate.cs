using System;
using System.Collections.Generic;

#nullable disable

namespace Sess2.Models.Data
{
    public partial class Usstate
    {
        public short Stateid { get; set; }
        public string Statename { get; set; }
        public string Stateabbr { get; set; }
        public string Stateregion { get; set; }
    }
}
