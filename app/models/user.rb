class User < ActiveRecord::Base
	acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :things

  def creative_score
  	score = 0;
  	things.each do |thing|
  		score+= thing.get_upvotes(:vote_scope => "creative").count
  	end
  	return score
  end
  

  def inpiring_score
  	score = 0;
  	things.each do |thing|
  		score+= thing.get_upvotes(:vote_scope => "inspiring").count
  	end
  	return score

  end

  def beauty_score
  	score = 0;
  	things.each do |thing|
  		score+= thing.get_upvotes(:vote_scope => "beauty").count
  	end
  	return score

  end

end
