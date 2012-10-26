require "formkeeper/japanese/version"
require "moji"

module FormKeeper
  module Japanese
    module Filter

      class ZenkakuToHankaku < ::FormKeeper::Filter::Base
        def process(value)
          Moji.zen_to_han(value)
        end
      end 
      class HankakuToZenkaku < ::FormKeeper::Filter::Base
        def process(value)
          Moji.han_to_zen(value)
        end
      end 
      class KataToHira < ::FormKeeper::Filter::Base
        def process(value)
          Moji.kata_to_hira(value)
        end
      end 
      class HiraToKata < ::FormKeeper::Filter::Base
        def process(value)
          Moji.hira_to_kata(value)
        end
      end 
    end
    module Constraint
      class Kana < FormKeeper::Constraint::Base
        def validate(value, arg)
          result = value =~ /^#{Moji.kana}+$/
          result = !result if !arg
          result
        end
      end
      class Hiragana < FormKeeper::Constraint::Base
        def validate(value, arg)
          result = value =~ /^#{Moji.hira}+$/
          result = !result if !arg
          result
        end
      end
      class Katakana < FormKeeper::Constraint::Base
        def validate(value, arg)
          result = value =~ /^#{Moji.kata}+$/
          result = !result if !arg
          result
        end
      end
    end
  end
end

FormKeeper::Validator.register_filter :hiragana_to_katakana, 
  FormKeeper::Japanese::Filter::HiraToKata.new
FormKeeper::Validator.register_filter :katakana_to_hiragana, 
  FormKeeper::Japanese::Filter::KataToHira.new
FormKeeper::Validator.register_filter :hankaku_to_zenkaku, 
  FormKeeper::Japanese::Filter::HankakuToZenkaku.new
FormKeeper::Validator.register_filter :zenkaku_to_hankaku, 
  FormKeeper::Japanese::Filter::ZenkakuToHankaku.new
FormKeeper::Validator.register_constraint :kana, 
  FormKeeper::Japanese::Constraint::Kana.new
FormKeeper::Validator.register_constraint :hiragana, 
  FormKeeper::Japanese::Constraint::Hiragana.new
FormKeeper::Validator.register_constraint :katakana,
  FormKeeper::Japanese::Constraint::Katakana.new

