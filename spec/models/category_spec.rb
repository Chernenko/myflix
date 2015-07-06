require 'spec_helper'

describe Category do
  it {should have_many (:videos)}
  it { should validate_presence_of(:name) }


  describe '#recent_videos' do

    it'return the  videos in reverse chronological order by created at' do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama" , description: "Space travel", category: comedies, created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to future " , description: "Time travel", category: comedies)
      expect(comedies.recent_videos).to eq([back_to_future,futurama])
    end

    it'returns all the videos if there are less than 6 videos' do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama" , description: "Space travel", category: comedies, created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to future " , description: "Time travel", category: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end

    it 'returns 6 videos if there are more than 6 videos' do
      comedies = Category.create(name: "comedies")
      7.times{Video.create(title: "Futurama" , description: "Space travel", category: comedies)}
      expect(comedies.recent_videos.count).to eq(6)
    end

    it 'return the most recent 6 videos' do
      comedies = Category.create(name: "comedies")
      7.times{Video.create(title: "Futurama" , description: "Space travel", category: comedies)}
      back_to_future = Video.create(title: "Back to future " , description: "Time travel", category: comedies,created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(back_to_future)
    end

    it 'return an empty array if the category does not have any video' do
      comedies = Category.create(name: "comedies")
      expect(comedies.recent_videos).not_to include([])
    end
  end
end

