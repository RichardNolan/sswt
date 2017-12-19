$(document).ready(function(){


    function mapit(ref, data, mapFunc){
        if (typeof data == 'string') data = $(ref).data(data) || []
        $(ref).html("")
        var html = data ? data.map(mapFunc) : []
        html.forEach(function(item){
            $(ref).append(item)
        })

    }

    var hamperMap = function(hamper){
        hamper_price = 0
        var str = "<hr>" 
            str += "<h4>" + (hamper.name || "My Hamper") + "</h4>"
            for(item in hamper.hamper_items){
                hamper_price += hamper.hamper_items[item].price_when_ordered
                str += "<h5>" + hamper.hamper_items[item].quantity + " x " + hamper.hamper_items[item].product.name+"</h5>"
                str += "<p>@ €" + hamper.hamper_items[item].price_when_ordered.toFixed(2) + " = <strong>€" + (hamper.hamper_items[item].quantity * hamper.hamper_items[item].price_when_ordered).toFixed(2) + "</strong></p>"
            }
            str += "<h5 class='danger'>Total: €" + hamper_price.toFixed(2) + "</h5>"
        return str
    }

    hampers_data = $('#display_hamper').data('hampers')

    if(hampers_data){
        mapit('#display_hamper', 'hampers', hamperMap)

        // CHOICE BETWEEN SHOWING TOTAL HAMPERS OR TOTAL PRODUCTS IN NAV BAR
        var total_products = hampers_data.reduce(function(total, hamper){
            return total += hamper.length
        }, 0)
        var total_hampers = hampers_data.length
        $('#hamper_count').html(total_hampers)
    }

    $('a').bind('ajax:success', function(event, data, status, xhr) {
        console.log('a ajax')
        $like = $(this).closest('.like_btn')
        var product_likes = parseInt($like.find('.product_likes').text())+1
        $like.html("<img src='/images/heart_red.svg' class='heart' />  <span class='product_likes'>"+ product_likes +"</span>")
    });

    $(document).on('click', '.sidekick_image', function(){
        $('#hero_image').attr('src', $(this).attr('src'))
    })

    $(document).on('click', '.upload', function(e){
        e.preventDefault();
        $(this).siblings('input[type=file]').click()
    })

    
    // ADD BUTTON HANDLER
    $(document).on('click', '.add', function(){
    
        var hamper_id = $(this).data("hamper") || 0
        var product_id = $(this).closest(".add-group").children('.quantity').data("id")
        var price = $(this).closest(".add-group").children('.quantity').data("price")
        var quantity = $(this).closest(".add-group").children('.quantity').val() || 1 
          
          if($(this).data("do")=="NEW_HAMPER"){
              var hamper_name = prompt("What do you want to call this hamper?") || "My Hamper"
              create_hamper(hamper_name, function(hamper_id){
                  create_hamper_item(hamper_id, product_id, quantity, price)
              })
              return false
          }
          create_hamper_item(hamper_id, product_id, quantity, price)
      });
  

      
    // EMPTY BUTTON HANDLER
    $('.empty').on('click', function(){
        if(confirm("Are you sure you want to discard everything in this hamper?")){
            var hamper_id = $(this).data("hamper") || 0
console.log(hamper_id)
            $.ajax({
                type: "POST",
                url: "/hamper/empty",
                data: { hamper_id: hamper_id },
                success:hamperResult,
                error:function(err){
                    console.log(err)
                }
            });
        }
    });



    function create_hamper_item(hamper_id, product_id, quantity, price){        
        $.ajax({
            type: "POST",
            url: "/hamper_item/add",
            data: { product_id: product_id, price: price, quantity: quantity, hamper_id: hamper_id },
            success: hamperResult,
            error:function(err){
                console.log(err.responseText)
            }
        });
    }

    var hamperResult = function(data, textStatus, res){
        var hampers = JSON.parse(res.getResponseHeader('Hampers'))
        console.log(hampers)
        mapit('#display_hamper', hampers, hamperMap)
        $('#hamper_count').html(hampers ? hampers.length : 0)
    }


    function create_hamper(hamper_name, cb){      
        $.ajax({
            type: "POST",
            url: "/hamper/createhamper",
            data: { hamper_name: hamper_name },
            success:function(data, textStatus, res){
                var hamper = JSON.parse(res.getResponseHeader('hamper'))
                console.log(hamper)
                cb(hamper.id)
            },
            error:function(err){
                console.log(err.responseText)
            }
        });
    }



    $('.btn-drawer').on('click', function(e){
        e.preventDefault()
        $('#drawer').toggleClass("showme")
        // THIS LINE BELOW MOVES THE BODY OVER
        // DEPENDING ON THE CHOSEN STYLE FOR THE DRAWER THIS MIGHT BE DISABLED
        $('#main-container').toggleClass("showme")
    })
})
