class RenameContentToMarkdownContent < ActiveRecord::Migration[7.2]
  def change
    rename_column :posts, :content, :markdown_content
  end
end
