# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/search", under: "search"

pin "jquery", to: "https://code.jquery.com/jquery-3.1.1.min.js"
pin "semantic-ui", to: "https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"
