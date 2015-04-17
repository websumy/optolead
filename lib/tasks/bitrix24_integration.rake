namespace :bitrix24 do

  desc 'Get all leads from bitrix24'
  task get_list: :environment do
    get_leads
  end

  def get_leads(offset = 0)
    @api ||= Bitrix::API.new
    responce = @api.make_list_request('crm.lead.list', {}, ['ID', 'TITLE', 'NAME','LAST_NAME', 'COMMENTS', 'STATUS_ID', 'DATE_CREATE', 'UF_CRM_1428507587'], offset)

    responce['result'].each do |lead|
      next unless lead['COMMENTS'] =~ /^Страница:/
      old_lead = Lead.find_by_bitrix_id(lead['ID'])
      results = {}
      {
          page: /Страница: (.*?)<br>/,
          refid: [/id партнера - (.*?)(<br>|$)/, /utm_refid - (.*?)(<br>|$)/],
          term: /utm_term - (.*?)(<br>|$)/,
          campaign: /utm_campaign - (.*?)(<br>|$)/,
          content: /utm_content - (.*?)(<br>|$)/,
          source: /utm_source - (.*?)(<br>|$)/,
          medium: /utm_medium - (.*?)(<br>|$)/,
          geo: /utm_geo - (.*?)(<br>|$)/,
          age: /utm_age - (.*?)(<br>|$)/,
          gender: /utm_gender - (.*?)(<br>|$)/,
          placement: /utm_placement - (.*?)(<br>|$)/
      }.each do |field, reg|
        if reg.is_a? Array
          reg.each do |r|
            search = lead['COMMENTS'].match(r)
            results[field] = search[1] if search
          end
          next
        end
         search = lead['COMMENTS'].match(reg)
         results[field] = search[1] if search
      end

      object = {
          bitrix_id: lead['ID'],
          title: lead['TITLE'],
          first_name: lead['NAME'],
          last_name: lead['LAST_NAME'],
          state: lead['STATUS_ID'],
          offer: lead['UF_CRM_1428507587'],
          created_at: lead['DATE_CREATE'],
      }.merge(results)

      old_lead ? old_lead.update_attributes(object) : Lead.create(object)
    end

    get_leads(responce['next']) if responce['next']
  end
end
