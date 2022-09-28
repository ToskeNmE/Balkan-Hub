var imeskripte = "hAutosalon";
var primarnaboja = "bela";
var sekundarnaboja = "bela";

window.addEventListener("message", function (event) {
  var item = event.data;
  if (item.type == "openvehshop") {
    $("#body").fadeIn();
    $("#lista-vozila").show();
    napravivozila(item.data, item.maxspeed);
  }

  var interval = 1000;

  $("#levi-btn").mousedown(function () {
    interval = setInterval(() => {
      rotate("leva");
    }, 0);
  });

  $("#levi-btn").mouseup(function () {
    setTimeout(() => {
      clearInterval(interval);
    }, 0);
  });

  $("#desni-btn").mousedown(function () {
    interval = setInterval(() => {
      rotate("desna");
    }, 0);
  });

  $("#desni-btn").mouseup(function () {
    setTimeout(() => {
      clearInterval(interval);
    }, 0);
  });

  $("#close-btn").click(function () {
    $("#body").show();
    $("#preview").hide();
    $.post(
      "https://" + imeskripte + "/action",
      JSON.stringify({
        type: "closepreview",
      })
    );
    clearInterval(interval);
  });
});

function napravivozila(item, maxspeed) {
  $("#lista-vozila").append(
    `
    <div id="car-wrapper">
        <img src="https://balkan-hub.com/development/slike/autosalon/` +
      item.spawnkod +
      `.png">
        <div id="bottom-test" onclick="napraviopois('` +
      item.label +
      `', '` +
      item.cena +
      `', '` +
      maxspeed +
      `', '` +
      item.spawnkod +
      `')">
            <p>` +
      item.label +
      `</p>
        </div>
    </div>
    `
  );
}

function napraviopois(label, cena, maxspeed, spawnkod) {
  $("#lista-vozila").hide();
  $("#o-vozilu").fadeIn();
  $("#o-vozilu").append(
    `
        <img src="https://balkan-hub.com/development/slike/autosalon/` +
      spawnkod +
      `.png">
        <p id="carname">` +
      label +
      `</p>
        <p id="price">CENA : <span>` +
      cena +
      `$</span></p>
        <p id="max-speed">MAX SPEED : <span>` +
      maxspeed +
      `KM/H</span></p>
        <p id="fuel-level">GORIVO : <span>100%</span></p>
        <p id="prim-color">PRIMARNA BOJA </p>
        <div id="prim-color-paleta">
            <div id="krug" onclick="primarna('ljubicasta')" class="ljubicasta"></div>
            <div id="krug" onclick="primarna('zelena')" class="zelena"></div>
            <div id="krug" onclick="primarna('plava')" class="plava"></div>
            <div id="krug" onclick="primarna('roze')" class="roze"></div>
            <div id="krug" onclick="primarna('narandzasta')" class="narandzasta"></div>
            <div id="krug" onclick="primarna('bela')" class="bela"></div>
            <div id="krug" onclick="primarna('crna')" class="crna"></div>
        </div>
        <p id="sec-color">SEKUNDARNA BOJA </p>
        <div id="sec-color-paleta">
            <div id="krug" onclick="sekundarna('ljubicasta')" class="ljubicasta"></div>
            <div id="krug" onclick="sekundarna('zelena')" class="zelena"></div>
            <div id="krug" onclick="sekundarna('plava')" class="plava"></div>
            <div id="krug" onclick="sekundarna('roze')" class="roze"></div>
            <div id="krug" onclick="sekundarna('narandzasta')" class="narandzasta"></div>
            <div id="krug" onclick="sekundarna('bela')" class="bela"></div>
            <div id="krug" onclick="sekundarna('crna')" class="crna"></div>
        </div>
        <button onclick="kupivozilo('` +
      label +
      `','` +
      cena +
      `','` +
      spawnkod +
      `')">KUPI VOZILO</button>
        <i class="fa-solid fa-eye" onclick="preview('` +
      spawnkod +
      `')"></i>
        <i class="fa-solid fa-arrow-left-long" onclick="backtomain()"></i>
    `
  );
}

function kupivozilo(label, cena, spawnkod) {
  $.post(
    "https://" + imeskripte + "/action",
    JSON.stringify({
      type: "kupivozilo",
      label: label,
      cena: cena,
      spawnkod: spawnkod,
      primarnaboja: primarnaboja,
      sekundarnaboja: sekundarnaboja,
    })
  );
  $("#body").fadeOut();
  $("#lista-vozila").html("");
  $("#o-vozilu").fadeOut();
  $("#o-vozilu").html("");
  $.post(
    "https://" + imeskripte + "/action",
    JSON.stringify({
      type: "close",
    })
  );
}

function primarna(boja) {
  primarnaboja = boja;
}

function sekundarna(boja) {
  sekundarnaboja = boja;
}

function backtomain() {
  $("#o-vozilu").hide();
  $("#o-vozilu").html("");
  $("#lista-vozila").fadeIn();
}

function rotate(strana) {
  $.post(
    "https://" + imeskripte + "/action",
    JSON.stringify({
      type: "rotacijavozila",
      rotacija: strana,
    })
  );
}

function preview(spawnkod) {
  $("#body").hide();
  $("#preview").fadeIn();
  $.post(
    "https://" + imeskripte + "/action",
    JSON.stringify({
      type: "preview",
      primcolor: primarnaboja,
      seccolor: sekundarnaboja,
      spawnkod: spawnkod,
    })
  );
}

document.onkeyup = function (data) {
  if (data.which == 27) {
    primarnaboja = "bela";
    sekundarnaboja = "bela";
    $("#body").fadeOut();
    $("#lista-vozila").html("");
    $("#o-vozilu").fadeOut();
    $("#o-vozilu").html("");
    $.post(
      "https://" + imeskripte + "/action",
      JSON.stringify({
        type: "close",
      })
    );
  }
};
