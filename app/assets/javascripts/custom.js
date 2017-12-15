$(document).ready(function(){
    // $('.navbar .dropdown').hover(function() {
    //     $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideDown();
    // }, function() {
    //     $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp()
    // });

$('img').on('click', function(){
    console.log("--------------")
    console.log(Date.now())
})
    $('a').bind('ajax:success', function(event, data, status, xhr) {
        console.log("########################")
        console.log(event)
        console.log("########################")
        console.log(data);
        console.log("########################")
        console.log(status);
      });


})
