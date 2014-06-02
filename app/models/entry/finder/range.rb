class Entry
  class Finder
    class Range

      def initialize(user, options)
        @from = if options[:from].present?
                  Date.parse(options[:from])
                else
                  (Date.current - 2.months).at_beginning_of_month.to_date
                end
        @to = if options[:to].present?
                Date.parse(options[:to])
              else
                Date.current
              end
      end

      def scope
        Entry.between(@from, @to)
      end

      def title
        "#{I18n.l(@from)} &mdash; #{I18n.l(@to)}".html_safe
      end

    end
  end
end
