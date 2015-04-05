set :output, '/home/yarivo/www/optolead/current/log/cron.log'

every 2.hours do
  rake 'bitrix24:get_list'
end
