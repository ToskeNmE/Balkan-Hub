var windows = "deposit"
var scriptName = 'hBanka'
var charime
var kartica
var racuni = {}

window.addEventListener('message', function(event) {
    var item = event.data
    if (item.type == "openbank") {
        $("body").fadeIn(function() {
            racuni = {}
            $('#deposit').css("background-color", "orange");
            $('#withdraw').css("background-color", "rgba(0, 0, 0, 0.581)");
            $('#transfer').css("background-color", "rgba(0, 0, 0, 0.581)");
            $('#billing').css("background-color", "rgba(0, 0, 0, 0.581)");
            $('#deposit-wrapper').fadeIn();
            $("#withdraw-wrapper").hide()
            $("#transfer-wrapper").hide()
            $("#billing-wrapper").hide()
            charime = item.ime
            kartica = item.kartica
            $('#char-name').text(item.ime);
            $('#card-number').text(item.kartica);
            $('#balance-amount').text(item.banka + '$');
            $('#card-code-amount').text(item.cvdkod);
            $('#card-pin-amount').text(item.pin);
            if ( item.kartica != "**** **** ****") {
                $('#buy-creditcard').hide();
            } else {
                $('#buy-creditcard').show();
            }
            if ( item.pin != "****" ) {
                $('#buy-pin').hide();
            } else {
                $('#buy-pin').show();
            }
        });
    }
    if (item.type == "updatecardnumber") {
        $("#card-number").text(item.cardnumber)
        $("#card-code-amount").text(item.cvd)
        $('#buy-creditcard').fadeOut();
    }
    if (item.type == "updatepin") {
        $('#card-pin-amount').text(item.pin);
        $('#buy-pin').fadeOut();
    }
    if (item.type == "updatebalance") {
        $('#balance-amount').text(item.balance + '$');
    }
    if (item.type == "errornotify") {
        $('#error-notif').text(item.text)
        $('#error-notify').fadeIn(function() {
            setTimeout(function(){
                $('#error-notify').fadeOut(500)
            }, 1500)
    
            setTimeout(function(){
                $('#error-notify').css('display', 'none')
                $('#error-notif').text('')
            }, 2000)
        });
    }
    if (item.type == "successnotify") {
        $('#success-notif').text(item.text)
        $('#success-notify').fadeIn(function() {
            setTimeout(function(){
                $('#success-notify').fadeOut(500)
            }, 1500)
    
            setTimeout(function(){
                $('#success-notify').css('display', 'none')
                $('#success-notif').text('')
            }, 2000)
        });
    }
    if (item.type == "napravikazne") {
        napravikazne(item.data)
    }
    if (item.type == "removekazne") {
        $('#billing-list').html('')
    }
});

function cancel(type) {
    $('#' + type + '-amount').val('');
    $('#' + type + '-account').val('');
}

function openwrapper(type) {
    if (type == 'deposit') {
        windows = 'deposit'
        $('#deposit').css("background-color", "orange");
        $('#withdraw').css("background-color", "rgba(0, 0, 0, 0.581)");
        $('#transfer').css("background-color", "rgba(0, 0, 0, 0.581)");
        $('#billing').css("background-color", "rgba(0, 0, 0, 0.581)");
        if ($('#withdraw-wrapper').css("display") != 'none') {
            $("#withdraw-wrapper").fadeOut(function() {
                $('#deposit-wrapper').fadeIn();
            });
        } 
        if ($('#transfer-wrapper').css("display") != 'none') {
            $("#transfer-wrapper").fadeOut(function() {
                $('#deposit-wrapper').fadeIn();
            });
        } 
        if ($('#billing-wrapper').css("display") != 'none') {
            $("#billing-wrapper").fadeOut(function() {
                $('#deposit-wrapper').fadeIn();
            });
        }
    } else if (type == 'withdraw') {
        windows = 'withdraw'
        $('#deposit').css("background-color", "rgba(0, 0, 0, 0.581)");
        $('#withdraw').css("background-color", "orange");
        $('#transfer').css("background-color", "rgba(0, 0, 0, 0.581)");
        $('#billing').css("background-color", "rgba(0, 0, 0, 0.581)");
        if ($('#deposit-wrapper').css("display") != 'none') {
            $("#deposit-wrapper").fadeOut(function() {
                $('#withdraw-wrapper').fadeIn();
            });
        } 
        if ($('#transfer-wrapper').css("display") != 'none') {
            $("#transfer-wrapper").fadeOut(function() {
                $('#withdraw-wrapper').fadeIn();
            });
        } 
        if ($('#billing-wrapper').css("display") != 'none') {
            $("#billing-wrapper").fadeOut(function() {
                $('#withdraw-wrapper').fadeIn();
            });
        }
    } else if (type == 'transfer') {
        windows = 'transfer'
        $('#deposit').css("background-color", "rgba(0, 0, 0, 0.581)");
        $('#withdraw').css("background-color", "rgba(0, 0, 0, 0.581)");
        $('#transfer').css("background-color", "orange");
        $('#billing').css("background-color", "rgba(0, 0, 0, 0.581)");
        if ($('#deposit-wrapper').css("display") != 'none') {
            $("#deposit-wrapper").fadeOut(function() {
                $('#transfer-wrapper').fadeIn();
            });
        } 
        if ($('#withdraw-wrapper').css("display") != 'none') {
            $("#withdraw-wrapper").fadeOut(function() {
                $('#transfer-wrapper').fadeIn();
            });
        } 
        if ($('#billing-wrapper').css("display") != 'none') {
            $("#billing-wrapper").fadeOut(function() {
                $('#transfer-wrapper').fadeIn();
            });
        } 
    } else if (type == 'billing') {
        windows = 'billing'
        $('#billing-list').html('')
        $('#deposit').css("background-color", "rgba(0, 0, 0, 0.581)");
        $('#withdraw').css("background-color", "rgba(0, 0, 0, 0.581)");
        $('#transfer').css("background-color", "rgba(0, 0, 0, 0.581)");
        $('#billing').css("background-color", "orange");
        if ($('#deposit-wrapper').css("display") != 'none') {
            $("#deposit-wrapper").fadeOut(function() {
                $('#billing-wrapper').fadeIn();
            });
        } 
        if ($('#withdraw-wrapper').css("display") != 'none') {
            $("#withdraw-wrapper").fadeOut(function() {
                $('#billing-wrapper').fadeIn();
            });
        } 
        if ($('#transfer-wrapper').css("display") != 'none') {
            $("#transfer-wrapper").fadeOut(function() {
                $('#billing-wrapper').fadeIn();
            });
        } 
        napravikazne2()
    }
}

