using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EditItemDetails
/// </summary>
public class EditItemDetails
{
    public string FeaturedImage { get; set; }
    public string RemoveFeaturedImage { get; set; }
    public List<ItemImageFileName> ImagesToAdd { get; set; }
    public List<string> ImagesToRemove { get; set; }
    public List<string> TagsToAdd { get; set; }
    public List<string> TagsToRemove { get; set; }
    public string Description { get; set; }
    public string Color { get; set; }
    public List<int> SelectedCategories { get; set; }
    public List<int> SelectedSeasons { get; set; }
    public List<int> SelectedHolidays { get; set; }
    public bool Category_MoreThanTenCounter{get;set;}
    public bool Season_MoreThanTenCounter{get;set;}
    public bool Holiday_MoreThanTenCounter { get; set; }
    public bool Tags_MoreThanTenCounter { get; set; }
    public EditItemDetails()
    {
    }
}