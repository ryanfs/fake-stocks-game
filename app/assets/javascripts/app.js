$( document ).ready(function() {
  $('#buy').on('click', function(event) {
    event.preventDefault();
    $('#make_trade_buy').toggle();
  })

  $('#sell').on('click', function(event) {
    event.preventDefault();
    $('#make_trade_sell').toggle();
  })
});
