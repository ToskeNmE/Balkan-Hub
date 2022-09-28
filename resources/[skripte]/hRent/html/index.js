$(document).ready(function(){
    $(".container").hide();

    function print(param) { 
        console.log(param)
    }

    window.addEventListener("message", function(event){
        var k = event.data.key
        var v = event.data.value
        $(".container").fadeIn(500);
        UcitajVozila(k, v)
    });
    
    document.onkeyup = function (data) {
        if (data.which == 27) { //esc
            close()
            return
        }
    };

   $(document).on("click", "#close", function (param) { 
       close()
    })

    function close() { 
        $.post('http://hRent/close', JSON.stringify({display: false}));
        $(".container").fadeOut(500);
    }
    function UcitajVozila(k, v) {
        document.getElementById("label").innerHTML = k 
        $(".blista").remove();
        for (i=0; i < v.Vehicles.length; i++) {
            $(".vehicles").append('<div class="blista"><p class="label"> ' + v.Vehicles[i].label+ '</p> <p class="price"> $' + v.Vehicles[i].price + '</p> <img src="' + v.Vehicles[i].name + '.png" alt="'+v.Vehicles[i].name+'"><button class="rent-button" id="'+i+'" type="submit">Iznajmi<hr></button>');
            $("#"+i).data("data", v.Vehicles[i]);
        }
    }

    $(document).on("click", ".rent-button", function (e) { 
        var data = $(this).data("data")
        $.post('http://hRent/rent', JSON.stringify({data: data}));
        close()
    });
})

//