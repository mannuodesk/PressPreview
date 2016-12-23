using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AddNewLookbook
/// </summary>
public class AddNewLookbook
{
    public List<int> SelectedCategories { get; set; }
    public List<int> SelectedSeasons { get; set; }
    public List<int> SelectedHolidays { get; set; }
	public List<int> ItemIds { get; set; }
	public bool Category_MoreThanTenCounter{get;set;}
    public bool Season_MoreThanTenCounter{get;set;}
    public bool Holiday_MoreThanTenCounter { get; set; }
	public AddNewLookbook()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}