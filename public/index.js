$("#calendar").fullCalendar({
  header: {
    left: 'title',
    center: '',
    right: 'today prev,next'
  },
  dayClick: dayClick,
  events: getEvents
})

function getEvents(start, end, done) {
  console.log('getEvents', start, end);
  var events = [];
  // for days between start end, collect files
  var today = start;
  while (today < end) {
    var rec = getVideoRecord(today);
    if (rec)
      events.push({date: today, title: 'vid'});
    today = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);
  }
  done(events);
}

function getVideoRecord(date) {
  var key = $.fullCalendar.formatDate(date, "yyyy/MM/dd");
  return _videoDB[key];
}

function dayClick(date, allday, e, view) {
  var file = getVideoRecord(date).file;

  _V_('video-player').ready(function(){ 
    var player = this;
    
    // change track to day clicked
    player.src({type: 'video/mp4', src: file});

    // start video
    player.play() 
  });

  $('#video-title').text(file);
}
