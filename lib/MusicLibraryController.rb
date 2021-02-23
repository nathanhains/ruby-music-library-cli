class MusicLibraryController
    def initialize(path = './db/mp3s')
        @path = path
        new_import = MusicImporter.new(@path)
        new_import.import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = nil
        until input == "exit"
            input = gets.strip
            if input == "list songs"
                self.list_songs
            elsif input == "list artists"
                self.list_artists
            elsif input == "list genres"
                self.list_genres
            elsif input == "list artist"
                self.list_songs_by_artist
            elsif input == "list genre"
                self.list_songs_by_genre
            elsif input == "play song"
                self.play_song  
            end
        end
    end

    def list_songs
        sorted_songs = Song.all.sort_by{|songs| songs.name}
        sorted_songs.each_with_index do |songs, index|
            puts "#{index+1}. #{songs.artist.name} - #{songs.name} - #{songs.genre.name}"
        end
    end

    def list_artists
        sorted_artists = Artist.all.sort_by{|artist| artist.name}
        sorted_artists.each_with_index do |artist, index|
            puts "#{index+1}. #{artist.name}"
        end
    end

    def list_genres
        sorted_genres = Genre.all.sort_by{|genre| genre.name}
        sorted_genres.each_with_index do |genres, index|
            puts "#{index+1}. #{genres.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        unsorted_songs = Song.all.select{|song| song.artist.name == input}
        sorted_songs = unsorted_songs.sort_by{|songs| songs.name}
        sorted_songs.each_with_index do |songs, index|
            puts "#{index+1}. #{songs.name} - #{songs.genre.name}"
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        songs_by_genre = Song.all.select{|song| song.genre.name == input}
        songs_by_genre_sorted = songs_by_genre.sort_by{|songs| songs.name}
        songs_by_genre_sorted.each_with_index do |songs, index|
            puts "#{index+1}. #{songs.artist.name} - #{songs.name}"
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip    
        sorted_songs = Song.all.sort_by{|songs| songs.name}
        if input.to_i > 0 && input.to_i <= sorted_songs.length
            puts "Playing #{sorted_songs[input.to_i-1].name} by #{sorted_songs[input.to_i-1].artist.name}"
        end
    end

end