require 'pry'

class Genre
    attr_accessor :name, :songs
    extend Concerns::Findable
    @@all = []
    def initialize(name)
        self.name = name
        self.save
        self.songs = []
    end

    def save
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(genre)
        self.new(genre)
    end

    def artists
        self.songs.collect do |song|
            # binding.pry
            song.artist
        end.uniq
    end
end