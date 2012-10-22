# -*- encoding: utf-8 -*-
require 'spec_helper'

describe FormKeeper::Japanese do

  it "validates valid params according to rule" do

    rule = FormKeeper::Rule.new
    rule.filters :strip
    rule.field :nickname, :present => true, :kana => true, :characters => 4..8

    params = {}
    params['nickname'] = 'ほげほげ'

    validator = FormKeeper::Validator.new
    report = validator.validate(params, rule)

    report.failed?.should_not be_true

    report[:nickname].should == 'ほげほげ'

  end

  it "validates hiragana with katakana filter" do

    rule = FormKeeper::Rule.new
    rule.filters :hiragana2katakana
    rule.field :nickname, :present => true, :kana => true, :characters => 4..8

    params = {}
    params['nickname'] = 'ほげほげ'

    validator = FormKeeper::Validator.new
    report = validator.validate(params, rule)

    report.failed?.should_not be_true

    report[:nickname].should == 'ホゲホゲ'

  end

  it "validates zenkaku integer" do

    rule = FormKeeper::Rule.new
    rule.filters :zenkaku2hankaku
    rule.field :nickname, :present => true, :int => true

    params = {}
    params['nickname'] = '１２３４５６７８９'

    validator = FormKeeper::Validator.new
    report = validator.validate(params, rule)

    report.failed?.should_not be_true

    report[:nickname].should == '123456789'

  end

end

