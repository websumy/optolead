namespace :leads do
  desc 'Synchronize tasks with cartli api'
  task synchronize: :environment do
    cartli = ApiCartli.new(ENV['CARTLI_TOKEN'], ENV['CARTLI_KEY'])
    bitrix24 = Bitrix24.new
    new_leads = Lead.where(state: 'NEW')
    orders = cartli.send_request('getOrders', new_leads.map(&:id))

    new_leads.each do |lead|
      if orders['data'][lead.id.to_s] && (orders['data'][lead.id.to_s]['status'] != 0)
        lead.update_attributes(state: orders['data'][lead.id.to_s]['status'])
        bitrix24.update_lead(lead.id, { 'STATUS_ID' => orders['data'][lead.id.to_s]['status'] })
      end
    end
  end
end
