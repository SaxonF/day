$(function() {
	$('.timer .timespent').each(function(key){
		var $timer = $(this);
		var timerId;
		$(this).runner({
		    autostart: false,
		    countdown: false,
		    milliseconds: false,
		    taskID: $(this).data('id'),
		    startAt: $(this).data('time-spent')
		}).on('runnerStart', function(eventObject, info){
			saveTimer($timer);
			timerId = window.setInterval(function() {
				saveTimer($timer);
			}, 10000);
		}).on('runnerStop', function(eventObject, info){
			saveTimer($timer);
			window.clearInterval(timerId);
		});
	});

	var $activeTask = $('li.task.flex-active-slide');
	if (!$activeTask.is('.closed')){
		$activeTask.find('.timespent').runner('start');
	}
});	

function saveTimer(timer){
	$.ajax({
		type:'PATCH', 
		dataType: "json",
		url: timer.data('user') + '/tasks/' + timer.data('id') + '/update_time_spent', 
		data: {total: timer.runner('info').time}
	});
}