require 'spec_helper'

describe QueueItem  do
  it { should belong_to (:user) }
  it { should belong_to (:video) }

  describe '#video_title' do
    it "it returns the title of the associated video" do
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, video: video) 
      expect(queue_item.video_title).to eq('Monk')
    end
  end

  describe '#rating'do

    it "returns the rating from the review when the review is present" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, video: video, user: user, rating: 5)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(5)
    end

    it "returns nil when the review is not present " do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe '#category_name' do
    it "returns the category name of the video" do
      category = Fabricate(:category, name: 'comedies')
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq ('comedies')
    end
  end

  describe '#category' do
    it "returns the category of the video" do
      category = Fabricate(:category, name: 'comedies')
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq (category)    
    end
  end
end