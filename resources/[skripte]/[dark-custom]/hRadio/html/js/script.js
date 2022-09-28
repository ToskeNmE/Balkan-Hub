$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "open") {
            ESXRadio.SlideUp()
        }

        if (event.data.type == "close") {
            ESXRadio.SlideDown()
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('https://hRadio/escape', JSON.stringify({}));
            ESXRadio.SlideDown()
        } else if (data.which == 13) { // Enter key
            $.post('https://hRadio/joinRadio', JSON.stringify({
                channel: $("#channel").val()
            }));
        }
    };
});

ESXRadio = {}

$(document).on('click', '#submit', function(e){
    e.preventDefault();

    $.post('https://hRadio/joinRadio', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#disconnect', function(e){
    e.preventDefault();

    $.post('https://hRadio/leaveRadio');
});

$(document).on('click', '#volumeUp', function(e){
    e.preventDefault();

    $.post('https://hRadio/volumeUp', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#volumeDown', function(e){
    e.preventDefault();

    $.post('https://hRadio/volumeDown', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#decreaseradiochannel', function(e){
    e.preventDefault();

    $.post('https://hRadio/decreaseradiochannel', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#increaseradiochannel', function(e){
    e.preventDefault();

    $.post('https://hRadio/increaseradiochannel', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#poweredOff', function(e){
    e.preventDefault();

    $.post('https://hRadio/poweredOff', JSON.stringify({
        channel: $("#channel").val()
    }));
});

ESXRadio.SlideUp = function() {
    $(".container").css("display", "block");
    $(".radio-container").animate({bottom: "6vh",}, 250);
}

ESXRadio.SlideDown = function() {
    $(".radio-container").animate({bottom: "-110vh",}, 400, function(){
        $(".container").css("display", "none");
    });
}
