module ::Refinery
  module Admin
    module DashboardHelper

      def activity_message_for(record)
        plugin = ::Refinery::Plugins.active.find_by_model(record.class)

        if (activity = plugin.activity.first).present?
          # work out which action occured
          action = record.updated_at.eql?(record.created_at) ? "created" : "updated"

          # get article to define gender of model name, some languages require this for proper grammar
          article = t('article', :scope => "refinery.plugins.#{plugin.name}.", :default => 'the')

          # now create a link to the notification's corresponding record.
          link_to t(".latest_activity_message",
                    :what => record.send(activity.title),
                    :kind => record.class.model_name.human,
                    :action => t("with_article \"#{article}\"", :scope => "refinery.#{action}")
                   ).downcase.capitalize, eval("main_app.#{activity.url}(#{activity.nesting("record")}record)")
        end
      end

    end
  end
end
