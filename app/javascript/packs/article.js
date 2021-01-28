import $ from 'jquery'
import axios from 'modules/axios'

document.addEventListener('DOMContentLoaded', () => {

  //いいね機能

  $(function(){
    $(`.inactive-heart`).on('click', function() {
      const articleId = $(this).attr('id')
      axios.post(`/api/articles/${articleId}/like`)
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
      axios.delete(`/api/articles/${articleId}/like`)
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
