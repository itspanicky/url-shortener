class RemoveShortCodeFromShortUrls < ActiveRecord::Migration[6.0]
  def change

    remove_column :short_urls, :short_code, :string
  end
end
