$(function () {
  function display(bool) {
    if (bool) {
      $("body").show();
      $("#igor").show();
    } else {
      $("body").hide();
      $("#igor").hide();
    }
  }

  display(false);

  window.addEventListener("message", function (event) {
    var item = event.data;

    if (item.type === "ui") {
      if (item.status == true) {
        display(true);
      } else {
        display(false);
      }
    }

    igorCoords(event.data);
    igornormalCoords(event.data);
    igornvector3Coords(event.data);
  });
});

function igorClose() {
  $.post("http://hKordinate/igorcloseButton");
}

function igorCopy() {
  const copyText = document.getElementById("igorCoords").textContent;
  const textArea = document.createElement("textarea");
  textArea.textContent = copyText;
  document.body.append(textArea);
  textArea.select();
  document.execCommand("copy");
}

function igornormalCopy() {
  const copyText = document.getElementById("igornormalCoords").textContent;
  const textArea = document.createElement("textarea");
  textArea.textContent = copyText;
  document.body.append(textArea);
  textArea.select();
  document.execCommand("copy");
}

function igorvector3Copy() {
  const copyText = document.getElementById("igorvector3Coords").textContent;
  const textArea = document.createElement("textarea");
  textArea.textContent = copyText;
  document.body.append(textArea);
  textArea.select();
  document.execCommand("copy");
}

function igorCoords(data) {
  if (data.type === "igor") {
    igorcoordsStart(data);
  }
}

function igornormalCoords(data) {
  if (data.type === "normal") {
    igorcoordsnormalStart(data);
  }
}

function igornvector3Coords(data) {
  if (data.type === "vector3") {
    igorcoordsvector3Start(data);
  }
}

function igorcoordsStart(data) {
  document.querySelector("#igorCoords").textContent = data.text;
}

function igorcoordsnormalStart(data) {
  document.querySelector("#igornormalCoords").textContent = data.text;
}

function igorcoordsvector3Start(data) {
  document.querySelector("#igorvector3Coords").textContent = data.text;
}
