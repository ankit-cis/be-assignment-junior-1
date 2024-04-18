// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import jQuery from 'jquery';
window.$ = jQuery
window.jQuery = jQuery

import 'bootstrap/dist/js/bootstrap'
require("jgrowl")
Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).on('click', '#add-friend-link', function(e) {
  e.preventDefault();
  $.ajax({
    url: '/add_friend',
    method: 'GET',
    success: function(response) {
      $('#add-friends-section').append('<div class="add-friend-form-container">' + response + '</div>');
    }
  });
});

$(document).on('click', '.remove-friend-form', function(e) {
  e.preventDefault();
  $(this).closest('.add-friend-form-container').remove();
});

$(document).on('click', '#pay_to_friend', function() {
  var friendId = $(this).data('friend-id');
  var friend_name = $(this).data('friend-name');
  var friend_amount = $(this).data('friend-amount');

  $('#friend-id-field').val(friendId);
  $('.friend_name').text("Friend's name: " + friend_name);
  $('.friend_amount').text("Total Amount to pay: " + friend_amount);
  $('#amount').attr('max', friend_amount);
  $('#amount').val(friend_amount);
})
