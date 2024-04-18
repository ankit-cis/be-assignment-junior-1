# frozen_string_literal: true

class Bill < ApplicationRecord
  belongs_to :user
  belongs_to :expense
end
