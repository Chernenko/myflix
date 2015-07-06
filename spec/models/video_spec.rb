require 'spec_helper'
describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)} 
  it { should have_many(:reviews).order("created_at DESC")}

describe "search_by_title" do

  it "returns an empty array if there is no match" do
    futurama = Video.create(title: "Futurama" , description: "Space travel")
    back_to_future = Video.create(title: "Back to future " , description: "Time travel")
    expect(Video.search_by_title("hello")).to eq([]) 
  end

  it "returns an array of one video for an exact match" do 
    futurama = Video.create(title: "Futurama" , description: "Space travel")
    back_to_future = Video.create(title: "Back to future " , description: "Time travel")
    expect(Video.search_by_title("Futurama")).to eq([futurama]) 
  end

  it "returns an array of one video for an partial match" do 
    futurama = Video.create(title: "Futurama" , description: "Space travel")
    back_to_future = Video.create(title: "Back to future " , description: "Time travel")
    expect(Video.search_by_title("urama")).to eq([futurama]) 
  end

  it "returns an array of all  matches ordered by creates_at" do 
    futurama = Video.create(title: "Futurama" , description: "Space travel", created_at: 1.day.ago)
    back_to_future = Video.create(title: "Back to Future " , description: "Time travel")
    expect(Video.search_by_title("Futur")).to eq([back_to_future,futurama]) 
  end

  it "returns an empty array for empty string " do 
    futurama = Video.create(title: "Futurama" , description: "Space travel", created_at: 1.day.ago)
    back_to_future = Video.create(title: "Back to Future " , description: "Time travel")
    expect(Video.search_by_title(" ")).to eq([]) 
  end
end
end


