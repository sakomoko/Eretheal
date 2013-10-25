# -*- coding: utf-8 -*-
require 'spec_helper'

describe ProcedureCommand do
  describe '.new' do
    it 'keyをidにして保存できる' do
      -> {ProcedureCommand.create! key: :lower_enemy}.should change(ProcedureCommand, :count).by 1
    end
    it 'keyのシンボルから検索できる' do
      document = ProcedureCommand.create! key: :lower_enemy
      ProcedureCommand.find(:lower_enemy).should eq document
    end
    it 'targetのデフォルトが保存される' do
      document = ProcedureCommand.create! key: :lower_enemy
      document.target.should be_enemy
    end
  end
end
