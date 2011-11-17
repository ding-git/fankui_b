
function videoStateChanged(state)
{
  if(state == 3 || state == 1)
  {
    // Buffering, playing
	$("#slideshow").cycle("pause");
  }
  else if(state == 2)
  {
    // paused
	$("#slideshow").cycle("resume").cycle("next");
  } 
}

function onYouTubePlayerReady(playerId)
{
  var video = document.getElementById("featureVidPlayer");
  video.addEventListener("onStateChange", "videoStateChanged");
}


$(document).ready(function(){

  $("#slideshow").cycle({
    timeout: 12000,
    fx:'scrollLeft',
    
    pagerAnchorBuilder: function(idx, slide) {
      // return selector string for existing anchor
      return '#slideshow-nav a:eq(' + idx + ')';
    },
    after: function(currSlideElement, nextSlideElement, options, forwardFlag) {
      $("#slideshow-nav a").removeClass("activeSlide");
      $("#slideshow-nav a:eq(" + options.currSlide + ")").addClass("activeSlide");
      var slideClass = $(nextSlideElement).attr("class");
      if( $("#slideshow li." + slideClass + " span.video").length )
      {
         $('#slideshow').cycle('pause'); 
      }
      else{
      	$('#slideshow').cycle('resume');
      }
    }
  });
 });
