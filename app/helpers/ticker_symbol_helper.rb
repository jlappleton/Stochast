module TickerSymbolHelper
  def display_symbol(ticker_symb)
    haml_tag :div, :class => "card border-info mb-3" do
      haml_tag :h3, :class => "card-header" do
        #haml_tag :div, :class => "card-body" do
          haml_tag :a, :class => "btn btn-outline-success btn-lg btn-block", :href => ticker_symbol_path(ticker_symb[:symb]) do
            haml_tag :h1, :class => "display-4 card-title" do
              haml_concat ticker_symb[:symb]
            end
            haml_tag :h6, :class => "card-subtitle text-secondary" do
              haml_concat ticker_symb[:name]
            end
          end
        #end
      end
        haml_tag :div, :class => "card-body" do
          haml_tag :p, :class => "card-text" do
            haml_concat ticker_symb[:up_down]
          end
        end
        haml_tag :div, :class => "list-group list-group-flush" do
          haml_tag :a, :href => "#", :class => "list-group-item btn btn-danger btn-sm btn-block" do
            haml_concat "News Link"
          end
          haml_tag :a, :href => "#", :class => "list-group-item btn btn-danger btn-sm btn-block" do
            haml_concat "News Link"
          end
          haml_tag :a, :href => "#", :class => "list-group-item btn btn-danger btn-sm btn-block" do
            haml_concat "News Link"
          end
        end
        haml_tag :div, :class => "card-footer text-muted" do
          haml_concat "last updated: " + ticker_symb[:latest_update]
        end
    end
  end
end
