window.addEventListener("message", function (event) {
  var item = event.data;
  if (item.type == "ui") {
    if (item.status) {
      $("#container").show("fast");
    } else {
      $("#container").hide();
    }
  }
});

document.addEventListener("keydown", function (event) {
  if (event.key === "Escape") {
    $("#container").hide();
    $.post("https://hCarWash/izadji", JSON.stringify({}));
  }
});

$(".operi").click(function () {
  $("#container").slideUp("fast", function () {
    $.post("https://hCarWash/operi", JSON.stringify({}));
  });
});

function pranjeauta() {
  $.post("https://hCarWash/operi", JSON.stringify({}));
}
