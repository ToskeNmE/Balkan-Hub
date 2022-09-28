$(document).ready(function() {
    $(window).resize();
});

$(function () {
    function display(bool) {
        if (bool) {
            $("html").show();
  
        } else {
            $("html").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {

            if (item.status == true) {
                $("html").fadeIn();
                display(true)
            } else {
                $( "html" ).fadeOut( "slow", function() {
                    // Animation complete.
                  });
                display(false)
            }
        }
    
    })

    window.addEventListener('message', function (event) {
       
        try {
            switch(event.data.action) {
                case 'toggle':
                    var display = document.getElementsByTagName("body")[0].style.display;
                    display = display == 'block' ? 'none' : 'block';
                    $("html").fadeOut();
                    break;
                case 'show':
                    document.getElementsByTagName("body")[0].style.display = 'block';
                    break;
                case 'neprikazi':
                    document.getElementsByTagName("body")[0].style.display = 'none';
                    break;
                case 'vremeujail':
                    if (event.data.value != null) vremeujail.innerHTML = event.data.value;
                    break;
                    case 'rpime':
                        if (event.data.value != null) rpime.innerHTML = event.data.value;
                        break;
                        case 'paraufirmi':
                            if (event.data.value != null) paraufirmi.innerHTML = event.data.value.toLocaleString();
                            break;
                            case 'imevlasnika':
                                if (event.data.value != null) imevlasnika.innerHTML = event.data.value;
                                break;
            }
    
    } catch(err) {
        console.log('HUD => ' + err);
    }
    });
    // if the person uses the escape key, it will exit the resource
    

    //when the user clicks on the submit button, it will run
    $("#submit").click(function () {
        let inputValue = $("#input").val()
        if (inputValue.length >= 100) {
            $.post("https://hub_novo/hub_zatvor/error", JSON.stringify({
                error: "Input was greater than 100"
            }))
            return
        } else if (!inputValue) {
            $.post("https://hub_novo/hub_zatvor/error", JSON.stringify({
                error: "There was no value in the input field"
            }))
            return
        }
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('https://hub_novo/hub_zatvor/main', JSON.stringify({
            text: inputValue,
        }));
        return;
    })
})

$(window).resize(function() {
    if((window.fullScreen) || (window.innerWidth == screen.width && window.innerHeight == screen.height)) {
        $("html").css("overflow", "hidden");
    } else {
        $("html").css("overflow", "auto");
    }
});