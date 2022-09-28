
$(document).ready(function() {
    $(window).resize();
    $("html").hide();
});
window.addEventListener('message', function (event) {
    var item = event.data;
    if(item.type == "pokazi") {
        if (item.value) {
            $("html").show();
        } else {
            $("html").hide();
        }
    }
   if(item.type == "update") {
        $("html").show();
        $("#njegovid").text(item.id);
        $("#njegovuid").text(item.uid);
        $("#brojigraca").text(item.online);
   }
   try {
    switch(event.data.action) {
        case 'toggle':
            var display = document.getElementsByTagName("body")[0].style.display;
            display = display == 'block' ? 'none' : 'block';
            break;
        case 'show':
            document.getElementsByTagName("body")[0].style.display = 'block';
            break;
        case 'neprikazi':
            document.getElementsByTagName("body")[0].style.display = 'none';
            break;
        case 'job':
            if (event.data.value != null) job.innerHTML = event.data.value;
            break;
        case 'id':
            if (event.data.value != null) id.innerHTML = event.data.value;
            break;
        case 'setMoney':
            if (event.data.value.money != null) money.innerHTML = event.data.value.money.toLocaleString();
            if (event.data.value.bank != null) bank.innerHTML = event.data.value.bank.toLocaleString();
            if (event.data.value.black_money != null) black_money.innerHTML = event.data.value.black_money.toLocaleString();
            break;
    }
} catch(err) {
    console.log('HUD => ' + err);
}
});

$(window).resize(function() {
    if((window.fullScreen) || (window.innerWidth == screen.width && window.innerHeight == screen.height)) {
        $("html").css("overflow", "hidden");
    } else {
        $("html").css("overflow", "auto");
    }
});