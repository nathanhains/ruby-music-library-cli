class Genre
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
        genre = self.new(name)
        @@all << genre
        @@all = @@all.uniq
        genre
    end

    def songs
        @songs
    end

    def artists
        genre_songs = Song.all.select {|song| song.genre == self}
        artists = genre_songs.map {|song| song.artist}
        artists.uniq
    end

end