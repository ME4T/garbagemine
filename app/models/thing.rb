class Thing < ActiveRecord::Base
	acts_as_votable
 	has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
 	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
 	belongs_to :user
 	# has_many :votes


	filterrific(
	  default_settings: { sorted_by: 'score' },
	  filter_names: [
	    :search_query,
	    :score,
	    :sorted_by,
	    :with_country_id,
	    :with_created_at_gte
	  ]
	)

	scope :sorted_by, lambda { |sort_option|
	  # extract the sort direction from the param value.
	  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
	  case sort_option.to_s
	  when /^created_at_/
	    # Simple sort on the created_at column.
	    # Make sure to include the table name to avoid ambiguous column names.
	    # Joining on other tables is quite common in Filterrific, and almost
	    # every ActiveRecord table has a 'created_at' column.
	    order("things.created_at #{ direction }")

	  when /^score/
	  else
	    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
	  end
	}
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
	

	def score
		return get_upvotes(:vote_scope => "inspiring").count + get_upvotes(:vote_scope => "creative").count + get_upvotes(:vote_scope => "beautiful").count
	end



end
