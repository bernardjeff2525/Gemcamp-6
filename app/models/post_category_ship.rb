class PostCategoryShip < ApplicationRecord
  belongs_to :post
  belongs_to :category
end

post = Post.create(title: 'title 1', content: 'content 1')
post.categories << Category.create(name: 'lifestyle')

category = Category.create(name: 'comedy')
category.posts << Post.create(title: 'title 2', content: 'content 2')
category << post