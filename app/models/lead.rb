# == Schema Information
#
# Table name: leads
#
#  id         :integer          not null, primary key
#  bitrix_id  :integer
#  title      :string
#  state      :string
#  sub_id     :string
#  first_name :string
#  last_name  :string
#  page       :string
#  source     :string
#  campaign   :string
#  medium     :string
#  term       :string
#  refid      :string
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  offer      :string
#  geo        :string
#  age        :string
#  gender     :string
#  placement  :string
#  phone      :string
#

class Lead < ActiveRecord::Base
  after_create :send_post_back, if: 'user && user.post_back_url'
  after_create :send_to_сartli

  STATE = { 'NEW' => 'Не обработан', 'ASSIGNED' => 'Назначен менеджер',
            'DETAILS' => 'Уточнение информации', 'CANNOT_CONTACT' => 'Не удалось связаться',
            'IN_PROCESS' => 'Назначена встреча', 'ON_HOLD' => 'Обработка приостановлена',
            'RESTORED' => 'Восстановлен', 'JUNK' => 'Отказ', '1' => 'Перезвонить через месяц',
            '2' => 'Передумал', '3' => 'Нет денег', '4' => 'Не устраивают условия',
            '5' => 'Не подходит география', '6' => 'Просто интересовался',
            '7' => 'Некачественный Лид', '8' => 'Перезвонить', '9' => 'Оформлен заказ' }

  def user
    @user ||= User.find_by_refid(refid)
  end

  def state_ru
    STATE[state]
  end

  private

  def send_to_сartli
    CallCenterWorker.perform_async(attributes)
  end

  def send_post_back
    PostBackWorker.perform_async(user.post_back_url, attributes)
  end
end
