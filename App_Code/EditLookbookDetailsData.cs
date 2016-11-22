using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EditLookbookDetailsData
/// </summary>
public class EditLookbookDetailsData
{
    public string LookBookFeaturedImage { get; set; }
	public List<int> SelectedCategories { get; set; }
    public List<int> SelectedSeasons { get; set; }
    public List<int> SelectedHolidays { get; set; }
	public bool Category_MoreThanTenCounter { get; set; }
    public bool Season_MoreThanTenCounter { get; set; }
    public bool Holiday_MoreThanTenCounter { get; set; }
	public EditLookbookDetailsData()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}