import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

document.addEventListener('DOMContentLoaded', () => {
  
  // コメント機能

  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('hidden')
    $('.comment-text-area').removeClass('hidden')
  })

  const dataset = $('#article-show').data()
  const articleId = dataset.articleId

  axios.get(`/articles/${articleId}/comments`)
  .then((response) => {
    const comments = response.data
    comments.forEach((comment) => {
      $('.comments-container').append(
        `<div class="article_comment"><p>${comment.content}</p></div>`
      )
    })
  }) 

  //いいね機能
  $(function(){
    $(`.inactive-heart`).on('click', function() {
      const articleId = $(this).attr('id')
      axios.post(`/articles/${articleId}/like`)
        .then((response) => {
          if (response.data.status === 'ok') {
            $(this).addClass('hidden')
            $(`#${articleId}.active-heart`).removeClass('hidden')
          }
        })
        .catch((e) => {
          window.alert('Error')
          console.log(e)
        })
    })
  })

  $(function(){
    $(`.active-heart`).on('click', function() {
      const articleId = $(this).attr('id')
      axios.delete(`/articles/${articleId}/like`)
        .then((response) => {
          if (response.data.status === 'ok') {
            $(`#${articleId}.inactive-heart`).removeClass('hidden')
            $(this).addClass('hidden')
          }
        })
        .catch((e) => {
          window.alert('Error')
          console.log(e)
        })
    })
  })

})

// const hand$('leHeartDisplay = (hasLiked) => {
//   if (hasLiked) {
//     $('.active-heart').removeClass('hidden')
//   } else {
//     $('.inactive-heart').removeClass('hidden')
//   }
// }

// document.addEventListener('DOMContentLoaded', () => {
//   const dataset = $('#card-show[id]').data()
//   const articleId = dataset.articleId
//   axios.get(`/articles/${articleId}/like`)
//     .then((response) =>  {
//       const hasLiked = response.data.hasLiked
//       handleHeartDisplay(hasLiked)
//     })

//     $('.inactive-heart').on('click', () => {
//       const likeId = $(this).attr('id')
//       axios.post(`/articles/${likeId}/like`)
//       .then((response) => {
//         if (response.data.status === 'ok') {
//           $(`#${likeId}.active-heart`).removeClass('hidden')
//           $(`#${likeId}.inactive-heart`).addClass('hidden')
//         }
//       })
//       .catch((e) => {
//         window.alert('Error')
//         console.log(e)
//       })
//     })

//     $('.active-heart').on('click', () => {
//       const likeId = $(this).attr('id')
//       axios.delete(`/articles/${likeId}/like`)
//       .then((response) => {
//         if (response.data.status === 'ok') {
//           $(`#${likeId}.active-heart`).addClass('hidden')
//           $(`#${likeId}.inactive-heart`).removeClass('hidden')
//         }
//       })
//       .catch((e) => {
//         window.alert('Error')
//         console.log(e)
//       })
//     })
// })