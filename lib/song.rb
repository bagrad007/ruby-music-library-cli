require_relative './concerns/findable'

class Song
    attr_accessor :name
    attr_reader :artist, :genre
    extend Concerns::Findable

    @@all = []
    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
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

    def self.create(song)
        created_songs = self.new(song)
        created_songs.save
        created_songs
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
       genre.songs << self unless genre.songs.include?(self)
    end

    def self.new_from_filename(filename)
        artist = filename.split(" - ")[0]
        song = filename.split(" - ")[1]
        genre = filename.split(" - ")[2].gsub(".mp3", "")
        new_artist = Artist.find_or_create_by_name(artist)
        new_genre = Genre.find_or_create_by_name(genre)

        self.new(song, new_artist, new_genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).tap{ |s| s.save }
    end

   
end