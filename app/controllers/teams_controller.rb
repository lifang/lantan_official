#encoding: utf-8
class TeamsController < ApplicationController
  layout 'frontdoor'
  def index
    @store = Store.find(params[:store_id])
    
    
  end
end
