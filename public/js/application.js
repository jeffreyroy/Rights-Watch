$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  hoverListener();
  issueClickListener();
});


var hoverListener = function() {
  var oldWidth;
	$( ".justice-image" ).hover(
  function() {
    oldWidth = $( this ).css( "width" );
    $( this ).css( "width", "150px" );
    $( this ).parent().find(".justice-name").show()

  }, function() {
    $( this ).css( "width", oldWidth );
    $( this ).parent().find(".justice-name").hide()
  }
	);
}

var issueClickListener = function() {
  $( "#new-issue-link").on("click", function(event) {
    event.preventDefault();
    targetURL=$(this).attr("href");
    $.ajax({
      method: "get",
      url: targetURL
    })
    .done(function(response){
      $("#issue-form-holder").append(response);
      $("#new-issue-link").hide();
    })
    .fail(function(response){
      alert("Can't load new issue form");
    })
    })
  }

  var issueSubmitListener = function() {
  $( "issue-form-holder").on("submit", "#issue-form", function(event) {
    event.preventDefault();
    targetURL=$(this).attr("action");
    $.ajax({
      method: "get",
      url: targetURL
    })
    .done(function(response){
      $("#issue-form-").hide();
      $("#new-issue-link").show();
    })
    .fail(function(response){
      alert("Can't submit new issue form");
    })
    })
  }
