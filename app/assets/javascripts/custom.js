$(document).ready(function(){
    $('.navbar .dropdown').hover(function() {
        $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideDown();
    }, function() {
        $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp()
    });



    $(document).on('click', '.sidekick_image', function(){
        $('#hero_image').attr('src', $(this).attr('src'))
    })
})
