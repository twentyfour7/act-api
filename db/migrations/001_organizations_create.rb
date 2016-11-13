# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:organizations) do
      primary_key :id

      String :org_id
      String :name
      String :url
    end
  end
end
