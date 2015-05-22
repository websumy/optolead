namespace :bitrix24 do

  desc 'Get all leads from bitrix24'
  task get_all_leads: :environment do
    Bitrix24.new.get_leads
  end

  desc 'Get only updated leads from bitrix24'
  task get_updated_leads: :environment do
    last_date = 30.minutes.ago.strftime('%FT%T+03:00')
    Bitrix24.new.get_leads('>DATE_MODIFY' => last_date)
  end

  desc 'Get only new leads from bitrix24'
  task get_new_leads: :environment do
    last_date = Lead.last.created_at.strftime('%FT%T+03:00')
    Bitrix24.new.get_leads('>DATE_CREATE' => last_date)
  end
end
