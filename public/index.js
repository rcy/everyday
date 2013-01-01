// the event that corresponds with the currently playing video
var playingEvent = null;

$("#calendar").fullCalendar({
  header: {
    left: 'title',
    center: '',
    right: 'today prev,next'
  },
  eventClick: eventClick,
  events: getEvents,
})

function getEvents(start, end, done) {
  var events = [];

  // for days between start end, collect files
  var today = start;
  while (today < end) {
    var rec = getVideoRecord(today);
    if (rec)
      events.push({date: today, title: rec.duration, file: rec.file});
    today = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);
  }

  done(events);
}

function getVideoRecord(date) {
  var key = $.fullCalendar.formatDate(date, "yyyy/MM/dd");
  return _videoDB[key];
}

function eventClick(event, jsEvent, view){
  if (playingEvent) {
    playingEvent.backgroundColor = '';
    $("#calendar").fullCalendar('updateEvent', playingEvent);
  }

  playingEvent = event;
  playingEvent.backgroundColor = 'red';
  $("#calendar").fullCalendar('updateEvent', playingEvent);

  playVideo(event.start);
}

function playVideo(date) {
  var rec = getVideoRecord(date);

  _V_('video-player').ready(function(){ 
    var player = this;
    
    // change track to day clicked
    player.src({type: 'video/mp4', src: rec.file});

    // start video
    player.play() 
  });

  // update title with day of playing video
  $("#title .playing").text($.fullCalendar.formatDate(date, "dddd MMMM d, yyyy"));
}
