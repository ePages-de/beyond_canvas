# frozen_string_literal: true

class BeyondCanvasCreate<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= table_name %><%= primary_key_type %> do |t|
<%= migration_data -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps null: false
    end

    add_index :<%= table_name %>, :encrypted_beyond_api_url_iv,       unique: true
    add_index :<%= table_name %>, :beyond_api_url_bidx,               unique: true
    add_index :<%= table_name %>, :encrypted_beyond_access_token_iv,  unique: true
    add_index :<%= table_name %>, :encrypted_beyond_refresh_token_iv, unique: true
  end
end
