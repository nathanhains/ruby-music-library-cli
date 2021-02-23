class Artist
    extend Concerns::Findable
    attr_accessor :name
    @@all = []
    def initialize(name)
        @@all << self
        @name = name
        @songs = []
        @@all = @@all.uniq
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end

    def save
        @@all << self
    end

    def self.create(name)
        artist = self.new(name)
        @@all << artist
        @@all = @@all.uniq
        artist
    end

    def songs
        @songs
    end

    def add_song(song)
        if song.artist == nil && @songs.include?(song) == false
            song.artist = self
            @songs << song
        end
    end

    def genres
         artist_songs = Song.all.select{|songs| songs.artist ==self}
         array = artist_songs.map {|song| song.genre}
         array.uniq
    end
        
end