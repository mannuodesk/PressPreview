/**
 * Base js functions
 */

jQuery(document).ready(function(){
    //Init jQuery Masonry layout
    init_masonry();

    //Select menu onchange
    jQuery("#collapsed-navbar").change(function () {
        window.location = jQuery(this).val();
    });
});


function init_masonry(){
    var jQuerycontainer = jQuery('#contentbox');

    jQuerycontainer.imagesLoaded( function(){
        jQuerycontainer.masonry({
          itemSelector: '.box1',
          isAnimated: true
        });
    });
    var jQuerycontainer = jQuery('#contentbox2');

    jQuerycontainer.imagesLoaded(function () {
        jQuerycontainer.masonry({
            itemSelector: '.box1',
            isAnimated: true
        });
    });
}

function init_masonry(){
    var jQuerycontainer = jQuery('#contentbox');

    jQuerycontainer.imagesLoaded( function(){
        jQuerycontainer.masonry({
          itemSelector: '.boxn1',
          isAnimated: true
        });
    });
    var jQuerycontainer = jQuery('#contentbox2');

    jQuerycontainer.imagesLoaded(function () {
        jQuerycontainer.masonry({
            itemSelector: '.boxn1',
            isAnimated: true
        });
    });
}


