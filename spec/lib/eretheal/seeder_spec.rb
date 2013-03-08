# -*- coding: utf-8 -*-
module Eretheal::Seeder::Helper
  extend ActiveSupport::Concern
  include Mongoid::Document
  include Mongoid::Slug
  include Eretheal::Seeder

  included do
    field :key, type: String
    slug :key
    attr_accessible :key, as: :seeder
  end
end

class Mock
  include Eretheal::Seeder::Helper
  has_one :one_polymorphic_relation, as: :mockable
end

class OneBelongsToRelation
  include Eretheal::Seeder::Helper
  belongs_to :mock
end

class OneEmbeddedDocument
  include Eretheal::Seeder::Helper
  belongs_to :mock
end

class OnePolymorphicRelation
  include Eretheal::Seeder::Helper
  belongs_to :mockable, polymorphic: true
end

class OneEmbedsManyRelation
  include Eretheal::Seeder::Helper
  embeds_many :one_embedded_documents
end

describe Eretheal::Seeder do
  describe 'seeder_path' do
    subject { Mock.seeder_path }
    it { should eq "#{Rails.root}/spec/fixtures" }
  end
  describe 'create_seed' do
    it 'call delete_all' do
      Mock.should_receive :delete_all
      Mock.create_seed
    end

    describe 'Non Relation Model' do
      before do
        Attribute.create_seed
      end
      subject { Attribute.all.to_a }
      it { should have(11).attributes }
      its("first._id.to_s") { should eq "50e5254ac54d2dfa41000019" }
    end

    describe 'One BelongsTo Relation' do

      context '関連先であるAttributeデータが存在していない場合' do
        subject { ->{ WeaponType.create_seed } }
        it { should raise_error(Mongoid::Errors::DocumentNotFound) }
      end


      context '関連先であるAttributeデータが存在する場合' do
        before do
          Attribute.create_seed
          WeaponType.create_seed
        end
        subject { WeaponType.all.to_a }
        it { should have(13).types }
        it '_idが指定されていれば、値が正しいこと' do
          subject.first._id.to_s.should eq "50e56972c54d2d6fb900001c"
        end
        context 'BelongsTo関連のアイテムが、keyを参照に保存されていること' do
          its("first.attribute") { should be_instance_of(Attribute) }
          its("first.attribute.key") { should eq 'penetrate' }
        end
      end
    end

    describe 'One Polymorphic Relation' do
      context '関連先であるMockデータが存在していない場合' do
        subject { ->{ OnePolymorphicRelation.create_seed } }
        it { should raise_error(Mongoid::Errors::DocumentNotFound) }
      end

      context '関連先であるデータが存在している場合' do
        before do
          Mock.create_seed
          OnePolymorphicRelation.create_seed
        end
        subject { OnePolymorphicRelation.all.to_a }
        it { should have(1).items }
        context 'ポリモーフィック関連が保存されていること' do
          subject { OnePolymorphicRelation.first.mockable }
          it { should be_instance_of(Mock) }
        end
      end
    end

    describe 'EmbedsMany Relation' do
      before do
        Mock.create_seed
        OneEmbedsManyRelation.create_seed
      end
      subject { OneEmbedsManyRelation.all.to_a }
      it { should have(1).items }
      context 'Embeded Documentが保存されていること' do
        subject { OneEmbedsManyRelation.first.one_embedded_documents.first }
        it { should be_instance_of OneEmbeddedDocument }
      end

      context 'Embeded DocumentにあるBelongsTo関連が保存されていること' do
        subject { OneEmbedsManyRelation.first.one_embedded_documents }
        it { should have(1).items }
        its("first.mock") { should be_instance_of Mock }
        it 'hoge' do
         end
      end


    end

  end
end
