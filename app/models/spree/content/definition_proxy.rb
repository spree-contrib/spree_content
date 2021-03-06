module Spree::Content
  class DefinitionProxy

    def initialize(name)
      @klass_name = name.classify

      new_klass = Class.new(Spree::Content::Widget::Base)
      @klass = Spree::Content::Widget.const_set(@klass_name, new_klass)
    end

    def text(name, &block)
      @klass.definitions << Spree::Content::Element::Text.new(get_attrs(name, &block))
    end

    def image(name, &block)
      @klass.definitions << Spree::Content::Element::Image.new(get_attrs(name, &block))
    end

    private

    def get_attrs(name, &block)
      initializer = Spree::Content::InitializerProxy.new
      initializer.instance_eval(&block) if block_given?

      initializer.attributes[:name] ||= name
      initializer.attributes
    end
  end
end
