class PagesController < ApplicationController
  def home
  end

  def docs
  end

  def presentations
  end

  def start
    render layout: false
  end
end
