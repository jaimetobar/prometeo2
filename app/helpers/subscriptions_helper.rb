module SubscriptionsHelper
    def checkbox(checked)
        if checked
            return '<input type="checkbox" checked value="#{checked}">'.html_safe
        else
            return '<input type="checkbox" value="#{checked}">'.html_safe
        end
    end
end
