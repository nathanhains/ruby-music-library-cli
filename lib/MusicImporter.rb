class MusicImporter
    def initialize(path)
        @path = path
    end

    def path
        @path
    end

    def files
        array_songs = Dir.entries(self.path)
        array_songs.slice(2..6)
    end

    def import
        self.files.each do |files|
            Song.create_from_filename(files)
        end
    end
end