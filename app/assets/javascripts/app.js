$( document ).ready(function() {
  $('#buy-header').on('click', function(event) {
    event.preventDefault();
    $('#make_trade_buy').toggle();
    $('.ion-android-share-alt').toggle();
  });

  $('.ion-android-share-alt').on('click', function(event) {
    event.preventDefault();
    $('#make_trade_buy').toggle();
    $('.ion-android-share-alt').toggle();
  });


  $('#sell').on('click', function(event) {
    event.preventDefault();
    $('#make_trade_sell').toggle();
  })

});
