$(document).ready(function(){


    //  When Modal Opened...
    $('#hamperModal').on('shown.bs.modal', function () {
        
        $.ajax({
          url: '/hampers/' + modal_hamper_id + '/hamper_items',
          success: function(data) {            
            $('#modal-ajax-content').html(data);
          }
        });

    })


    //  Visual feedback that Cart has changed
    $('#hamper_count').bind("DOMSubtreeModified",function(){
        if($(this).html() >= '1') {
            $(this).addClass('basket-full').removeClass('basket');;            
        }
        if($(this).html() == '0') {
            $(this).removeClass('basket-full').addClass('basket');            
        }
    });


    // Take a dom ref, data, and a mapFunction
    // runs the data through the map function creating HTML
    // places the HTML into the ref object
    // data can be a string value of a data attribute containing the data
    // this is how initial data is loaded
    // further calls can pass data from an ajax call
    function mapit(ref, data, mapFunc){
        if (typeof data == 'string') data = $(ref).data(data) || []
        $(ref).html("")
        var html = data ? data.map(mapFunc) : []
        html.forEach(function(item){
            $(ref).append(item)
        })
    }

    // a mapping function for mapit above
    // this one expects iterations over a collection of hampers
    var hamperMap = function(hamper){
        hamper_price = 0
        var str = "<hr>" 
            str += "<h4>" + (hamper.name || "My Hamper") + "</h4>"
            for(item in hamper.hamper_items){
                hamper_price += (hamper.hamper_items[item].price_when_ordered * hamper.hamper_items[item].quantity)
                str += "<h5>" + hamper.hamper_items[item].quantity + " x " + hamper.hamper_items[item].product.name+"</h5>"
                str += "<p>@ €" + hamper.hamper_items[item].price_when_ordered.toFixed(2) + " = <strong>€" + (hamper.hamper_items[item].quantity * hamper.hamper_items[item].price_when_ordered).toFixed(2) + "</strong></p>"
            }
            str += "<h5 class='danger'>Total: €" + hamper_price.toFixed(2) + "</h5>"
        return str
    }

    // just counts whats given to it and diaplys it on nav_bar
    function show_total(from){
        var total_products = from ? from.reduce(function(total, hamper){
            return total += hamper.length
        }, 0) : 0
        var total_hampers = from ? from.length : 0

        $('#hamper_count').html(total_hampers || 0)  // or total_products ???
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
            var hamper_name = prompt("What do you want to call this hamper?")
            $(this).closest('.btn-group').children('.dropdown-toggle').click()
            if(hamper_name){
                create_hamper(hamper_name, function(hamper_id){
                    create_hamper_item(hamper_id, product_id, quantity, price)
                })
                return false
            }else{
                return false
            }
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
        $('.add-menu').html("")
        for(hamper in hampers){
            $('.add-menu').append("<button class='dropdown-item add' type='button' data-hamper='"+hampers[hamper].id+"'>"+hampers[hamper].name+"</button>")
        }
        mapit('#display_hamper', hampers, hamperMap)
        show_total(hampers)
        hamper_btns(hampers)
    }


    function create_hamper(hamper_name, cb){      
        $.ajax({
            type: "POST",
            url: "/hamper/createhamper",
            data: { hamper_name: hamper_name },
            success:function(data, textStatus, res){
                var hamper = JSON.parse(res.getResponseHeader('hamper'))
                cb(hamper.id)
            },
            error:function(err){
                console.log(err.responseText)
            }
        });
    }

    function hamper_btns(hampers){    
        disabled = !(hampers && hampers.length>0)
        console.log(disabled)
        if(disabled){
            $( "#btn_clear_hamper" ).prop( "disabled", true );
            $('#btn_clear_hamper').addClass('disabled')
            $('#btn_manage_hampers').addClass('disabled')
            $('#btn_checkout').addClass('disabled')
        }else{
            $( "#btn_clear_hamper" ).prop( "disabled", false );
            $('#btn_clear_hamper').removeClass('disabled')
            $('#btn_manage_hampers').removeClass('disabled')
            $('#btn_checkout').removeClass('disabled')
        }
    }

    $('.btn-drawer').on('click', function(e){
        e.preventDefault()
        $('#drawer').toggleClass("showme")
        // THIS LINE BELOW MOVES THE BODY OVER
        // DEPENDING ON THE CHOSEN STYLE FOR THE DRAWER THIS MIGHT BE DISABLED
        $('#main-container').toggleClass("showme")
    })

    // This is an initiation
    function init(){
        if($('#display_hamper').data('hampers')){
            mapit('#display_hamper', 'hampers', hamperMap)
            show_total($('#display_hamper').data('hampers'))       
            hamper_btns($('#display_hamper').data('hampers'))
        }
    }

    init()
})
