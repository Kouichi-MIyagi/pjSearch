class Questionitem < ActiveRecord::Base
  
  has_and_belongs_to_many :questionnaires
  
  def answers_select
   return {self.answer1_item => a_1, self.answer2_item => a_2, self.answer3_item => a_3, self.answer4_item => a_4}
  end

  def concat_answer(answer, answer_item)
    return answer.to_s + '.' + answer_item
  end

  def a_1
    return concat_answer(self.answer1, self.answer1_item)
  end

  def a_2
    return concat_answer(self.answer2, self.answer2_item)
  end

  def a_3
    return concat_answer(self.answer3, self.answer3_item)
  end

  def a_4
    return concat_answer(self.answer4, self.answer4_item)
  end

end
