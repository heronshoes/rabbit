require 'rabbit/utils'
require 'rabbit/ext/base'
require 'rabbit/ext/image'
require 'rabbit/ext/entity'

module Rabbit
  module Ext
    class InlineVerbatim < Base
      extend Utils
      include Image
      include Entity

#       def ext_inline_verb_img(label, content, visitor)
#         img(label, content, visitor)
#       end
      
      def ext_inline_verb_quote(label, content, visitor)
        label = label.to_s
        return nil unless /^quote:(.*)$/ =~ label
        visitor.__send__(:default_ext_inline_verb, $1, $1)
      end
      
      def ext_inline_verb_del(label, content, visitor)
        label = label.to_s
        return nil unless /^del:(.*)$/ =~ label
        DeletedText.new(visitor.apply_to_String($1))
      end
      
      def ext_inline_verb_sub(label, content, visitor)
        label = label.to_s
        return nil unless /^sub:(.*)$/ =~ label
        sub_text = $1
        unless /\A\s*\z/ =~ sub_text
          sub_text = visitor.apply_to_Verb(RD::Verb.new(sub_text)).text
        end
        Subscript.new(sub_text)
      end
      
      def ext_inline_verb_sup(label, content, visitor)
        label = label.to_s
        return nil unless /^sup:(.*)$/ =~ label
        sub_text = $1
        unless /\A\s*\z/ =~ sub_text
          sub_text = visitor.apply_to_Verb(RD::Verb.new(sub_text)).text
        end
        Superscript.new(sub_text)
      end

    end
  end
end
