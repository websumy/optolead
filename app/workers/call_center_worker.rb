class CallCenterWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(lead_attributes)
    api = ApiCartli.new(ENV['CARTLI_TOKEN'], ENV['CARTLI_KEY'])
    params = { id: lead_attributes['id'],
               phone: lead_attributes['phone'],
               fio: lead_attributes['first_name'] + ' ' + lead_attributes['last_name'],
               counry: lead_attributes['geo'], timezone: '+3:00' }
    api.send_request('addOrder', params)
  end
end
