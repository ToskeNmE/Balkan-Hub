var imeskripte = 'hMafije'
var poeni = 0
var level = 0

window.addEventListener('message', function(event) {
    var item = event.data
    if (item.type == "openvehicle") {
        $('#vehicle-wrapper').fadeIn();
        napravivozila(item)
    }
    if (item.type == "closemenu") {
        $("#vehicle-wrapper").fadeOut();
        $("#vehicle-wrapper").html('');
        $.post('https://' + imeskripte + '/action', JSON.stringify({
            type: 'close',
        }));
    }
    if (item.type == "openboss") {
        $("#lvl-orge").attr("src", "https://balkan-hub.com/development/slike/mafije/rankovi/iron.png");
        $('#bossmenu-wrapper').fadeIn();
        $("#lvl-orge").attr("src", "https://balkan-hub.com/development/slike/mafije/rankovi/" + item.level +".png");
        $('#poeni-org').text(item.poeni);
        level = Number(item.lvlbr)
        poeni = item.poeni
    }
    if (item.type == "napraviigrace") {
        napravilistu(item.data);
    }
    if (item.type == "napraviclanove2") {
        napraviclanove(item.data);
    }
    if (item.type == "napravivozila") {
        napravivozilazaprodaju(item.data);
    }
    if (item.type == "updatepoene") {
        $('#poeni-org').text(item.poeni2);
    }
    if (item.type == "updatelevel") {
        poeni = item.poeni;
        level = item.lvl2
        $("#lvl-orge").attr("src", "https://balkan-hub.com/development/slike/mafije/rankovi/" + item.lvl +".png");
        $('#poeni-org').text(item.poeni);
    }
});

function napravivozila(item) {
    $("#vehicle-wrapper").append(`
        <div id="car-container">
            <img src="https://balkan-hub.com/development/slike/autosalon/`+ item.carname +`.png">
            <p id="car-name">`+ item.carlabel +`</p>
            <button onclick="spawnveh('`+ item.carname +`', '`+ item.carlabel +`', '`+ item.vehplate +`', '`+ item.primer +`')">IZVADI VOZILO</button>
        </div>
    `);
}

function spawnveh(carname, carlabel, vehplate, primer) {
    $.post('https://' + imeskripte + '/action', JSON.stringify({
        type: 'spawnveh',
        carspawn: carname,
        carlabel: carlabel,
        vehplate: vehplate,
        primer: primer
    }));
}

function zaposljavanje() {
    $.post('https://' + imeskripte + '/action', JSON.stringify({
        type: 'getajlistu',
    }));
    $('#bossmenu-wrapper').fadeOut();
    $('#zaposljavanje-wrapper').fadeIn();
}

function upravljanje() {
    $.post('https://' + imeskripte + '/action', JSON.stringify({
        type: 'getajzaposljene',
    }));
    $('#bossmenu-wrapper').fadeOut();
    $('#upravljanje-wrapper').fadeIn();
}

function salonorge() {
    $.post('https://' + imeskripte + '/action', JSON.stringify({
        type: 'getajvozilazaorgu',
    }));
    $('#bossmenu-wrapper').fadeOut();
    $('#salonorge-wrapper').fadeIn();
}


function napravilistu(item) {
    $("#lista-igraca").append(`
        <button id='`+ item.id +`'>`+ item.ime +`</button>
    `);

    $('#' + item.id).click(function(){
        $.post('https://' + imeskripte + '/action', JSON.stringify({
            type: 'setajjob',
            ime: item.ime,
            id: item.id
        }));
        $("#lista-igraca").html('');
        $('#zaposljavanje-wrapper').fadeOut();
        $('#bossmenu-wrapper').fadeIn();
    })
}

function napravivozilazaprodaju(item) {
    $("#lista-vozila").append(`
        <div>
            <img src="https://balkan-hub.com/development/slike/autosalon/`+ item.ime +`.png">
            <p>CENA : <span>`+ item.cena +` poena</span></p>
            <button id='`+ item.ime +`'>KUPI</button>
        </div>
    `);

    $('#' + item.ime).click(function(){
        $.post('https://' + imeskripte + '/action', JSON.stringify({
            type: 'kupivozilo',
            ime: item.ime,
            cena: item.cena,
        }));
        poeni = poeni - item.cena
        $('#poeni-org').text(poeni)
    })
}

function napraviclanove(item) {
    var grade = item.grade
    $("#lista-radnika").append(`
        <div>
            <p>`+ item.ime +`</p>
            <i class="fa-solid fa-user-plus" id="`+ item.identifier +`1"></i>
            <i class="fa-solid fa-user-xmark" id="`+ item.identifier +`2"></i>
            <i class="fa-solid fa-user-slash" id="`+ item.identifier +`3"></i>
        </div>
    `);

    $('#' + item.identifier + "1").click(function(){
        var newgrade = grade + 1
        if (grade < 3 && newgrade <= 3) {
            $.post('https://' + imeskripte + '/action', JSON.stringify({
                type: 'rankup',
                identifier: item.identifier,
                grade: newgrade,
            }));
            $("#lista-radnika").html('');
            $('#upravljanje-wrapper').fadeOut();
            $('#bossmenu-wrapper').fadeIn();
        }
    })
    $('#' + item.identifier + "2").click(function(){
        var newgrade = grade - 1
        if (grade > 0 && newgrade >= 0) {
            $.post('https://' + imeskripte + '/action', JSON.stringify({
                type: 'rankdown',
                identifier: item.identifier,
                grade: newgrade,
            }));
            $("#lista-radnika").html('');
            $('#upravljanje-wrapper').fadeOut();
            $('#bossmenu-wrapper').fadeIn();
        }
    })
    $('#' + item.identifier + "3").click(function(){
        $.post('https://' + imeskripte + '/action', JSON.stringify({
            type: 'otkaz',
            identifier: item.identifier,
        }));
        $("#lista-radnika").html('');
        $('#upravljanje-wrapper').fadeOut();
        $('#bossmenu-wrapper').fadeIn();
    })
}

function nabudziorg() {
    var novilvl = Number(level) + Number(1)
    if (level < 5 && novilvl <= 5) {
        $.post('https://' + imeskripte + '/action', JSON.stringify({
            type: 'levelup',
            level: novilvl,
            poeni: poeni,
        }));
    }
}

function gobacktomain() {
    $("#lista-igraca").html('');
    $("#lista-radnika").html('');
    $("#lista-vozila").html('');
    $('#bossmenu-wrapper').fadeIn();
    $('#upravljanje-wrapper').fadeOut();
    $('#zaposljavanje-wrapper').fadeOut();
    $('#salonorge-wrapper').fadeOut();
}

document.onkeyup = function (data) {
    if (data.which == 27) {
        $("#vehicle-wrapper").fadeOut();
        $("#vehicle-wrapper").html('');
        $("#lista-igraca").html('');
        $("#lista-radnika").html('');
        $("#lista-vozila").html('');
        $('#bossmenu-wrapper').fadeOut();
        $('#upravljanje-wrapper').fadeOut();
        $('#salonorge-wrapper').fadeOut();
        $('#zaposljavanje-wrapper').fadeOut();
        $.post('https://' + imeskripte + '/action', JSON.stringify({
            type: 'close',
        }));
    }
};