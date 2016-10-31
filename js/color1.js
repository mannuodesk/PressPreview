$(document).ready(function() {
						   
// Here we will write a function when link click under class popup				   
$('a.popup').click(function() {
									
									
// Here we will describe a variable popupid which gets the
// rel attribute from the clicked link							
var popupid = $(this).attr('rel');


// Now we need to popup the marked which belongs to the rel attribute
// Suppose the rel attribute of click link is popuprel then here in below code
// #popuprel will fadein
$('#' + popupid).fadeIn();


// append div with id fade into the bottom of body tag
// and we allready styled it in our step 2 : CSS
$('body').append('<div id="fade"></div>');
$('#fade').css({'filter' : 'alpha(opacity=80)'}).fadeIn();

$('body').append('<div id="fade1"></div>');
$('#fade1').css({'filter' : 'alpha(opacity=80)'}).fadeIn();




// Now here we need to have our popup box in center of 
// webpage when its fadein. so we add 10px to height and width 
var popuptopmargin = ($('#' + popupid).height() + 10) / 2;
var popupleftmargin = ($('#' + popupid).width() + 10) / 2;


// Then using .css function style our popup box for center allignment
$('#' + popupid).css({
'margin-top' : -popuptopmargin,
'margin-left' : -popupleftmargin
});
});


// Now define one more function which is used to fadeout the 
// fade layer and popup window as soon as we click on fade layer
$('#fade , #fade1 , #fade2 , #fade3 , #fade4 , #fade5 , #fade6 , #fade7 , #fade8 , #fade9 , #fade10 , #fade11 , #fade12 , #fade13 , #fade14 , #fade15 , #fade16 , #fade17 , #fade18').click(function() {
// Add markup ids of all custom popup box here 						  
$('#fade , #fade1 , #fade2 , #fade3 , #fade4 , #fade5 , #fade6 , #fade7 , #fade8 , #fade9 , #fade10 , #fade11 , #fade12 , #fade13 , #fade14 , #fade15 , #fade16 , #fade17 , ,#popuprel , #popuprel2 , #popuprel3 , #popuprel4, #popuprel5 , #popuprel6 , #popuprel7 , #popuprel8, #popuprel9, #popuprel10 , #popuprel11 , #popuprel12 , #popuprel13 , #popuprel14, #popuprel15, #popuprel16 , #popuprel17 , #popuprel18 , #popuprel19 ').fadeOut()
return false;
});



});