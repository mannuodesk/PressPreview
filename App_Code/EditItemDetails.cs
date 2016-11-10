﻿using System;
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
	public EditItemDetails()
	{
	}
}