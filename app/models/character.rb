class Character
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  belongs_to :user, index: true
  embeds_one :candy
  embeds_many :belongings do
    def have?(item, num = 1)
      count = 0
      where(item_id: item.id, :num.gt => 0).each do |b|
        count += b.num
      end
      count >= num
    end

    def bag_over?(item, num = 1)
      target.size >= base.bag_size
    end

    def add(item, num = 1)
      return false if bag_over? item, num
      doc = where(item_id: item.id).first
      if doc
        doc.num += num
        doc.save!
      else
        target << Belonging.new(item: item, num: num, color: item.color)
      end
      true
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