function napravikazne(item) {
    $("#billing-list").append(
        `<div id="billings">`+
            `<p>`+ item.label + ` <span>`+ item.cena +`$</span></p>`+
            `<button id="button-id`+ item.id +`" class="plati">PLATI</button>`+
        `</div>`
    );

    $('#button-id'+ item.id).click(function() {
        $.post('https://' + scriptName + '/action', JSON.stringify({
            type: 'platikaznu',
            id: item.id,
            cena: item.cena
        }));
    })
}

function napravikazne2() {
    $.post('https://' + scriptName + '/action', JSON.stringify({
        type: 'napravikazne',
    }));
}

window.onkeyup = function (event) {
    if (event.keyCode == 27) {
        $("body").fadeOut()
        $.post('https://' + scriptName + '/action', JSON.stringify({
            type: 'close',
        }));
        dialogclose();
        dialogclose2();
        $('#deposit-amount').val('')
        $('#withdraw-amount').val('')
        $('#transfer-amount').val('')
        $('#deposit-account').val('')
        $('#withdraw-account').val('')
        $('#transfer-account').val('')
        $('#billing-list').html('')
    }
}

function generatepin() {
    var pinval = $('#pin1').val()
    if (pinval != '') {
        if (pinval.length == 4) {
            dialogclose2()
            $.post('https://' + scriptName + '/action', JSON.stringify({
                type: 'createpin',
                pin: pinval
            }));
            //$('#card-pin-amount').text(pinval);
            //$('#buy-pin').fadeOut();
        } else {
            $('#errorce2').text('Moras upisati 4 broja')
        }
    } else {
        $('#errorce2').text('Moras zeljeni pin')
    }
}

function dialogbuy() {
    $('#generate-card').fadeIn();
    $('#header').css("filter", "blur(8px)");
    $('#body').css("filter", "blur(8px)");
    $('#buy-creditcard').css("filter", "blur(8px)");
    $('#buy-pin').css("filter", "blur(8px)");
    $('#name').text(charime)
} 

function dialogclose() {
    $('#generate-card').fadeOut();
    $('#header').css("filter", "none");
    $('#body').css("filter", "none");
    $('#buy-creditcard').css("filter", "none");
    $('#buy-pin').css("filter", "none");
    $('#number1').val('')
    $('#number2').val('')
    $('#cvd').val('')
    $('#errorce').text('')
}

function dialogclose2() {
    $('#generate-pin').fadeOut();
    $('#header').css("filter", "none");
    $('#body').css("filter", "none");
    $('#buy-creditcard').css("filter", "none");
    $('#buy-pin').css("filter", "none");
    $('#pin1').val('')
    $('#errorce2').text('')
}

function dialogpin() {
    $('#generate-pin').fadeIn();
    $('#header').css("filter", "blur(8px)");
    $('#body').css("filter", "blur(8px)");
    $('#buy-creditcard').css("filter", "blur(8px)");
    $('#buy-pin').css("filter", "blur(8px)");
}


