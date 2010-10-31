class EntriesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def update
    if params[:preview]
      e = Entry.new(params[:entry])
      e.format_text
      render :text => e.body
    else
      hobo_update
    end
  end

end
