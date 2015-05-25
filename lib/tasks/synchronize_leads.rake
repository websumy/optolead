namespace :leads do
  desc 'Synchronize tasks with cartli api'
  task synchronize: :environment do
    api = ApiCartli.new(ENV['CARTLI_TOKEN'], ENV['CARTLI_KEY'])
    new_leads = Lead.where(state: 'NEW')
    orders = api.send_request('getOrders', new_leads.map(&:id))

    new_leads.each do |lead|
      if orders['data'][lead.id.to_s] && (orders['data'][lead.id.to_s]['status'] != 0)
        lead.update_attributes(state: orders['data'][lead.id.to_s]['status'])
      end
    end
  end
end
