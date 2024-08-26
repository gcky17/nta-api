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
