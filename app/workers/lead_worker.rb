class LeadWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(url, lead_attributes)
    allowed_params = %W{ bitrix_id title state sub_id first_name last_name page
      page source campaign medium term refid content}
    lead_attributes.extract!(*allowed_params).each{ |k, v| url.sub!("{#{k.upcase}}", v.to_s) }
    uri = URI.parse(url)

    Net::HTTP.post_form uri, Rack::Utils.parse_nested_query(uri.query)
  end
end
