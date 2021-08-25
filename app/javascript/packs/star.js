$(function() {
  document.addEventListener("turbolinks:load", function() {
    $('#star').raty({
      path: '/assets',
      size: 36,
      starOff:  'star-off.png',
      starOn : 'star-on.png',
      starHalf: 'star-half.png',
      scoreName: 'review[rate]',
      half: true,
     });
  });
})
