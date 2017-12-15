$(document).ready(function(){
    // $('.navbar .dropdown').hover(function() {
    //     $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideDown();
    // }, function() {
    //     $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp()
    // });


    $('a').bind('ajax:success', function(event, data, status, xhr) {
        console.log("########################")
        console.log(event)
        console.log("########################")
        console.log(data);
        console.log("########################")
        console.log(status);
        $like = $(this).closest('.like_btn')
        var product_likes = parseInt($like.find('.product_likes').text())+1
        $like.html("<img src='/images/heart_red.svg' class='heart' />  <span class='product_likes'>"+ product_likes +"</span>")
      });


})
