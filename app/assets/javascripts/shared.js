$(function(){


    var now = new Date(),
        endofday = new Date();

        endofday.setHours(17,0,0);
        timeLeft = endofday.getTime() - now.getTime();

    $('#countdown').runner({
        autostart: true,
        countdown: true,
        startAt: timeLeft,
        milliseconds: false,
    });


    // setup our task slider

    var index = 0, hash = window.location.hash;

    if (hash) {
        index = /\d+/.exec(hash)[0];
        index = (parseInt(index) || 1) - 1;
    }

    $(".cover-tasks").flexslider({
        directionNav: false,
        slideshow: false,
        startAt: index,
        before: function(slider){
            $timer = $($(slider).find('li')[slider.currentSlide]);
            if (!$timer.is(".closed")){
                $timer.find('.timespent').runner('stop');
            }
        },
        after: function(slider){
            window.location.hash = slider.currentSlide+1;
            $timer = $($(slider).find('li')[slider.currentSlide]);
            if (!$timer.is(".closed")){
                $timer.find('.timespent').runner('start');
            }
        }
    });

    //complete task link

    $(".complete-task").bind("ajax:success", function(evt, data, status, xhr){
        $task = $(this).parents('li.task');
        $task.addClass("closed");
        $task.find('.timespent').runner('stop');
    });

    $(".open-task").bind("ajax:success", function(evt, data, status, xhr){
        $task = $(this).parents('li.task');
        $task.removeClass("closed");
        $task.find('.timespent').runner('start');
    });

});