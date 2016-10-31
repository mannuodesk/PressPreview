function shownewin()
{
jQuery('#dress').hide();
jQuery('#cloth').hide();
jQuery('#foot').hide();
jQuery('#newin').show();

jQuery( "#newina" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "active";
    jQuery( "#newina" ).addClass( "active" );
	jQuery( "#dressa" ).removeClass( "active" );
	jQuery( "#clotha" ).removeClass( "active" );
	jQuery( "#foota" ).removeClass( "active" );
  }
  return addedClass;
});

}// JavaScript Document

function showdresses()
{
jQuery('#dress').show();
jQuery('#cloth').hide();
jQuery('#foot').hide();
jQuery('#newin').hide();

jQuery( "#dressa" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "active";
    jQuery( "#dressa" ).addClass( "active" );
	jQuery( "#newina" ).removeClass( "active" );
	jQuery( "#clotha" ).removeClass( "active" );
	jQuery( "#foota" ).removeClass( "active" );
  }
  return addedClass;
});

}// JavaScript Document

function showcloth()
{
jQuery('#dress').hide();
jQuery('#cloth').show();
jQuery('#foot').hide();
jQuery('#newin').hide();

jQuery( "#clotha" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "active";
    jQuery( "#clotha" ).addClass( "active" );
	jQuery( "#newina" ).removeClass( "active" );
	jQuery( "#dressa" ).removeClass( "active" );
	jQuery( "#foota" ).removeClass( "active" );
  }
  return addedClass;
});

}// JavaScript Document


function showfootwear()
{
jQuery('#dress').hide();
jQuery('#cloth').hide();
jQuery('#foot').show();
jQuery('#newin').hide();

jQuery( "#foota" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "active";
    jQuery( "#foota" ).addClass( "active" );
	jQuery( "#newina" ).removeClass( "active" );
	jQuery( "#dressa" ).removeClass( "active" );
	jQuery( "#clotha" ).removeClass( "active" );
  }
  return addedClass;
});

}// JavaScript Document

jQuery(document).ready(function() {
			jQuery('.fancybox').fancybox();
		});
		
function showninline2()
{
jQuery('#inline1').hide();
jQuery('#inline2').hide();
}// JavaScript Document		
		
function shownlikes()
{
jQuery('#likes').show();
jQuery('#ratings').hide();
jQuery('#followers').hide();

jQuery( "#likea" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "activen";
    jQuery( "#likea" ).addClass( "activen" );
	jQuery( "#ratinga" ).removeClass( "activen" );
	jQuery( "#followa" ).removeClass( "activen" );
  }
  return addedClass;
});

}// JavaScript Document		
		
function shownratings()
{
jQuery('#likes').hide();
jQuery('#ratings').show();
jQuery('#followers').hide();

jQuery( "#ratinga" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "activen";
    jQuery( "#ratinga" ).addClass( "activen" );
	jQuery( "#likea" ).removeClass( "activen" );
	jQuery( "#followa" ).removeClass( "activen" );
  }
  return addedClass;
});

}// JavaScript Document	

function shownfollowers()
{
jQuery('#likes').hide();
jQuery('#ratings').hide();
jQuery('#followers').show();

jQuery( "#followa" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "activen";
    jQuery( "#followa" ).addClass( "activen" );
	jQuery( "#likea" ).removeClass( "activen" );
	jQuery( "#ratinga" ).removeClass( "activen" );
  }
  return addedClass;
});

}// JavaScript Document	


function showtags()
{
  jQuery('#tagfewer').hide();
  jQuery('.fewer').hide();
  jQuery('.fewerf').show();
}// JavaScript Document		

function showtagsf()
{
  jQuery('#tagfewer').show();
  jQuery('.fewerf').hide();
  jQuery('.fewer').show();
}// JavaScript Document	

function showtags11()
{
  jQuery('#tagfewer11').hide();
  jQuery('.fewer').hide();
  jQuery('.fewerf').show();
}// JavaScript Document		

function showtagsf11()
{
  jQuery('#tagfewer11').show();
  jQuery('.fewerf').hide();
  jQuery('.fewer').show();
}// JavaScript Document	

function showbmore()
{
    jQuery('#seeDefaultSessions').hide();
    jQuery('#seebmoreSeasons').show();
    $("#lblSelectedSeason").text("1");
  jQuery('.bmore').hide();
  jQuery('.bfewer').show();
}// JavaScript Document		

function showbfewer()
{
    jQuery('#seeDefaultSessions').show();
    jQuery('#seebmoreSeasons').hide();
    $("#lblSelectedSeason").text("2");
  jQuery('.bfewer').hide();
  jQuery('.bmore').show();
}// JavaScript Document	

function showbmore2() {

    jQuery('#seedefaultCats').hide();
    jQuery('#seebmoreCats').show();
    $("#lblSelectedCat").text("1");
    var checked_checkboxes = $("[id*=chkCategories] input:checked");
    var message = "";
    checked_checkboxes.each(function () {
        var value = $(this).val();
        var text = $(this).closest("td").find("label").html();
        message += "Text: " + text + " Value: " + value;
        message += "\n";

        alert(message);
    });
  jQuery('.bmore2').hide();
  jQuery('.bfewer2').show();
}// JavaScript Document		

function showbfewer2() {
    jQuery('#seedefaultCats').show();
    jQuery('#seebmoreCats').hide();
    $("#lblSelectedCat").text("2");
  jQuery('.bfewer2').hide();
  jQuery('.bmore2').show();
}// JavaScript Document		
	
