using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DiscoverLookbookPageSearch
/// </summary>
public class DiscoverLookbookPageSearch
{
    public string categoryCheck { get; set; }
    public string seasonsCheck { get; set; }
    public string holidayCheck { get; set; }

    public string brandCheck { get; set; }

    public string brandSearchCheck { get; set; }

    public List<int> selectedTagsIds { get; set; }

	public DiscoverLookbookPageSearch()
	{
		
	}
}