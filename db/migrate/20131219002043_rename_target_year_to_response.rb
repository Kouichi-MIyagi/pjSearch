class RenameTargetYearToResponse < ActiveRecord::Migration
  def up
    rename_column :responses, :targetYear, :target_year
    rename_column :responses, :targetMonth, :target_month
    rename_column :responses, :pjName, :pj_name
  end

  def down
    rename_column :responses, :target_year, :targetYear
    rename_column :responses, :target_month, :targetMonth
    rename_column :responses, :pj_name, :pjName
  end
end
