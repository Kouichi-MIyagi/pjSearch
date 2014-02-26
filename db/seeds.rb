# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# coding: utf-8
User.create(:email => 'p8971228@tayori.ogis-ri.co.jp',
  :user_id => 'pjsadmin' , :password => '' ,
	:user_name => 'admin' ,
    :role => 'admin' )
User.create(:email => 'P8671620@tayori.ogis-ri.co.jp',
  :user_id => 'pjsguest' , :password => '' ,
	:user_name => 'ゲストユーザー' ,
    :role => 'admin' )
		
Questionitem.create(:question => '業務でなにか困ったことがありますか（難しい要求、クレーム、トラブルなど）',
  :answer1 => 4,:answer1_item => 'ない',
    :answer2 => 3,:answer2_item => 'あまりない',
     :answer3 => 2,:answer3_item => 'ある',
      :answer4 => 1,:answer4_item => 'よくある')
Questionitem.create(:question => '業務において負担や負荷を感じていますか',
  :answer1 => 4,:answer1_item => '感じていない',
    :answer2 => 3,:answer2_item => 'あまり感じてない',
     :answer3 => 2,:answer3_item => '感じている',
      :answer4 => 1,:answer4_item => '強く感じている')
Questionitem.create(:question => 'あなたの役割は明確になっていますか',
  :answer1 => 4,:answer1_item => '明確になっている',
    :answer2 => 3,:answer2_item => 'ほぼ明確になっている',
     :answer3 => 2,:answer3_item => 'やや曖昧',
      :answer4 => 1,:answer4_item => 'きわめて曖昧')
Questionitem.create(:question => 'あなたの業務内容はよく変わりますか',
  :answer1 => 4,:answer1_item => '変わらない',
    :answer2 => 3,:answer2_item => 'あまり変わらない',
     :answer3 => 2,:answer3_item => '時々変わる',
      :answer4 => 1,:answer4_item => 'よく変わる')
Questionitem.create(:question => '担当業務の作業要員は足りていますか',
  :answer1 => 4,:answer1_item => '足りている',
    :answer2 => 3,:answer2_item => 'ほぼ足りている',
     :answer3 => 2,:answer3_item => 'やや不足気味',
      :answer4 => 1,:answer4_item => '増員が必要')
Questionitem.create(:question => 'あなたの周りに高圧的な方はおられますか（お客様を含め）',
  :answer1 => 4,:answer1_item => 'いない',
    :answer2 => 3,:answer2_item => 'あまりいない',
     :answer3 => 2,:answer3_item => 'たまにいる',
      :answer4 => 1,:answer4_item => 'いる')
Questionitem.create(:question => '職場環境や雰囲気はいかがですか',
  :answer1 => 4,:answer1_item => 'よい',
    :answer2 => 3,:answer2_item => 'ややよい',
     :answer3 => 2,:answer3_item => 'やや悪い',
      :answer4 => 1,:answer4_item => '悪い')
	  
Status.create(:is_mentenance => false)

Questionnaire.create(:title => '客先常駐者用アンケートひな型',
  :effective_from => '2014-02-01',
    :effective_to => '2016-02-03',
	  :questionitems  => Questionitem.where(:id => [1, 2, 3, 4, 5, 6, 7]))
	  

