$(document).ready(function(){
    // $('.navbar .dropdown').hover(function() {
    //     $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideDown();
    // }, function() {
    //     $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp()
    // });

    

    // BUY BUTTON HANDLER
    $(document).on('click', '.buy', function(){
      
        var product_id = $(this).data("id")
        var price = $(this).data("price")
        var hamper_id = $(this).data("hamper") || 0
        var quantity = $(this).closest(".add-group").children('.quantity').val() || 1 
        
        
        if($(this).data("do")=="NEW_HAMPER"){
            var hamper_name = prompt("What do you want to call this hamper?") || "My Hamper"
            // create_hamper(hamper_name)
            create_hamper(hamper_name, function(hamper_id){
                console.log("ready to add item")
                create_hamper_item(hamper_id, product_id, quantity, price)
                console.log(hamper_id, product_id, quantity, price)
            })
            return false
        }

        create_hamper_item(hamper_id, product_id, quantity, price)
    });

    // EMPTY BUTTON HANDLER
    $('.empty').on('click', function(){
        if(confirm("Are you sure you want to discard everything in this hamper?")){
            var hamper_id = $(this).data("hamper") || 0

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



    function create_hamper_item(hamper_id, product_id, quantity, price){        
        $.ajax({
            type: "POST",
            url: "/hamper/add",
            data: { product_id: product_id, price: price, quantity: quantity, hamper_id: hamper_id },
            success:function(data, textStatus, res){
                console.log("SUCCESS")
                console.log(res.getResponseHeader('Hamper'))
                //reload the /hampers_modal in the iframe... the date.now changes the address to avoid caches
                $('#hamperModalIframe').attr('src', "/hampers_modal?reload="+Date.now());
            },
            error:function(err){
                console.log(err.responseText)
            }
          });
    }


    function create_hamper(hamper_name, cb){      
        $.ajax({
            type: "POST",
            url: "/hamper/createhamper",
            data: { hamper_name: hamper_name },
            success:function(data, textStatus, res){
                console.log("SUCCESS")
                console.log(res.getAllResponseHeaders())
                // console.log(res.getResponseHeader('hamper_id'))
                cb(res.getResponseHeader('hamper-id'))
                //reload the /hampers_modal in the iframe... the date.now changes the address to avoid caches
                $('#hamperModalIframe').attr('src', "/hampers_modal?reload="+Date.now());
            },
            error:function(err){
                console.log(err.responseText)
            }
          });
    }


})
