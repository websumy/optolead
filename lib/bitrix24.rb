class Bitrix24

  FIELDS = %w(ID TITLE NAME LAST_NAME COMMENTS STATUS_ID DATE_CREATE DATE_MODIFY UF_CRM_1428507587)

  def initialize
    @api = Bitrix::API.new
  end

  def get_leads(filter = {}, offset = 0)
    responce = @api.make_list_request('crm.lead.list', filter, FIELDS, offset)
    create_or_update_leads(responce)
    get_leads(filter, responce['next']) if responce['next']
  end

  private

  def create_or_update_leads(responce)
    responce['result'].each do |lead|
      next unless lead['COMMENTS'] =~ /^Страница:/
      old_lead = Lead.find_by_bitrix_id(lead['ID'])
      new_object = lead_fields(lead).merge(parse_comments(lead))
      old_lead ? old_lead.update_attributes(new_object) : Lead.create(new_object)
    end
  end

  def parse_comments(lead)
    results = {}
    field_regexps.each do |field, reg|
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
    results
  end

  def lead_fields(lead)
    {
        bitrix_id: lead['ID'],
        title: lead['TITLE'],
        first_name: lead['NAME'],
        last_name: lead['LAST_NAME'],
        state: lead['STATUS_ID'],
        offer: lead['UF_CRM_1428507587'],
        created_at: lead['DATE_CREATE'],
    }
  end

  def field_regexps
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
    }
  end
end
