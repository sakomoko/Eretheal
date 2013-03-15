class Character
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  include Eretheal::CombatActor
  extend Enumerize

  belongs_to :user, index: true, inverse_of: :character
  belongs_to :job, index: true
  has_and_belongs_to_many :skills, index: true

  after_initialize :set_up

  before_create do |document|
    document.clean
  end

  embeds_one :candy, autobuild: true
  embeds_one :equip, autobuild: true
  embeds_one :position, autobuild: true, cascade_callbacks: true
  embeds_many :assigned_skills

  embeds_one :action_report

  embeds_many :inventory, class_name: "InventoryItem" do
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
        self << InventoryItem.new(item: item, num: num, color: item.color)
      end
      true
    end

    def removed()
      @removed||=[]
    end

    def removed=(inventory_item_id)
      @removed||=[]
      @removed << inventory_item_id
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
  field :exp, :type => Integer, :default => 0
  field :level, :type => Integer, :default => 1
  field :skill_point, :type => Integer, :default => 0
  field :stamina, :type => Integer, :default => 0
  field :hp, :type => Integer, :default => 0
  field :mp, :type => Integer, :default => 0
  field :charge_time, type: Integer, default: 0

  field :gender
  enumerize :gender, in: [:male, :female], default: :male, predicates: true

  field :status_point, :type => Integer, :default => 0
  field :total_exp, :type => Integer, :default => 0
  field :bag_size, :type => Integer, :default => 6
  field :count, :type => Integer, :default => 0

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => true

  accepts_nested_attributes_for :candy, :equip, :position, :assigned_skills, :inventory, :action_report

  rails_admin do
    list do
      field :user
      field :name
      field :job
      field :level
      field :exp
      field :updated_at
    end
  end

  def action=(action)
    if action.instance_of? Skill
      unless self.assigned_skills.where(skill_id: action.id).first
        unless action.name.to_sym.in?(Eretheal::Application.config.default_actions)
          raise RuntimeError, 'character not assinged the skill.'
        end
      end
    elsif action.instance_of? InventoryItem
      unless self.id == action.character.id
        raise RuntimeError, 'character has not this item.'
      end
    end
    super
  end

  def current?
    @current || false
  end

  def set_current!
    @current = true
  end

  def combat?
    !!action_report
  end

end
