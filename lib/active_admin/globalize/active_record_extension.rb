module ActiveAdmin::Globalize
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    included do
      def translation_names
        self.translations.map(&:locale).map do |locale|
          I18n.t("active_admin.globalize.language.#{locale}")
        end.uniq.sort
      end
    end

    class_methods do
      def translates(*args, &block)
        super(*args.dup)
        args.extract_options!

        if block
          translation_class.instance_eval &block
        end

        accepts_nested_attributes_for :translations, allow_destroy: true
      end
    end

  end
end

