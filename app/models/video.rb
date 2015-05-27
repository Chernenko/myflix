class Video < ActiveRecord::Base;
  belongs_to :category
  validates_presence_of :title, :description
  has_many :reviews
  
  def self.search_by_title(search_term)
    if search_term.blank?
      return []
    else
      where("title ILIKE? ", "%#{search_term}%").order("created_at DESC")
      end
    end
end




