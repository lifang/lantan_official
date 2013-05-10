#encoding: utf-8
class Customer < ActiveRecord::Base
  set_table_name :"lantan_db_all.customers"
  set_primary_key "id"
  attr_accessible :username, :name, :mobilephone, :address, :status, :types, :password,:is_vip
  has_many :customer_num_relations
  has_many :c_svc_relations
  has_many :c_pcard_relations

  STATUS = {:NOMAL => 0, :DELETED => 1} #0 正常  1 删除
  TYPES = {:GOOD => 0, :NORMAL => 1, :STRESS => 2} #1 优质客户  2 一般客户  3 重点客户
  IS_VIP = {:NORMAL => 0, :VIP => 1} #0 常态客户 1 会员卡客户
  attr_accessor :password
  validates :username, :uniqueness => {:message => "用户名已经存在"}
  validates :password, :allow_nil => true, :length=>{:within=>6..20, :message => "密码长度必须在6-20位之间"} #:confirmation=>true
  validates :mobilephone, :uniqueness => {:message => "手机号码已经存在"}

  def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

  def encrypt_password
    self.encrypted_password=encrypt(password)
  end

  private
  def encrypt(string)
    self.salt = make_salt if new_record?
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.new.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
