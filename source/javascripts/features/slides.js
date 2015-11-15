(function() {

  window.pageReady(function() {
    var $slideshow = $('[data-slides]');

    $slideshow.slick({
      slide: 'li',
      dots: true,
      infinite: true,
      speed: 400,
      slidesToShow: 1,
      centerMode: true,
      fade: false,
      arrows: false,
      draggable: true,
      autoplay: false,
      autoplaySpeed: 3000,
      variableWidth: true
    });

    $slideshow.slickLightbox({
      background: 'rgba(0,0,0)',
      src: 'src',
      itemSelector: 'li img'
    });
  });
})();
