class CommentsController < ApplicationController

  hobo_model_controller

  auto_actions :destroy
  auto_actions_for :entry, [:create]

  def create_for_entry
    # Remove user spoofing
    # Hobo should make this easier
    params["comment"].delete("user_id")
    params["comment"]["posted_from_ip"] = request.remote_ip
    hobo_create
  end
end
