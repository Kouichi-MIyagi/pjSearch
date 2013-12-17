class Topic < ActiveRecord::Base
  attr_accessible :contents, :effective_to, :title
end
