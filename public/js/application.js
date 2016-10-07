$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  hoverListener();
  issueClickListener();
  issueSubmitListener();
  caseClickListener();
  caseSubmitListener();
  citationClickListener();
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
    $.ajax({
      method: "get",
      url: "/issues/new"
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
    method=$(this).attr("method");
    data=$(this).serialize();
    $.ajax({
      method: method,
      url: targetURL,
      data: data
    })
    .done(function(response){
      $("#issue-form").remove();
      $("#issue-button-list").append(response)
      $("#new-issue-link").show();
    })
    .fail(function(response){
      alert("Can't submit new issue form");
    })
    })
  }

var caseClickListener = function() {
  $( "#new-case-link").on("submit", function(event) {
    event.preventDefault();
    targetURL=$(this).attr("action");
    $.ajax({
      method: "get",
      url: targetURL
    })
    .done(function(response){
      $("#case-form-holder").append(response);
      $("#new-case-link").hide();
    })
    .fail(function(response){
      alert("Can't load new case form");
    })
  })
}

var caseSubmitListener = function() {
  $( "case-form-holder").on("submit", "#case-form", function(event) {
    event.preventDefault();
    targetURL=$(this).attr("action");
    method=$(this).attr("method");
    data=$(this).serialize();
    $.ajax({
      method: method,
      url: targetURL,
      data: data
    })
    .done(function(response){
      $("#case-form").remove();
      $("#case-button-list").append(response)
      $("#new-case-link").show();
    })
    .fail(function(response){
      alert("Can't submit new case form");
    })
  })
}


var citationClickListener = function() {
  $( ".citations").on("submit", function(event) {
    event.preventDefault();
    targetURL=$(this).attr("action");
    $("#citations-container").empty();
    $("#citations-container").append("<div class='loader'></div>");
    $.ajax({
      method: "post",
      url: targetURL
    })
    .done(function(response){
      $("#citations-container").empty();
      $("#citations-container").append(response);
    })
    .fail(function(response){
      alert("Can't load new case form");
    })
  })
}