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

//= require jquery

//= require rails-ujs
//= require activestorage
//= require_tree .
/*global $*/


// 写真複数枚のスライド
$(function() {
  $('#slider').slick({
      dots: true, //スライドの下にドットのナビゲーションを表示
      autoplay: true, //自動再生
      autoplaySpeed: 4000, //再生スピード
  })
});




// $(document).on('ready', function() {
//   $(".full").slick({
//     arrows: false,
//     dots: true,
//     autoplay: true,
//     autoplaySpeed: 1500,
//     speed: 1500,
//     fade: true,
//     pauseOnFocus: false,
//     pauseOnHover: false,
//     pauseOnDotsHover: false,
//   });
// });








