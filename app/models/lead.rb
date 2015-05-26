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
  after_create :send_post_back, if: 'user.post_back_url'
  after_create :send_to_сartli
  belongs_to :user, foreign_key: :refid

  STATE = { 'NEW' => 'Не обработан', 'ASSIGNED' => 'Назначен ответственный',
            'DETAILS' => 'Уточнение информации', 'CANNOT_CONTACT' => 'Не удалось связаться',
            'IN_PROCESS' => 'В обработке', 'ON_HOLD' => 'Обработка приостановлена',
            'RESTORED' => 'Восстановлен', 'JUNK' => 'Некачественный лид', '1' => 'Сверка',
            '2' => 'Оплачен Заказчиком', '3' => 'Оплачен Партнеру' }

  def state_ru
    STATE[state]
  end

  private

  def send_to_сartli
    LeadApiWorker.perform_async(attributes)
  end

  def send_post_back
    LeadWorker.perform_async(user.post_back_url, attributes)
  end
end
