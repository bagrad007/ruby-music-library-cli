class MusicImporter
    attr_accessor :path
    def initialize(path)
        self.path = path
    end

    def files
        @files = Dir.glob("#{self.path}/*.mp3").collect{ |file| file.gsub("#{self.path}/","")}
    end

    def import
        self.files.each do |file|
            Song.create_from_filename(file)
        end
    end
end