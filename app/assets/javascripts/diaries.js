function test() {
  console.log('test');
}

test();

$(window).on('load', function(){
  liff.init(function (data) {
    var userId = data.context.userId;
    window.alert(userId);
  }, function(error) {
    window.alert(error);
  });
});

