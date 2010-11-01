class EntriesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def create
    if params[:preview]
      preview
    else
      hobo_create
    end
  end

  def preview
    e = Entry.new(params[:entry])
    e.format_text
    render :text => e.body
  end

  def update
    if params[:preview]
      preview
    else
      hobo_update
    end
  end

end
