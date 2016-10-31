using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Alphabet
/// </summary>
public class Alphabet
{
    private string _value;
    private bool _isNotSelected;

    public string Value
    {
        get
        {
            return _value;
        }
        set
        {
            _value = value;
        }
    }

    public bool isNotSelected
    {
        get
        {
            return _isNotSelected;
        }
        set
        {
            _isNotSelected = value;
        }
    }
}