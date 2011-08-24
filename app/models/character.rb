class Character
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  include Arms

  belongs_to :user, index: true
  belongs_to :job, index: true
  has_and_belongs_to_many :skills, index: true

  embeds_one :candy
  embeds_one :equip
  embeds_one :position

  embeds_many :belongings do
    def have?(item, num = 1)
      count = 0
      where(item_id: item.id, :num.gt => 0).each do |b|
        next if b.equipping?
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
        self << Belonging.new(item: item, num: num, color: item.color)
      end
      true
    end

    def removed()
      @removed||=[]
    end

    def removed=(belonging_id)
      @removed||=[]
      @removed << belonging_id
    end

    def remove(item, num = 1)
      return false unless have? item, num
      removed = 0
      @removed ||= []
      items = where(item_id: item.id).all
      items.each do |i|
        next if i.equipping?
        if i.num > num
          i.num -= num
          if i.num == 0
            @removed << i.id
            i.delete
          end
          return true
        else
          removed += i.num
          i.num = 0
          @removed << i.id
          i.delete
          return true if num == removed
        end
      end
      false
    end
  end

  field :name, :type => String
  field :exp, :type => Integer
  field :level, :type => Integer, :default => 1
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
