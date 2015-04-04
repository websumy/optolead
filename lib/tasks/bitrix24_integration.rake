namespace :bitrix24 do

  desc 'Get all leads from bitrix24'
  task get_list: :environment do
    get_leads
  end

  def get_leads(offset = 0)
    @api ||= Bitrix::API.new
    responce = @api.make_list_request('crm.lead.list', {}, ['ID', 'TITLE', 'NAME','LAST_NAME', 'COMMENTS', 'STATUS_ID', 'DATE_CREATE',], offset)

    responce['result'].each do |lead|
      next unless lead['COMMENTS'] =~ /^Страница:/
      old_lead = Lead.find_by_bitrix_id(lead['ID'])

      term, campaign, content, source, medium = nil

      page, refid, phone, name = lead['COMMENTS'].match('Страница: (.*)<br>Дополнительные параметры:<br>id партнера - (.*)<br>телефон клиента - (.*)<br>имя клиента - (.*)').try(:captures).try(:map, &:strip)
      page, refid, term, campaign, content, source, medium = lead['COMMENTS'].match('Страница: (.*)<br>Дополнительные параметры:<br>utm_refid - (.*)<br>utm_term - (.*)<br>utm_campaign - (.*)<br>utm_content - (.*)<br>utm_source -(.*) <br>utm_medium - (.*)').try(:captures).try(:map, &:strip) unless page

      object = {
          bitrix_id: lead['ID'],
          title: lead['TITLE'],
          first_name: lead['NAME'],
          last_name: lead['LAST_NAME'],
          state: lead['STATUS_ID'],
          created_at: lead['DATE_CREATE'],
          page: page,
          refid: refid,
          term: term,
          campaign: campaign,
          content: content,
          source: source,
          medium: medium
      }

      old_lead ? old_lead.update_attributes(object) : Lead.create(object)
    end

    get_leads(responce['next']) if responce['next']
  end
end
