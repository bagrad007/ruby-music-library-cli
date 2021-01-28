require 'pry'

class Artist
    attr_accessor :name, :songs
    extend Concerns::Findable
    @@all = []
    def initialize(name)
        self.name = name
        self.songs = []
        self.save
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

    def self.create(artist)
        self.new(artist)
    end

    def add_song(song)
        if song.artist != self
            song.artist = self
        end
        self.songs << song unless songs.include?(song)
    end

    def genres
        songs.collect do |song|
            song.genre
        end.uniq
    end



end