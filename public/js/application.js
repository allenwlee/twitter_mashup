$(document).ready(function() {
  var user = $("#username span").text();
  console.log(user);
  if ($("#hidden").attr('data-stale') === "true") //set back to true when finished
    $.ajax({
      method: "post",
      url: "/" + user + "/get_tweets",
      dataType: 'html'
    }).done(function(data){
      $('.container').append(data);
      $('img').remove();
    })

  });
