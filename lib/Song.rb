class Song
    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []
    def initialize(name, artist = nil, genre = nil)
        @@all << self
        @name = name
        @artist = artist
        if artist != nil
            self.artist= @artist
        end
        @genre = genre
        if genre != nil
            self.genre= @genre
        end
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
        song = self.new(name)
        @@all << song
        @@all = @@all.uniq
        song
    end

    def artist=(artist)
        @artist = artist
        @artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        if genre.songs.include?(self) == false
            genre.songs << self
        end
    end

    def self.find_by_name(song_name)
        self.all.detect{|song| song.name == song_name}
    end

    def self.find_or_create_by_name(song_name)
        if self.find_by_name(song_name)
            self.find_by_name(song_name)
        else
            self.create(song_name)
        end
    end

    def self.new_from_filename(file_name)
        file_array = file_name.split(" - ")
        song =  Song.find_or_create_by_name(file_array[1])
        artist = Artist.find_or_create_by_name(file_array[0])
        genre = Genre.find_or_create_by_name(file_array[2].split(".")[0])
        song.artist = artist
        song.genre = genre
        song
    end

    def self.create_from_filename(file_name)
        self.new_from_filename(file_name)
    end

end