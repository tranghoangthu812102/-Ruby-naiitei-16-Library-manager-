$(function() {
  document.addEventListener("turbolinks:load", function() {
    $('.ohstar').raty({
      path: '/assets',
      size: 36,
      starOff:  'star-off.png',
      starOn : 'star-on.png',
      starHalf: 'star-half.png',
      half: true,
      readOnly: true,
      score: function(){
        return $(this).attr('data-rate');
      },
    });
  });
})
