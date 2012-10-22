require "formkeeper/japanese/version"
require "moji"

module FormKeeper
  module Japanese
    module Filter
      class ZenToHan < ::FormKeeper::Filter::Base
        def process(value)
          Moji.zen_to_han(value)
        end
      end 
      class HanToZen < ::FormKeeper::Filter::Base
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
          # TODO support ZENKAKU/HANKAKU KIGOU \p{Punct}
          result = value =~ /^#{Moji.kana}+$/
          result = !result if !arg
          result
        end
      end
      class Hiragana < FormKeeper::Constraint::Base
        def validate(value, arg)
          # TODO support ZENKAKU/HANKAKU KIGOU \p{Punct}
          result = value =~ /^#{Moji.hira}+$/
          result = !result if !arg
          result
        end
      end
      class Katakana < FormKeeper::Constraint::Base
        def validate(value, arg)
          # TODO support ZENKAKU/HANKAKU KIGOU
          result = value =~ /^#{Moji.kata}+$/
          result = !result if !arg
          result
        end
      end
    end
  end
end

FormKeeper::Validator.register_filter :hiragana2katakana, 
  FormKeeper::Japanese::Filter::HiraToKata.new
FormKeeper::Validator.register_filter :katakana2hiragana, 
  FormKeeper::Japanese::Filter::KataToHira.new
FormKeeper::Validator.register_filter :hankaku2zenkaku, 
  FormKeeper::Japanese::Filter::HanToZen.new
FormKeeper::Validator.register_filter :zenkaku2hankaku, 
  FormKeeper::Japanese::Filter::Zen2Han.new
FormKeeper::Validator.register_constraint :kana, 
  FormKeeper::Japanese::Constraint::Kana.new
FormKeeper::Validator.register_constraint :hiragana, 
  FormKeeper::Japanese::Constraint::Hiragana.new
FormKeeper::Validator.register_constraint :katakana,
  FormKeeper::Japanese::Constraint::Katakana.new

