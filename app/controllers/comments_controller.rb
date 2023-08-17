class CommentsController < ApplicationController
  before_action :set_post, only: [:create]

  def create
    @comment = @post.comments.create(comment_params)

    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: turbo_stream.replace(
          "post#{@post.id}comments",
          partial: "posts/post_comments",
          locals: {post: @post}
        )
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if(@comment.user == current_user)
      @comment.destroy
    end
  end

  private 
  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.permit(:body).merge(user: current_user)
  end
end