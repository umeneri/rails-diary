function test() {
  console.log('test');
  console.log(liff);

  liff.getProfile().then(function (profile) {
    window.alert(profile);

    liff.sendMessages([
      {
        type: 'text',
        text: 'From:' + profile.displayName
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
    var userId = data.context.userId;
    window.alert(userId);
  }, function(error) {
    window.alert(error);
  });

  initCalendar();
});


function initCalendar() {
  var element = document.getElementById("my-calendar");
  var myCalendar = new jsCalendar();
  myCalendar._construct([element]);
  console.log(myCalendar);

  var inputA = document.getElementById("my-input-a");
  var inputB = document.getElementById("my-input-b");

  myCalendar.onDateClick(function(event, date){
    inputA.value = date.toString();
  });

  myCalendar.onMonthChange(function(event, date){
    inputB.value = date.toString();
    console.log(date.getMonth());
  });
};

