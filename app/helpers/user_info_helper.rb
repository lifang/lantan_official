module UserInfoHelper
  #产品和储值卡相关联的记录
  def sv_p_relations(record)
    record.c_svc_relation.sv_card.svcard_prod_relations
  end
end
