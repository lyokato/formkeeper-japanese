# -*- encoding: utf-8 -*-
require 'spec_helper'

describe FormKeeper::Japanese do

  it "validates valid params according to rule" do

    rule = FormKeeper::Rule.new
    rule.filters :strip
    rule.field :nickname, :present => true, :kana => true, :length => 4..8

    params = {}
    params['nickname'] = 'ほげほげ'

    validator = FormKeeper::Validator.new
    report = validator.validate(params, rule)

    report.failed?.should_not be_true

    report[:nickname].should == 'ほげほげ'

  end

  it "validates hiragana with katakana filter" do

    rule = FormKeeper::Rule.new
    rule.filters :hiragana_to_katakana
    rule.field :nickname, :present => true, :kana => true, :length => 4..8

    params = {}
    params['nickname'] = 'ほげほげ'

    validator = FormKeeper::Validator.new
    report = validator.validate(params, rule)

    report.failed?.should_not be_true

    report[:nickname].should == 'ホゲホゲ'

  end

  it "validates katakana with hiragana filter" do

    rule = FormKeeper::Rule.new
    rule.filters :katakana_to_hiragana
    rule.field :nickname, :present => true, :kana => true, :length => 4..8

    params = {}
    params['nickname'] = 'ホゲホゲ'

    validator = FormKeeper::Validator.new
    report = validator.validate(params, rule)

    report.failed?.should_not be_true

    report[:nickname].should == 'ほげほげ'

  end

  it "validates valid kana filter" do

    rule = FormKeeper::Rule.new
    rule.field :value01, :present => true, :hiragana => true, :length => 4..8
    rule.field :value02, :present => true, :hiragana => true, :length => 4..8
    rule.field :value03, :present => true, :katakana => true, :length => 4..8
    rule.field :value04, :present => true, :katakana => true, :length => 4..8

    params = {}
    params['value01'] = 'ほげほげ'
    params['value02'] = 'ホゲホゲ'
    params['value03'] = 'ほげほげ'
    params['value04'] = 'ホゲホゲ'

    validator = FormKeeper::Validator.new
    report = validator.validate(params, rule)

    report.failed?.should be_true

    report.failed_on?(:value02, :hiragana).should be_true
    report.failed_on?(:value03, :katakana).should be_true

    report[:value01].should == 'ほげほげ'
    report[:value04].should == 'ホゲホゲ'

  end


  it "validates invalid length of hiragana" do

    rule = FormKeeper::Rule.new
    rule.filters :hiragana_to_katakana
    rule.field :nickname, :present => true, :kana => true, :length => 4..8

    params = {}
    params['nickname'] = 'ほげ'

    validator = FormKeeper::Validator.new
    report = validator.validate(params, rule)

    report.failed?.should be_true

    report.failed_on?(:nickname, :length).should be_true

  end

  it "validates zenkaku integer" do

    rule = FormKeeper::Rule.new
    rule.filters :zenkaku_to_hankaku
    rule.field :nickname, :present => true, :int => true

    params = {}
    params['nickname'] = '１２３４５６７８９'

    validator = FormKeeper::Validator.new
    report = validator.validate(params, rule)

    report.failed?.should_not be_true

    report[:nickname].should == '123456789'

  end

  it "validates hankaku integer" do

    rule = FormKeeper::Rule.new
    rule.filters :hankaku_to_zenkaku
    rule.field :nickname, :present => true, :int => true

    params = {}
    params['nickname'] = '123456789'

    validator = FormKeeper::Validator.new
    report = validator.validate(params, rule)

    report.failed?.should_not be_true

    report[:nickname].should == '１２３４５６７８９'

  end

end

