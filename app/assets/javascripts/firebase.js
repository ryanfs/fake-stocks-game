// Create a callback which logs the current auth state
function authDataCallback(authData) {
  if (authData) {
    console.log("User " + authData.uid + " is logged in with " + authData.provider);
    console.log(authData);
  } else {
    console.log("User is logged out");
  }
}

// Register the callback to be fired every time auth state changes
var ref = new Firebase("https://realstocksfakemoney.firebaseio.com");
ref.onAuth(authDataCallback);

// register button
$( document ).ready(function() {
  $('#register').on('click', function(event) {
    var ref = new Firebase("https://realstocksfakemoney.firebaseio.com");
    ref.authWithOAuthPopup("google", function(error, authData) {
      if (error) {
        console.log("Login Failed!", error);
      } else {
        console.log("Authenticated successfully with payload:", authData);
      }
    });
  })
});