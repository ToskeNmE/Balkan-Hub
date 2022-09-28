window.addEventListener('message', function(event) {
    if (event.data.type == "openregister") {
        if (event.data.value) {
            document.body.style.display = "block";
        } else {
            document.body.style.display = "none";
        }
    }
});

function checkName() {
    var lastname = $('#name-input').val();

    if (isNaN(lastname) && lastname.length > 2) {
        document.getElementById('name-input').style.backgroundColor = '#9cbf8e';
        document.getElementById('name-input').style.color = 'black';
    } else {
        document.getElementById('name-input').style.backgroundColor = '#ff5c5c';
        document.getElementById('name-input').style.color = '#c6c6c6';
    }
    kurac = lastname.charAt(0).toUpperCase() + lastname.slice(1);
    $('#name-input').val(kurac)
}

function checkLastName() {
    var lastname = $('#lastname-input').val();

    if (isNaN(lastname) && lastname.length > 2) {
        document.getElementById('lastname-input').style.backgroundColor = '#9cbf8e';
        document.getElementById('lastname-input').style.color = 'black';
    } else {
        document.getElementById('lastname-input').style.backgroundColor = '#ff5c5c';
        document.getElementById('lastname-input').style.color = '#c6c6c6';
    }
    kurac = lastname.charAt(0).toUpperCase() + lastname.slice(1);
    $('#lastname-input').val(kurac)
}


function checkDOB() {
    var date = new Date($('#dateofbirth-input').val());
    day = date.getDate();
    month = date.getMonth() + 1;
    year = date.getFullYear();
    if (isNaN(month) || isNaN(day) || isNaN(year)) {
        document.getElementById('dateofbirth-input').style.backgroundColor = '#ff5c5c';
        document.getElementById('dateofbirth-input').style.color = '#c6c6c6';
    }
    else {
        var dateInput = [month, day, year].join('/');

        var regExp = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
        var dateArray = dateInput.match(regExp);

        if (dateArray == null){
            return false;
        }

        month = dateArray[1];
        day= dateArray[3];
        year = dateArray[5];        

        if (month < 1 || month > 12){
            document.getElementById('dateofbirth-input').style.backgroundColor = '#ff5c5c';
            document.getElementById('dateofbirth-input').style.color = 'black';
        }
        else if (day < 1 || day> 31) { 
            document.getElementById('dateofbirth-input').style.backgroundColor = '#ff5c5c';
            document.getElementById('dateofbirth-input').style.color = 'black';
        }
        else if ((month==4 || month==6 || month==9 || month==11) && day ==31) {
            document.getElementById('dateofbirth-input').style.backgroundColor = '#ff5c5c';
            document.getElementById('dateofbirth-input').style.color = 'black';
        }
        else if (month == 2) {
            var isLeapYear = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
            if (day> 29 || (day ==29 && !isLeapYear)){
                document.getElementById('dateofbirth-input').style.backgroundColor = '#ff5c5c';
                document.getElementById('dateofbirth-input').style.color = 'black';
            }
        }
        else if ( year <= 1900) {
            document.getElementById('dateofbirth-input').style.backgroundColor = '#ff5c5c';
            document.getElementById('dateofbirth-input').style.color = 'black';
        }
        else {
            document.getElementById('dateofbirth-input').style.backgroundColor = '#9cbf8e';
            document.getElementById('dateofbirth-input')  .style.color = 'black';	
        }				
    }
}

function checkHeight() {
    var height = $('#height-input').val();

    if (height < 150 || height > 190) {
        document.getElementById('height-input').style.backgroundColor = '#ff5c5c';
        document.getElementById('height-input').style.color = '#c6c6c6';
    } else {
        document.getElementById('height-input').style.backgroundColor = '#9cbf8e';
        document.getElementById('height-input').style.color = 'black';
    }
}

function register() {
    var dateCheck = new Date($("#dateofbirth-input").val());
    var sex = $("input[type='radio'][name='sex']:checked").val();
    var firstname = $("#name-input").val();
    var lastname = $("#lastname-input").val()
    var height = $("#height-input").val()

    if (dateCheck == "Invalid Date") {
        document.getElementById('dateofbirth-input').style.backgroundColor = '#ff5c5c';
        document.getElementById('dateofbirth-input').style.color = '#c6c6c6';
    }
    if (sex == 'undefined') {
    }
    if (firstname == '' && firstname.length < 2) {
        document.getElementById('name-input').style.backgroundColor = '#ff5c5c';
        document.getElementById('name-input').style.color = '#c6c6c6';
    }
    if (lastname == '' && firstname.length < 2) {
        document.getElementById('lastname-input').style.backgroundColor = '#ff5c5c';
        document.getElementById('lastname-input').style.color = '#c6c6c6';
    }
    if (height == '' || height > 190) {
        document.getElementById('height-input').style.backgroundColor = '#ff5c5c';
        document.getElementById('height-input').style.color = '#c6c6c6';
    }
    else {
        const ye = new Intl.DateTimeFormat('en', { year: 'numeric' }).format(dateCheck)
        const mo = new Intl.DateTimeFormat('en', { month: '2-digit' }).format(dateCheck)
        const da = new Intl.DateTimeFormat('en', { day: '2-digit' }).format(dateCheck)
        
        var formattedDate = `${mo}/${da}/${ye}`;

        $.post('https://hRegister/register', JSON.stringify({
            firstname: firstname,
            lastname: lastname,
            dateofbirth: formattedDate,
            sex: sex,
            height: height,
        }));

        document.body.style.display = "none";
    }
}