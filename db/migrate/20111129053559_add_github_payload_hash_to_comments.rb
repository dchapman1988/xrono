class AddGithubPayloadHashToComments < ActiveRecord::Migration
  def change
    add_column :comments, :github_payload_hash, :text
  end
end