function generatecard() {
    var number1val = $('#number1').val()
    var number2val = $('#number2').val()
    var cvdval = $('#cvd').val()
    if (number1val != '' ) {
        if (number1val.length == 4 ) {
            if (number2val != '' ) {
                if (number2val.length == 4 ) {
                    if (cvdval != '' ) {
                        if (cvdval.length == 3 ) {
                            dialogclose();
                            $.post('https://' + scriptName + '/action', JSON.stringify({
                                type: 'createcard',
                                cardnumber: '4062 ' +number1val + ' ' + number2val,
                                cvd: cvdval
                            }));
                            //$("#card-number").text('4062 ' +number1val + ' ' + number2val)
                            //$("#card-code-amount").text(cvdval)
                            //$('#buy-creditcard').fadeOut();
                        } else {
                            $('#errorce').text('Moras upisati 3 broja')
                        }
                    } else {
                        $('#errorce').text('Moras upisati cvd')
                    }
                } else {
                    $('#errorce').text('Moras upisati 4 broja')
                }
            } else {
                $('#errorce').text('Moras upisati drga 4 broja kartice')
            }
        } else {
            $('#errorce').text('Moras upisati 4 broja')
        }
    } else {
        $('#errorce').text('Moras upisati prva 4 broja kartice')
    }
}

function numOnly(id) {
    // Get the element by id
    var element = document.getElementById(id);
    // Use numbers only pattern, from 0 to 9 with \-
    var regex = /[^0-9\-]/gi;
    // Replace other characters that are not in regex pattern
    element.value = element.value.replace(regex, "");
}

function deposit() {
    var amount = $('#deposit-amount').val()
    var cardnumber = $('#deposit-account').val()
    if (amount != '') {
        if (cardnumber != '') {
            $.post('https://' + scriptName + '/action', JSON.stringify({
                type: 'deposit',
                kartica: cardnumber,
                iznos: amount
            }));
            $('#deposit-amount').val('')
        } else {
            $('#error-notif').text('Moras uneti broj kartice')
            $('#error-notify').fadeIn(function() {
                setTimeout(function(){
                    $('#error-notify').fadeOut(500)
                }, 1500)
        
                setTimeout(function(){
                    $('#error-notify').css('display', 'none')
                    $('#error-notif').text('')
                }, 2000)
            });
        }
    } else {
        $('#error-notif').text('Moras uneti iznos')
        $('#error-notify').fadeIn(function() {
            setTimeout(function(){
                $('#error-notify').fadeOut(500)
            }, 1500)
    
            setTimeout(function(){
                $('#error-notify').css('display', 'none')
                $('#error-notif').text('')
            }, 2000)
        });
    }
}

function withdraw() {
    var amount = $('#withdraw-amount').val()
    var cardnumber = $('#withdraw-account').val()
    if (amount != '') {
        if (cardnumber != '') {
            $.post('https://' + scriptName + '/action', JSON.stringify({
                type: 'withdraw',
                kartica: cardnumber,
                iznos: amount
            }));
            $('#withdraw-amount').val('')
        } else {
            $('#error-notif').text('Moras uneti broj kartice')
            $('#error-notify').fadeIn(function() {
                setTimeout(function(){
                    $('#error-notify').fadeOut(500)
                }, 1500)
        
                setTimeout(function(){
                    $('#error-notify').css('display', 'none')
                    $('#error-notif').text('')
                }, 2000)
            });
        }
    } else {
        $('#error-notif').text('Moras uneti iznos')
        $('#error-notify').fadeIn(function() {
            setTimeout(function(){
                $('#error-notify').fadeOut(500)
            }, 1500)
    
            setTimeout(function(){
                $('#error-notify').css('display', 'none')
                $('#error-notif').text('')
            }, 2000)
        });
    }
}

function transfer() {
    var amount = $('#transfer-amount').val()
    var cardnumber = $('#transfer-account').val()
    if (amount != '') {
        if (cardnumber != '') {
            $.post('https://' + scriptName + '/action', JSON.stringify({
                type: 'transfer',
                kartica: cardnumber,
                iznos: amount
            }));
            $('#transfer-amount').val('')
        } else {
            $('#error-notif').text('Moras uneti broj kartice')
            $('#error-notify').fadeIn(function() {
                setTimeout(function(){
                    $('#error-notify').fadeOut(500)
                }, 1500)
        
                setTimeout(function(){
                    $('#error-notify').css('display', 'none')
                    $('#error-notif').text('')
                }, 2000)
            });
        }
    } else {
        $('#error-notif').text('Moras uneti iznos')
        $('#error-notify').fadeIn(function() {
            setTimeout(function(){
                $('#error-notify').fadeOut(500)
            }, 1500)
    
            setTimeout(function(){
                $('#error-notify').css('display', 'none')
                $('#error-notif').text('')
            }, 2000)
        });
    }
}