class Listing < ActiveRecord::Base
  if Rails.env.development?
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "no-available-image.png"
  else
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "no-available-image.png",
        :storage => :dropbox,
        :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
        :path => ":style/:id_:filename"
  end
   validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)
   validates :name, :description, :price, presence: true 

   belongs_to :user
end

#validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    #do_not_validate_attachment_file_type :image
    #no-available-image.png


