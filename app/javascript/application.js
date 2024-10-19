// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

//require("@rails/ujs").start()
//require("turbolinks").start()
//require("@rails/activestorage").start()
//require("jquery")

import "@hotwired/turbo-rails"
import "controllers"
import "search/calendar"
import "jquery"
import "semantic-ui"
// import "fomantic-ui/dist/semantic.min.css"
// import "fomantic-ui/dist/semantic.min.js"
//import "fomantic-ui-css/semantic.min.js"
//import "fomantic-ui-css/semantic.min.css"
//import $ from "jquery"

$(function() {
  console.log("Application.js OK")
})

// Indexページのタイトルモーダル表示
$(function () {
  $('.ui.modal').modal('show')
})

//初回読み込み、リロード、ページ切り替えでドロップダウンメニューを使えるようにする
$(document).on('turbolinks:load', function() {
  // show dropdown on hover
  $('.ui.dropdown').dropdown({
    on: 'hover'
  });
})

//fomantic-uiで開始日・終了日のカレンダー表示
$(document).on('turbolinks:load', function() {
  $('.ui.calendar').calendar({
    type: 'date',
    formatter: {
      date: function (date, settings) {
        if (!date) return '';
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);
        return year + '-' + month + '-' + day;
      }
    }
  });
});

//Semantic-uiのvalidation check
$('.ui.form').
  form({
    fields: {
      start_date: {
        rules: [
          {
            type: 'empty',
            prompt: '{開始日}が入力されていません'
          }
        ]  
      },
      end_date: {
        rules: [
          {
            type: 'empty',
            prompt: '{終了日}が入力されていません'
          }
        ]
      }
    }
  })
