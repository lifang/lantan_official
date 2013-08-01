#encoding: utf-8
class StoresController < ApplicationController  #门店控制器
  layout "frontdoor" #门店模板
  require 'rubygems'
  require 'net/http'
  require "uri"
  require 'openssl'
  require 'net/http/post/multipart'
  
  #门店首页
  def show
    @store = SStore.find_by_id(params[:id].to_i)
    all_products = SProduct.where(["store_id = ? and status = ?", params[:id].to_i, SProduct::STATUS[:NOMAL]])
    p_hash = all_products.group_by { |i| i.is_service } if all_products
    @products = p_hash[SProduct::IS_SERVICE_VALUE[:NO]].group_by { |p| p.types } if p_hash and p_hash[SProduct::IS_SERVICE_VALUE[:NO]]
    @services = p_hash[SProduct::IS_SERVICE_VALUE[:YES]].group_by { |s| s.types } if p_hash and p_hash[SProduct::IS_SERVICE_VALUE[:YES]]
  end

  #本方法需要挪
  def send_file
    path="#{Rails.root}/public/"
    dirs=["syncs_data","/#{Time.now.strftime("%Y-%m").to_s}","/#{Time.now.strftime("%Y-%m-%d").to_s}"]
    dirs.each_with_index {|dir,index| Dir.mkdir path+dirs[0..index].join unless File.directory? path+dirs[0..index].join }
    filename = params[:url].original_filename
    File.open(path+dirs.join("")+"/"+filename, "wb")  {|f|  f.write(params[:url].read) }
    render :text=>"success"
  end



end
