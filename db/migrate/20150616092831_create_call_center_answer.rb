class CreateCallCenterAnswer < ActiveRecord::Migration
  def self.up
    create_table :call_center_answers do |t|
      t.references :lead
      t.string :op_decline
      t.string :calc_calorie_box
      t.string :calorie_box
      t.string :deliv_address
      t.string :deliv_date
      t.string :price
      t.string :age
      t.string :height
      t.string :current_weight
      t.string :desired_weight
      t.string :fiz_load_level
      t.string :day_eat_count
      t.string :day_nosh_count
      t.string :activity_level
      t.string :osobiy_status
      t.string :food_allergies
      t.string :disease
      t.string :vitamins_supplements
      t.text :comment
    end
    Lead.all.each { |lead| lead.create_call_center_answer }
  end

  def self.down
    drop_table :call_center_answers
  end
end
