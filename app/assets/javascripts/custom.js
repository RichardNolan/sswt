$(document).ready(function(){
    // $('.navbar .dropdown').hover(function() {
    //     $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideDown();
    // }, function() {
    //     $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp()
    // });

    

    // BUY BUTTON HANDLER
    $('.buy').on('click', function(){
        var product_id = $(this).data("id")
        var price = $(this).data("price")
        var hamper = $(this).data("hamper") || 0
        var quantity = $(this).parent().siblings('.quantity').val() || 1

        console.log(product_id, price, hamper, quantity)

        $.ajax({
            type: "POST",
            url: "/hamper/add",
            data: { product_id: product_id, price: price, quantity: quantity, hamper_id: hamper },
            success:function(data, textStatus, req){
                console.log("SUCCESS")
                console.log(req.getResponseHeader('Hamper'))
                //reload the /hampers_modal in the iframe... the date now changes the address to avoid caches
                $('#hamperModalIframe').attr('src', "/hampers_modal?reload="+Date.now());
            },
            error:function(err){
                console.log(err)
            }
          });
    });

    // EMPTY BUTTON HANDLER
    $('.empty').on('click', function(){
        if(confirm("Are you sure you want to discard everything in this hamper?")){
            var hamper = $(this).data("hamper") || 0

            $.ajax({
                type: "POST",
                url: "/hamper/empty",
                data: { hamper_id: hamper },
                success:function(data, textStatus, req){
                    console.log("SUCCESS")
                    console.log(req.getResponseHeader('Hamper'))
                    $('#hamperModalIframe').attr('src', "/hampers_modal?reload="+Date.now());
                },
                error:function(err){
                    console.log(err)
                }
            });
        }
    });



})
