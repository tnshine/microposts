class RepostsController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.repost(@micropost)

    # 元のポストIDをownerカラムに保持し、新しいポストを投稿(リツイート)
    # contentは空白を許可していないので、ダミーを保存しておく
    # Todo: 元のポストが削除されたら、リツイートも削除したい(microposts_controllerのdestroyにコード追加？)
    current_user.microposts.create(owner: @micropost.id, content: "dummy data")
  end

  def destroy
    @micropost = Repost.find(params[:id]).micropost
    current_user.unrepost(@micropost)
  end

end
