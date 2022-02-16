using System;
using System.Collections.Generic;

#nullable disable

namespace Sess2.Models.Data
{
    public partial class TestTime
    {
        public DateTime? Stardate { get; set; }
        public DateTime? Startstamp { get; set; }
        public TimeSpan? Starttime { get; set; }
        public DateTimeOffset? Endtime { get; set; }
        public DateTimeOffset? Endstamp { get; set; }
        public TimeSpan? Span { get; set; }
    }
}
