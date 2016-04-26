$( document ).ready(function() {
  $('#buy-header').on('click', function(event) {
    event.preventDefault();
    $('#make_trade_buy').toggle();
    $('.ion-android-share-alt').toggle();
  });

  $('.leaderboard').on('click', function(event) {
    event.preventDefault();
    jQuery(this).next("div").toggle();
  });

  $('.ion-android-share-alt').on('click', function(event) {
    event.preventDefault();
    $('#make_trade_buy').toggle();
    $('.ion-android-share-alt').toggle();
  });


  $('#sell').on('click', function(event) {
    event.preventDefault();
    $('#make_trade_sell').toggle();
    $('#my-portfolio').toggle();
  });

  $('#cancel-sale').on('click', function(event) {
    event.preventDefault();
    $('#make_trade_sell').toggle();
    $('#my-portfolio').toggle();
  });


  var showStocks = function() {
    $.ajax({
      type: 'GET',
      url: '/stocks',
      success: function() {
        console.log('this worked');
        $(this).addClass('done');
      }
    })
  }

  $('#show-stocks').on('click', function(event) {
  event.preventDefault();
  showStocks();
  })

});
