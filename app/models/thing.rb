class Thing < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  belongs_to :user
  # has_many :votes


  def ancestors
  	if(parent_id)
  		p = Thing.find(parent_id)
  		return p.ancestors << self
  	else
  		return [self]
  	end

  end

  def children
  	mychildren = Thing.where("parent_id = ?", self.id)
	if(mychildren.count>0)
		mychildren.each do |child|
			return child.children << self
		end
	else
		return [self]
	end
  end
end
