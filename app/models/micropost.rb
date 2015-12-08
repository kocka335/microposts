class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true # presence 値が存在すれば検証成功
  validates :content, presence: true, length: { maximum: 140 }
end
