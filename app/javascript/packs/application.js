// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

document.addEventListener('DOMContentLoaded', () => {
  
  // コメント機能

  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('hidden')
    $('.comment-text-area').removeClass('hidden')
  })

  const dataset = $('#article-show').data()
  const articleId = dataset.articleId
  
  $('.add-comment-button').on('click', () => {
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/articles/${articleId}/comments`, {
        comment: {content: content}
      })
        .then((res) => {
          const comment = res.data
          $('.comments-container').append(
            `<div class="article_comment"><p>${comment.content}</p></div>`
          )
          $('#comment_content').val('')
        })
    }
  })
  
  axios.get(`/articles/${articleId}/comments`)
  .then((response) => {
    const comments = response.data
    comments.forEach((comment) => {
      $('.comments-container').append(
        `<div class="article_comment"><p>${comment.content}</p></div>`
      )
    })
  }) 

})
