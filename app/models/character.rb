class Character
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  belongs_to :user, index: true
  embeds_one :candy
  embeds_many :belongings do
    def have?(item_id, num = 1)
      count = 0
      where(item_id: item_id, :num.gt => 0).each do |b|
        count += b.num
      end
      count >= num
    end
  end

  field :name, :type => String
  field :exp, :type => Integer
  field :level, :type => Integer
  field :skill_point, :type => Integer
  field :stamina, :type => Integer
  field :hp, :type => Integer
  field :mp, :type => Integer
  field :dex, :type => Integer
  field :agi, :type => Integer
  field :str, :type => Integer
  field :int, :type => Integer
  field :mnd, :type => Integer
  field :vit, :type => Integer

  field :sex, :type => Integer

  field :status_point, :type => Integer
  field :total_exp, :type => Integer
  field :bag_size, :type => Integer
  field :count, :type => Integer
end
