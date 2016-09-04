$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  hoverListener();
});


var hoverListener = function() {
  var oldWidth;
	$( ".justice-image" ).hover(
  function() {
    oldWidth = $( this ).css( "width" );
    $( this ).css( "width", "150px" );
  }, function() {
    $( this ).css( "width", oldWidth );
  }
	);
}
