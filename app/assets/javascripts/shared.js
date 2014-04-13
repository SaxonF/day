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
        animation: "slide",
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

    // Hover complete task

    $('.complete-circle').knob({
        min: '0',
        max: '100',
        readOnly: true,
        displayInput: false,
        release: function (v){
            if (v == 100) {
                this.$.parents('.timer').find('.complete-task').trigger('click');
            }
        }
    });
    //$('#circle').parent() is the new div that contains the input and the canvas
    var circValue = 0;
    $('.complete-circle').each(function(){//each .knob
        $(this).parent().hover(function(){
            console.log(this);
            $(this).find('.complete-circle').animate({//animate to data targetValue
                value: 100
            }, {
                duration: 1000,
                easing: 'swing',
                progress: function () {
                    $(this).val(Math.round(this.value)).trigger('change')
                    circValue = this.value
                }
            });
        }, function(){
            var $circle = $(this).find('.complete-circle');
            $circle.stop();
            $({ value: circValue }).animate(
            { value: 0 }, 
            {
                duration: 2000,
                easing: 'swing',
                progress: function() {
                    $circle.val(Math.round(this.value)).trigger('change');
                }
             });
        });
        
    });

});