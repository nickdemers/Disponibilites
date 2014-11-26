require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the UtilisateursHelper. For example:
#
# describe UtilisateursHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe UtilisateursHelper do
  describe "get description poste" do
    it "with id and contain key" do
      description = get_description_poste("permanent")
      description.should eq("Professeur permanent")
    end
    it "without id" do
      description = get_description_poste(nil)
      description.should eq("")
    end
    it "not contain key" do
      description = get_description_poste("test")
      description.should eq("")
    end
  end
=begin
  describe "get description niveau" do
    it "with id and contain key" do
      description = get_description_niveau(3)
      description.should eq("2e année")
    end
    it "without id" do
      description = get_description_niveau(nil)
      description.should eq("")
    end
    it "not contain key" do
      description = get_description_niveau(8)
      description.should eq("")
    end
  end
=end
end