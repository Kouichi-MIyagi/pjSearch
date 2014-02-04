# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# coding: utf-8
Questionitem.create(:question => 'あなたの作業時間は長いですか',
  :answer1 => 1,:answer1_item => '普通',
    :answer2 => 2,:answer2_item => 'やや長い',
     :answer3 => 3,:answer3_item => 'かなり長い',
      :answer4 => 4,:answer4_item => 'きわめて長い')
Questionitem.create(:question => 'あなたの役割は決まっていますか',
  :answer1 => 1,:answer1_item => '決まっている',
    :answer2 => 2,:answer2_item => 'ほぼ決まっている',
     :answer3 => 3,:answer3_item => 'やや曖昧',
      :answer4 => 4,:answer4_item => 'きわめて曖昧')
Questionitem.create(:question => 'あなたの作業内容はよく変わりますか',
  :answer1 => 1,:answer1_item => '変わらない',
    :answer2 => 2,:answer2_item => 'あまり変わらない',
     :answer3 => 3,:answer3_item => '時々変わる',
      :answer4 => 4,:answer4_item => '変わる')
Questionitem.create(:question => 'あなたの担当の作業要員は足りていますか',
  :answer1 => 1,:answer1_item => '足りている',
    :answer2 => 2,:answer2_item => 'ほぼ足りている',
     :answer3 => 3,:answer3_item => 'やや不足気味',
      :answer4 => 4,:answer4_item => '増員が必要')
Questionitem.create(:question => 'あなたの周りに高圧的な方はおられますか',
  :answer1 => 1,:answer1_item => 'いない',
    :answer2 => 2,:answer2_item => 'ほぼいない',
     :answer3 => 3,:answer3_item => 'たまにいる',
      :answer4 => 4,:answer4_item => 'いる')
Questionitem.create(:question => '作業先の雰囲気は悪いですか',
  :answer1 => 1,:answer1_item => 'よい',
    :answer2 => 2,:answer2_item => 'まあまあ',
     :answer3 => 3,:answer3_item => 'やや悪い',
      :answer4 => 4,:answer4_item => '悪い')
Status.create(:is_mentenance => false)
