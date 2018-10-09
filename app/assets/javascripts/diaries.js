function send(text) {
  liff.getProfile().then(function (profile) {
    liff.sendMessages([
      {
        type: 'text',
        text: text,
      }
    ]).then(function () {
      liff.closeWindow();
    }).catch(function (error) {
      window.alert('Error sending message: ' + error.message);
    });
  }).catch(function (error) {
    window.alert("Error getting profile: " + error.message);
  });
}

$(window).on('load', function(){
  if (navigator.userAgent.indexOf("Line") !== -1) {
    liff.init(function (data) {
      var userId = data.context.userId;
      initCalendar(userId);
    }, function(error) {
      window.alert(error);
    });
  } else {
    initCalendar('');
  }
});


function initCalendar(userId) {

  var element = document.getElementById("my-calendar");
  var myCalendar = new jsCalendar();
  var date = new Date();
  var options = {
    monthFormat: 'month YYYY'
  };
  myCalendar._construct([element, date, options ]);

  $('.jsCalendar-current').removeClass('jsCalendar-current');

  getDiaries(userId, date);

  myCalendar.onDateClick(function(event, date){
    text = '閲覧:' + date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
    send(text);
  });

  myCalendar.onMonthChange(function(event, date){
    getDiaries(userId, date);
  });
};

function getDiaries(userId, date) {
  var data = {
    year: date.getFullYear(),
    month: date.getMonth() + 1,
  };

  if (userId != null || userId !== '') {
    data.userId = userId;
  }

  $.ajax({
    url: '/calendar.json',
    data: data,
    success: displayDiaryColor,
    error: function(request, status, error) {
      console.error('error');
    },
  });
}

function displayDiaryColor(diaries, dataType) {
  var dateElements = $('#my-calendar td').not('.jsCalendar-next').not('.jsCalendar-previous');

  diaries.forEach(function(diary) {
    var createdAt = new Date(diary.created_at)
    var scale = Math.abs(diary.negaposi)
    var size = 24 + scale * 4
    var marginVertical = 1 + (3 - scale) * 2;
    var marginHorizontal = 2 + (3 - scale) * 2;

    if (diary.negaposi > 0.5) {
      var element = $(dateElements[createdAt.getDate() - 1])
        .addClass('positive')
        .css('width',  size + 'px')
        .css('height',  size + 'px')
        .css('line-height',  size + 'px')
        .css('margin', marginVertical + 'px ' + marginHorizontal + 'px');
    } else if (diary.negaposi < -0.5) {
      $(dateElements[createdAt.getDate() - 1])
        .addClass('negative')
        .css('width',  size + 'px')
        .css('height',  size + 'px')
        .css('line-height',  size + 'px')
        .css('margin', marginVertical + 'px ' + marginHorizontal + 'px');
    } else {
      $(dateElements[createdAt.getDate() - 1])
        .css('width', '24px')
        .css('height', '24px')
        .css('line-height',  '24px')
        .css('border-radius', '50%')
        .css('border', '1px solid #666');
    }
  });
}
