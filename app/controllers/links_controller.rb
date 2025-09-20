# frozen_string_literal: true

class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.find_by(original_url: link_params[:original_url]) || Link.new(link_params)

    if @link.save
      respond_to do |format|
        format.html { redirect_to @link }
        format.json do
          render json: {
            data: {
              id: @link.id,
              original_url: @link.original_url,
              short_url: short_url(@link.short_code),
              short_code: @link.short_code,
              clicks: @link.clicks
            }
          }, status: :created
        end
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { error: @link.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def show
    @link = Link.find(params[:id])
    @short_url = short_url(@link.short_code)
  end

  private

  def short_url(short_code)
    Rails.application.routes.url_helpers.redirect_url(short_code: short_code,
                                                      host: Rails.application.config.default_url_host)
  end

  def link_params
    params.require(:link).permit(:original_url)
  end
end
