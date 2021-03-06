namespace :leads do
  desc 'Synchronize tasks with cartli api'
  task synchronize: :environment do
    cartli = ApiCartli.new(ENV['CARTLI_TOKEN'], ENV['CARTLI_KEY'])
    bitrix24 = Bitrix24.new
    new_leads = Lead.where(state: 'NEW')
    orders = cartli.send_request('getOrders', new_leads.map(&:id))

    new_leads.each do |lead|
      if orders['data'][lead.id.to_s] && (status = orders['data'][lead.id.to_s]['status'] != 'wait')
        assigned = {}

        case status
        when 'approve'
          bitrix_status = 'IN_PROCESS' # Назначена встреча
          if lead.page =~ /EL[0-9]+/
            id = 33 # Anna (Elemenary)
          elsif lead.page =~ /EG[0-9]+/
            id = 17 # Ashad (EasyGet)
          end
          assigned = { 'ASSIGNED_BY_ID' => id } if id
        when 'recall'
          bitrix_status = '8' # Перезвонить
        when 'decline'
          bitrix_status = orders['data'][lead.id.to_s]['op_decline'] # Причина отказа с коллцентра
        else
          bitrix_status = nil
        end

        if bitrix_status
          answer = lead.call_center_answer
          attrs = orders['data'][lead.id.to_s].select{ |k,_| k.in?(answer.attribute_names - ['id']) }
          attrs_s = attrs.map{|k,v| "#{k}=#{v}"}.join('<br>')
          lead.update_attributes(state: bitrix_status)
          answer.update(attrs)
          bitrix24.update_lead(lead.bitrix_id, { 'STATUS_ID' => bitrix_status, 'UF_CRM_1434446496' => attrs_s }.merge(assigned))
        end
      end
    end
  end
end
