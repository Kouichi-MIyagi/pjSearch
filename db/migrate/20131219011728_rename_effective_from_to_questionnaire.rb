class RenameEffectiveFromToQuestionnaire < ActiveRecord::Migration
  def up
    rename_column :questionnaires, :effectiveFrom, :effective_from
    rename_column :questionnaires, :effectiveTo, :effective_to
  end

  def down
    rename_column :questionnaires, :effective_from, :effectiveFrom
    rename_column :questionnaires, :effective_to, :effectiveTo
  end
end
