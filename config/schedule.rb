set :output, '/home/yarivo/www/optolead/current/log/cron.log'

every 30.minutes do
  rake 'bitrix24:get_list'
end
