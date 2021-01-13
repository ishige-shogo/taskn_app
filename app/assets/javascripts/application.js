// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage

//= require_tree .
//= require chartkick
//= require Chart.bundle
/*global $*/


//利用者アイコン画像のプレビュー機能
$(function(){
  function readURL(input) {
    if(input.files && input.files[0]){
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      };
      reader.readAsDataURL(input.files[0]);
    }
  }
  $('#user_image').change(function(){
    readURL(this);
  });
});


//ページが浮かび上がる機能
function showElementAnimation() {
  var element = document.getElementsByClassName('js-animation');
  if(!element) return;
  var scrollY = window.pageYOffset;
  var windowH = window.innerHeight;
  for(var i=0;i<element.length;i++) { var elemClientRect = element[i].getBoundingClientRect(); var elemY = scrollY + elemClientRect.top; if(scrollY + windowH  > elemY) {
      element[i].classList.add('is-show');
    }
  }
}
showElementAnimation();
window.addEventListener('scroll', showElementAnimation);


//画像スライダー機能(slick)
$(function() {
    $('.home_top_merit').slick({
        dots: true,
    });
});
