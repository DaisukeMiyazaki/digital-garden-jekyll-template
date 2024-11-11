# Turns ![[ media/public/2024-03-17 15.46の画像.jpg ]] in Markdown to <img src={{ site.baseurl }}/assets/media/public/2024-03-17%2015.46%E3%81%AE%E7%94%BB%E5%83%8F.jpg> in output HTML

class MediaFileGenerator < Jekyll::Generator
  safe true
  priority :high

  def generate(site)
    return if !site.config["media_formatter"]

    all_notes = site.collections['notes'].docs
    all_docs = all_notes


    all_docs.each do |current_note|
      # from a current file, grab media files that are included
      attached_files = current_note.content.scan(/!\[\[\s*media\/(.*?)\s*\]\]/).flatten
      # puts attached_files # debug

      # now convert these media files to image HTML tags
      attached_files.each do |file|
        current_note.content.gsub!(
          /!\[\[\s*media\/#{file}\s*\]\]/,
          "<img src='{{ site.baseurl }}/assets/media/#{file}'>"
        )
      end
    end
  end
end
