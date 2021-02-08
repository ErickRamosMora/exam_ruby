require "uri"
require "net/http"
require "json"

def request(url,token = nil)
    #url_string = ("#{url}?sol=1&api_key=#{token}")
    url = URI("#{url}?sol=1&api_key=#{token}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.read_body)
end

def build_web_page(info_hash)
    File.open("nasa_index.html", "w") do |file|
        file.puts("<html>")
        file.puts("<head><title>Mars Rover Photos</title></head>")
        file.puts("<ul>")
        info_hash["photos"].each do |photo|
            file.puts("<li>" "<img src='#{photo["img_src"]}'width='500'>" "</li>") 
        end
        file.puts("</ul>")
        file.puts("</body>")
        file.puts("</html>")
    end
end

nasa_hash = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos", "iWLD49ty644G5wMwfVkMfIYeg9zRqRRi3JlmBjJV") 

puts build_web_page(nasa_hash) 