function showbmore3()
{
    jQuery('#seeDefaultHoliday').hide();
    jQuery('#seebmoreHoliday').show();
    $("#lblSelectedHoliday").text("1");
  jQuery('.bmore3').hide();
  jQuery('.bfewer3').show();
}// JavaScript Document		

function showbfewer3()
{
    jQuery('#seeDefaultHoliday').show();
    jQuery('#seebmoreHoliday').hide();
    $("#lblSelectedHoliday").text("2");
  jQuery('.bfewer3').hide();
  jQuery('.bmore3').show();
}// JavaScript Document		
		
	
function showformmess()
{
  jQuery('#showformmes').show();
  jQuery('#cmes').hide();
  jQuery('#acmes').show();
}// JavaScript Document		
	
function showformmessa()
{
  jQuery('#showformmes').hide();
  jQuery('#acmes').hide();
  jQuery('#cmes').show();
}// JavaScript Document	

function actionma()
{
  jQuery('#actionm').hide();	
  jQuery('#actionms').show();
  jQuery('#actiomvm').show();
}// JavaScript Document		

function actionmas()
{
  jQuery('#actionm').show();	
  jQuery('#actionms').hide();
  jQuery('#actiomvm').hide();
}// JavaScript Document		

function addmoreim()
{
  jQuery('#moreaddimages').show();
}// JavaScript Document		
	


function letter1()
{
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').show();
}// JavaScript Document	
			

function letter2()
{
  jQuery('#letter2').show();
  jQuery('#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
  jQuery( "#letter2a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter2a" ).addClass( "letteractive" );
	jQuery( "#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});
}// JavaScript Document	

function letter3()
{
  jQuery('#letter3').show();
  jQuery('#letter2,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
    jQuery( "#letter3a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter3a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter4()
{
  jQuery('#letter4').show();
  jQuery('#letter2,#letter3,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
  jQuery( "#letter4a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter4a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});
}// JavaScript Document	


function letter5()
{
  jQuery('#letter5').show();
  jQuery('#letter2,#letter3,#letter4,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
    jQuery( "#letter5a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter5a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	


function letter6()
{
  jQuery('#letter6').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
      jQuery( "#letter6a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter6a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter7()
{
  jQuery('#letter7').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
        jQuery( "#letter7a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter7a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter8()
{
  jQuery('#letter8').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
   jQuery( "#letter8a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter8a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});
}// JavaScript Document	

function letter9()
{
  jQuery('#letter9').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
     jQuery( "#letter9a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter9a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter10()
{
  jQuery('#letter10').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
       jQuery( "#letter10a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter10a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter11()
{
  jQuery('#letter11').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
         jQuery( "#letter11a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter11a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter12()
{
  jQuery('#letter12').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
  jQuery( "#letter12a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter12a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter13()
{
  jQuery('#letter13').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
  jQuery( "#letter13a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter13a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter14()
{
  jQuery('#letter14').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
    jQuery( "#letter14a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter14a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	


function letter15()
{
  jQuery('#letter15').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
      jQuery( "#letter15a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter15a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter16()
{
  jQuery('#letter16').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
   jQuery( "#letter16a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter16a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter17()
{
  jQuery('#letter17').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
     jQuery( "#letter17a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter17a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter18()
{
  jQuery('#letter18').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
       jQuery( "#letter18a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter18a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter19()
{
  jQuery('#letter19').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
         jQuery( "#letter19a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter19a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter20()
{
  jQuery('#letter20').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
 jQuery( "#letter20a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter20a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter21()
{
  jQuery('#letter21').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter22,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
   jQuery( "#letter21a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter21a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter22()
{
  jQuery('#letter22').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter23,#letter24,#letter25,#letter26,#letter27').hide();
     jQuery( "#letter22a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter22a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter23a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter23()
{
  jQuery('#letter23').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter24,#letter25,#letter26,#letter27').hide();
       jQuery( "#letter23a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter23a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter24a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter24()
{
  jQuery('#letter24').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter25,#letter26,#letter27').hide();
  jQuery( "#letter24a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter24a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter25a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter25()
{
  jQuery('#letter25').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter26,#letter27').hide();
    jQuery( "#letter25a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter25a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter26a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter26()
{
  jQuery('#letter26').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter27').hide();
      jQuery( "#letter26a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter26a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter27" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

function letter27()
{
  jQuery('#letter27').show();
  jQuery('#letter2,#letter3,#letter4,#letter5,#letter6,#letter7,#letter8,#letter9,#letter10,#letter11,#letter12,#letter13,#letter14,#letter15,#letter16,#letter17,#letter18,#letter19,#letter20,#letter21,#letter22,#letter23,#letter24,#letter25,#letter26').hide();
        jQuery( "#letter27a" ).addClass(function( index, currentClass ) {
  var addedClass;
  if ( currentClass === "" ) {
    addedClass = "letteractive";
    jQuery( "#letter27a" ).addClass( "letteractive" );
	jQuery( "#letter2a,#letter3a,#letter4a,#letter5a,#letter6a,#letter7a,#letter8a,#letter9a,#letter10a,#letter11a,#letter12a,#letter13a,#letter14a,#letter15a,#letter16a,#letter17a,#letter18a,#letter19a,#letter20a,#letter21a,#letter22a,#letter23a,#letter24a,#letter25a,#letter26" ).removeClass( "letteractive" );
  }
  return addedClass;
});

}// JavaScript Document	

