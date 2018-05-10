require 'open-uri'
require 'zip'

class Tasks::JapanPost

  def self.download_zipcodes_file
    delete_files(['public/KEN_ALL.CSV', 'public/ken_all.zip'])
    download_and_save("public/", "http://www.post.japanpost.jp/zipcode/dl/oogaki/zip/ken_all.zip")
    unzip_file("public/", "ken_all.zip")
  end

  private

    def self.delete_files(delete_files)
      delete_files.each do |file|
        File.delete file
      end
    end

    def self.download_and_save(dir_path, url_path)
      fileName = File.basename url_path
      open(dir_path + "#{fileName}", 'wb') do |output|
        open(url_path) do |data|
          output.write(data.read)
        end
      end
    end

    def self.unzip_file(dir_path, file_name)
      Zip::File.open(dir_path + file_name) do |zip|
        zip.each do |entry|
          # { true } は展開先に同名ファイルが存在する場合に上書きする指定
          zip.extract(entry, dir_path + entry.name) { true }
        end
      end
    end

end
