class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params) #空の箱を作る。
    if @comment.save 
      redirect_to prototype_path(@comment.prototype) #(@comment.prototype)は、URLの:idを示す。URLにidがあればそれを（　）に入れる。（）の中の「.」以降はアソシエーションで組まれたテーブルのレコードを取得。
    else
      @prototype = @comment.prototype #5行目と同じ。commentモデルとprototypeモデルのアソシエーション。
      @comments = @prototype.comments #5行目と同じ。commentモデルとprototypeモデルのアソシエーション。
      render "prototypes/show" #直前に記載した情報は残ったまま指定のページに戻る。
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
