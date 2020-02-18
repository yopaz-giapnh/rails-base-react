# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @posts = [
      {
        id: 1,
        title: "Title1",
        body: "Body1"
      },
      {
        id: 2,
        title: "Title2",
        body: "Body3"
      },
      {
        id: 3,
        title: "Title4",
        body: "Body4"
      },
      {
        id: 4,
        title: "Title5",
        body: "Body5"
      },
    ]
    render component: "PostList", props: { posts: @posts }
  end

  def welcome
  end
end
