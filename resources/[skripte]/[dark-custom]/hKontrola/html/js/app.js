$(function() {
var scriptName = 'hKontrola'

window.addEventListener('message', function(event) {
    var item = event.data
    if (item.type == "openmenu") {
        $('body').fadeIn("slow");
    }
});

document.addEventListener('keydown', function(e) {
    if(e.keyCode == 27){
        $('body').fadeOut("slow");
        $.post('https://' + scriptName + '/action', JSON.stringify({
            type: 'close',
        }));
    }
});

$('#desna-zadnja').click(function(){
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'vrata',
        vrata: 3,
    }));
})

$('#desna-prednja').click(function(){
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'vrata',
        vrata: 1,
    }));
})

$('#leva-zadnja').click(function(){
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'vrata',
        vrata: 2,
    }));
})

$('#leva-prednja').click(function(){
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'vrata',
        vrata: 0,
    }));
})


$('#hauba').click(function(){
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'vrata',
        vrata: 4,
    }));
})

$('#gepek').click(function(){
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'vrata',
        vrata: 5,
    }));
})

$('#leva-zadnji').click(function(){
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'prozor',
        prozor: 3,
        vrata: 2,
    }));
})

$('#leva-prednji').click(function(){
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'prozor',
        prozor: 1,
        vrata: 0,
    }));
})

$('#desna-zadnji').click(function(){
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'prozor',
        prozor: 2,
        vrata: 3,
    }));
})

$('#desna-prednji').click(function(){
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'prozor',
        prozor: 0,
        vrata: 1,
    }));
})

})