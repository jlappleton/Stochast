module ApplicationHelper
  def flash_message
    flash.each do |alert_type, message|
        concat(content_tag(:div, message, class: "alert #{alert_type} alert-dismissible", role: 'alert') do
            concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
                concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
                concat content_tag(:span, 'Close', class: 'sr-only')
            end)
            concat message
        end)
    end
    nil
  end
end
