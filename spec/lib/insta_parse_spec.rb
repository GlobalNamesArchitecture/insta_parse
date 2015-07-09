describe InstaParse do
  subject = {InstaParse}

  describe ".version" do
    it "returns version" do
      expect(subject.version).to =~ /[\d]+\.[\d]+\.[\d]/
    end
  end

end
