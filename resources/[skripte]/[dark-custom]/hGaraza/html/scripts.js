$(document).ready(function(){
	
  var number = 0;
  var number2 = 0;
  var number3 = 0;
  
  function closeMain() {
    $("body").css("display", "none");
  }
  function openMain() {
    $("body").css("display", "block");
  }
  function closeAll() {
    $(".body").css("display", "none");
  }
  
  window.addEventListener('message', function(event){
    var item = event.data;
	
    if(item.openGarage == true) {
      openMain();
	  $('#header').text(item.text)
    }
    if(item.openGarage == false) {
      closeMain();
    }

    if(item.clearme == true) {
	  for(var i=1; i<=number; i++) {
		if(!$("#btnCar" + i).hasClass('btnCar')) { $("#btnCar" + number).addClass('btnCar');}
	  }
	  number = 0;
    }
	
	if(item.clearimp == true) {
	  for(var i=1; i<=number2; i++) {
		if(!$("#impCar" + i).hasClass('impCar')) { $("#impCar" + number).addClass('impCar');}
	  }
	  number2 = 0;
    }
	
    if(item.addcar == true) {
	  var car = '<a href="#" class="button sans btnCar" id="btnCar' + item.number + '" model=""></a>';
	  $("#cars").append(car);
      $("#btnCar" + item.number).removeClass('btnCar');
      $("#btnCar" + item.number).html(item.name);
      $("#btnCar" + item.number).attr('model', item.model);
	  number = number + 1;
    }
	
	if(item.impcar == true) {
	  var car = '<a href="#" class="button sans impCar" id="impCar' + item.number + '" model=""></a>';
	  $("#cars").append(car);
      $("#impCar" + item.number).removeClass('impCar');
      $("#impCar" + item.number).html(item.name);
      $("#impCar" + item.number).attr('model', item.model);
	  number2 = number2 + 1;
    }
	
  });
  
  document.onkeyup = function (data) {
    if (data.which == 27 ) {
      $.post('http://hGaraza/close', JSON.stringify({}));
		setTimeout(function(){
			if ($('#btnCar1').length > 0) {
				for (var j=1; j<=number; j++) {
					document.getElementById("btnCar" + j).remove();
				}
			} 
			if ($('#impCar1').length > 0) {
				for (var j=1; j<=number2; j++) {
					var elem = document.getElementById("impCar" + j).remove();
				}
			}
		}, 500);
    }
  };
  
  document.addEventListener('click',function(e){
	for (var i=1; i<=number; i++) {
		if(e.target && e.target.id == 'btnCar' + i){
			var model = $("#btnCar" + i).attr('model');
			$.post('http://hGaraza/pullCar',  JSON.stringify({ model: $("#btnCar" + i).attr('model') }));
			setTimeout(function(){
				for (var j=1; j<=number; j++) {
					document.getElementById("btnCar" + j).remove();
				}
			}, 500);
		}
	}
  });
  
  document.addEventListener('click',function(e){
	for (var i=1; i<=number2; i++) {
		if(e.target && e.target.id == 'impCar' + i){
			var model = $("#impCar" + i).attr('model');
			$.post('http://hGaraza/towCar',  JSON.stringify({ model: $("#impCar" + i).attr('model') }));
			setTimeout(function(){
				for (var j=1; j<=number2; j++) {
					document.getElementById("impCar" + j).remove();
				}
			}, 500);
		}
	}
  });

	$(".btnClose").click(function(){
		$.post('http://hGaraza/close', JSON.stringify({}));
		setTimeout(function(){
			if ($('#btnCar1').length > 0) {
				for (var j=1; j<=number; j++) {
					document.getElementById("btnCar" + j).remove();
				}
			} 
			if ($('#impCar1').length > 0) {
				for (var j=1; j<=number2; j++) {
					var elem = document.getElementById("impCar" + j).remove();
				}
			}
		}, 500);
    });
});

document.onkeyup = function (data) {
    if (data.which == 27) {
        $( "body" ).fadeOut( "slow", function() {
            // Animation complete.
          });
        $.post('https://hGaraza/close', JSON.stringify({}));
        return
    }
};