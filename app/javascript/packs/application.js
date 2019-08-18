require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'jquery'
import 'bootstrap'
import 'startbootstrap-sb-admin-2/js/sb-admin-2'

import '../src/stylesheets/application.scss'

import Chart from 'chart.js'
import ChartDataLabels from 'chartjs-plugin-datalabels';

require("trix")
require("@rails/actiontext")

document.addEventListener('turbolinks:load', () => {
  $('#sidebarToggle').click((e) => {
    $("body").toggleClass("sidebar-toggled");
    $(".sidebar").toggleClass("toggled");
    if ($(".sidebar").hasClass("toggled")) {
      $('.sidebar .collapse').collapse('hide');
    };
  })

  // Scroll to top button appear
  $(document).on('scroll', function() {
    var scrollDistance = $(this).scrollTop();
    if (scrollDistance > 100) {
      $('.scroll-to-top').fadeIn();
    } else {
      $('.scroll-to-top').fadeOut();
    }
  });

  // Smooth scrolling using jQuery easing
  // $('.scroll-to-top').click((e) => {
  //   $('html, body').animate({
  //     scrollTop: $("#page-top").offset().top
  //   }, 2000);
  // });
})
import "controllers"
