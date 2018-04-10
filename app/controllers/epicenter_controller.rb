class EpicenterController < ApplicationController

before_action :authenticate_user!, except: [:show_user, :all_users]

def all_users
  @users = User.all 
end

def following
  @users = User.where(id: current_user.following)
end

def followers
  @users = []

  User.all.each do |user|
    if user.following.include?(current_user.id)
       @users.push(user)
        end
      end
  end

  def feed
  	@following_tweets = Tweet.where(user_id: current_user.following << current_user.id)
  end

  def show_user
  	@user = User.find(params[:id])
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
  end



  def now_following
  	current_user.following.push(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end

  def unfollow
  	current_user.following.delete(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end
end

