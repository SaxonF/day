$(function(){


    var note = $('#note'),
        ts = new Date(),
        overTime = false;

    ts.setHours(17,0,0,0);

    if((new Date()) > ts){
        ts = -ts;
        overTime = true;
    }

    $('#countdown').countdown({
        timestamp   : ts,
        callback    : function(days, hours, minutes, seconds){

            var message = "";

            message += days + " day" + ( days==1 ? '':'s' ) + ", ";
            message += hours + " hour" + ( hours==1 ? '':'s' ) + ", ";
            message += minutes + " minute" + ( minutes==1 ? '':'s' ) + " and ";
            message += seconds + " second" + ( seconds==1 ? '':'s' ) + " <br />";

            if(overTime){
                message += "left until the new year!";
            }
            else {
                message += "left to 10 days from now!";
            }

            note.html(message);
        }
    });

    $(".cover-tasks").flexslider({
        directionNav: false 
    });

});