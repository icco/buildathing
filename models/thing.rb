class Thing
  attr_accessor :text, :date

  def <=>(other)
    return self.date <=> other.date
  end

  def self.get date
    return self.all.select {|s| s.date.strftime("%F").eql? date.strftime("%F") }.first
  end

  def self.latest
    self.all.sort[-1]
  end

  def self.all
    things = JSON.parse(File.read(Padrino.root('public/things.json')))
    things.map! do |thing|
      t = Thing.new
      t.date = Chronic.parse(thing["date"])
      t.text = thing["thing"]
      t
    end
    return things
  end
end
