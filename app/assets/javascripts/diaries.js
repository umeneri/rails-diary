function send(text) {
  liff.getProfile().then(function (profile) {
    window.alert(profile);

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
  liff.init(function (data) {
    if (navigator.userAgent.indexOf("LINE") != -1){
      var userId = data.context.userId;
      window.alert(userId);
    }
  }, function(error) {
    if (navigator.userAgent.indexOf("LINE") != -1){
      window.alert(error);
    }
  });

  initCalendar();
});


function initCalendar() {
  var element = document.getElementById("my-calendar");
  var myCalendar = new jsCalendar();
  var date = new Date();
  var options = {
    monthFormat: 'month YYYY'
  };
  myCalendar._construct([element, date, options ]);

  getDiaries(date);

  myCalendar.onDateClick(function(event, date){
    inputA.value = date.toString();
    text = '閲覧:' + date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
    send(text);
  });

  myCalendar.onMonthChange(function(event, date){
    inputB.value = date.toString();
    console.log(date.getMonth());
    getDiaries(date);
  });
};

function getDiaries(date) {
  var dateElements = $('#my-calendar td').not('.jsCalendar-next').not('.jsCalendar-previous');

  $.ajax({
    url: '/calendar.json',
    data: {
      year: date.getFullYear(),
      month: date.getMonth() + 1,
    },
    success: function(diaries, dataType) {
      console.log('success');
      console.log(diaries);

      diaries.forEach(function(diary) {
        var createdAt = new Date(diary.created_at)

        console.log(diary);
        console.log(createdAt.getDate());

        var size = 24 + Math.abs(diary.negaposi) * 4

        if (diary.negaposi > 0) {
          $(dateElements[createdAt.getDate() - 1]).addClass('positive')
            .css('width',  size + 'px')
            .css('height',  size + 'px')
            .css('line-height',  size + 'px');
        } else if (diary.negaposi < 0) {
          $(dateElements[createdAt.getDate() - 1]).addClass('negative')
            .css('width',  size + 'px')
            .css('height',  size + 'px')
            .css('line-height',  size + 'px');
        }
      });
    },
    error: function(request, status, error) {
      console.log('error');
    },
  });
}
