require_relative 'notifier'

module Uvobot
  module Notifications
    class DiscourseNotifier < Notifier
      def initialize(discourse_client, category, scraper)
        @client = discourse_client
        @category = category
        @scraper = scraper
      end

      def no_announcements_found
        # noop
      end

      def new_issue_not_published
        # noop
      end

      def matching_announcements_found(_page_info, announcements)
        announcements.each do |a|
          topic = announcement_to_topic(a)
          @client.create_topic(
            title: topic[:title],
            raw: topic[:body],
            category: @category
          )
        end
      end

      private

      def announcement_to_topic(announcement)
        detail = @scraper.get_announcement_detail(announcement[:link][:href])
        body_messages = ["**Obstarávateľ:** #{announcement[:procurer]}",
                         "**Predmet obstarávania:** #{announcement[:procurement_subject]}",
                         compile_detail_messages(detail),
                         "**Zdroj:** [#{announcement[:link][:text]}](#{announcement[:link][:href]})"]

        {
          title: announcement[:procurement_subject].to_s,
          body: body_messages.flatten(1).join("  \n")
        }
      end

      def compile_detail_messages(detail)
        if detail
          detail.keys.map { |k| detail_messages[k].gsub('%{content}', fallback_if_nil(detail[k])) }
        else
          ['**Detaily sa nepodarilo extrahovať.**']
        end
      end

      def detail_messages
        {
          amount: '**Cena:** %{content}',
          procurement_type: '**Druh postupu:** %{content}',
          project_runtime: '**Trvanie projektu:** %{content}',
          offer_placing_term: '**Lehota na predkladanie ponúk:** %{content}',
          procurement_winner: "**Víťaz obstarávania:**  \n %{content}"
        }
      end

      def fallback_if_nil(value)
        value || 'Nepodarilo sa extrahovať'
      end
    end
  end
end
