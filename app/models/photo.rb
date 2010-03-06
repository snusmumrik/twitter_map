class Photo < ActiveRecord::Base
  belongs_to :product

  has_attachment :content_type => :image, 
                 :max_size => 5.megabytes,
                 :resize_to => '500x500>',
                 :thumbnails => { #:small => '30x30>',
                                  :thumb => '100x100>' 
                                },
                 :path_prefix => 'public/photos',
                 # Uses public/#{table_name} by default for the filesystem, and just #{table_name} for the S3 backend.
                 :storage => :file_system

  validates_as_attachment

  def full_filename(thumbnail = nil)
    file_system_path = (thumbnail ? thumbnail_class : self).attachment_options[:path_prefix].to_s
    File.join(RAILS_ROOT, file_system_path, *partitioned_path(thumbnail_name_for(thumbnail)))
  end
end