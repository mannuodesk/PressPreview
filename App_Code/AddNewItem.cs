using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AddNewItem
/// </summary>
public class AddNewItem
{
    public List<int> SelectedCategories { get; set; }
    public List<int> SelectedSeasons { get; set; }
    public List<int> SelectedHolidays { get; set; }
	public bool Category_MoreThanTenCounter{get;set;}
    public bool Season_MoreThanTenCounter{get;set;}
    public bool Holiday_MoreThanTenCounter { get; set; }
	public AddNewItem()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}