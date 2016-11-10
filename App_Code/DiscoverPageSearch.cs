using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DiscoverPageSearch
/// </summary>
public class DiscoverPageSearch
{
    public string categoryCheck { get; set; }
    public string seasonsCheck { get; set; }
    public string colorCheck { get; set; }
    public string holidayCheck { get; set; }

    public string p1check { get; set; }

    public string chkP2_Check { get; set; }
    public string chkP3_Check { get; set; }
    public string chkP4_Check { get; set; }
    public string chkP5_Check { get; set; }
    public string chkP6_Check { get; set; }
    public string brandCheck { get; set; }
    public List<int> selectedTagsIds { get; set; }

    public string brandSearchCheck { get; set; }
	public DiscoverPageSearch()
	{   
	}
}