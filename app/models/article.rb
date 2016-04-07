class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  def tag_list
    tags.join(", ")
  end

  def tag_list=(tags_string)
    names = tags_string.split(",").map{|s| s.strip.downcase}.uniq
    new_or_found_tags = names.map do |name|
      Tag.find_or_create_by(name: name)
    end
    self.tags = new_or_found_tags
  end
end
