/*  THIS FILE AND THE ACCOMPANYING FILEUPLOADPREVIEW.CSS
    ARE DESIGNED TO HIDE THE STANDARD FILE INPUT TYPE
    THIS IS WITHOUT REDUCING THE FUNCTIONALITY OR USING ANY 
    OTHER TECHNOLOGIES. THE FORM IS HIDDEN AND THE LABEL IS
    USED TO INITIATE THE FILE SELECTION. 

    THESE FEATURES ARE BEING COMMENTED OUT FOR NOW
*/


$(function(){
    $placeholder = null
    $("input:file").on('change', function(e){
        reader.readAsDataURL(e.target.files[0])
        $placeholder = $(this).siblings('img')
    }) 
    
    $("input:file").on('click', function(){
        this.value = null
    })
});


var reader = new FileReader();    
reader.onload = function(){
    $placeholder.attr('src', reader.result); 
    $('#image_placeholder').attr('src', reader.result); 
}
reader.onerror = function(){
    reader.abort()
}
