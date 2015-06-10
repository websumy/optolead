set :output, '/home/yarivo/www/optolead/current/log/cron.log'

every 3.minutes do
  rake 'bitrix24:get_new_leads'
end

every 15.minutes do
  rake 'bitrix24:get_updated_leads'
end

every 5.minutes do
  rake 'leads:synchronize'
end
