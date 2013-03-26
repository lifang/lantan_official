#encoding: utf-8
class StoresController < ApplicationController  #门店控制器
  layout "frontdoor" #门店模板
  require 'rubygems'
  require 'net/http'
  require "uri"
  require 'openssl'
  require 'net/http/post/multipart'
  
  #首页,展示门店
  def show
    #当前门店
    @store = SStore.find_by_id(params[:id].to_i)
    #门店服务
    all_products = SProduct.find(:all, :conditions => ["store_id = ? ", params[:id].to_i])
    p_hash = all_products.group_by { |i| i.is_service } if all_products
    @products = p_hash[SProduct::IS_SERVICE_VALUE[:NO]].group_by { |p| p.types } if p_hash and p_hash[SProduct::IS_SERVICE_VALUE[:NO]]
    @services = p_hash[SProduct::IS_SERVICE_VALUE[:YES]].group_by { |s| s.types } if p_hash and p_hash[SProduct::IS_SERVICE_VALUE[:YES]]
  end


  def send_file
    puts "-----------------------------"
    puts params[:url]
    path="#{Rails.root}/public"
    dirs=["zip_dirs","/#{Time.now.strftime("%Y-%m").to_s}","/#{Time.now.strftime("%Y-%m-%d").to_s}"]
    dirs.each_with_index {|dir,index| Dir.mkdir path+dirs[0..index].join   unless File.directory? path+dirs[0..index].join }
    path="#{Rails.root}/public/"
    filename = params[:url].original_filename
    File.open(path+filename, "wb")  {|f|  f.write(params[:url].read) }
    render :text=>"success"
  end

end
