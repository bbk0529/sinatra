# $echo $PORT
# $echo $IP
require 'sinatra'
require 'httparty'
require 'nokogiri'
require 'magic_encoding'
require 'uri'
require 'date'
require 'csv'

get "/" do
    send_file 'index.html'
end


get "/lol" do
    erb:lol
end


get "/search" do
    
    @id = params[:userName]
    keyword= URI.encode(@id)
    # name=keyword.gsub(" ","+") #gsub = global substitution
    # uri = "http://www.op.gg/summoner/userName="  + name
    uri = "http://www.op.gg/summoner/userName="
    response = HTTParty.get(uri + keyword) 
    text = Nokogiri::HTML(response.body)
    @component=text.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div > div.TierRankInfo > div > span').text
    puts @component
    "#{@component}"
    
    # File.open('log.txt','a+') do |f| #a+ 는 파일이 없어도 만들어진다. 
    #     log="#{@id}, #{@component}" + Time.now.to_s.gsub("\t","").gsub("  "."").gsub("\n","")
    #     f.write(log+"\n")
    # end

    CSV.open('log.csv','a+') do |csv| 
        csv<<[@id, Time.now.to_s, @component.gsub("\n", " ").gsub("\t"," ").gsub(" ", "")]
    end
   
   erb :search #return 문과 비슷한 역할을 한다. 중간에 있으면 아래쪽 코드가 실행이 안된다. 

end



get "/log" do
    @log=[]
    CSV.foreach('log.csv') do |row|
            @log << row
    end
    erb :log
end
    
    

# get "/welcome" do
#     "Welcome !"    
# end

get '/lunch' do
    @pictures={"소고기"=> "http://kstatic.inven.co.kr/upload/2015/11/04/bbs/i13376870694.jpg",
                "참치회"=> "http://thumbnail.egloos.net/720x0/http://pds27.egloos.com/pds/201602/02/32/b0302632_56affbd51c948.jpg",
                "라면" => "http://photo.jtbc.joins.com/news/2017/05/19/20170519060211571.jpg"}
    
    @menu=@pictures.keys.sample
    erb :lunch
end

# 2.4.0 :012 > {}.respond_to?(:sample)
#  => false 


get '/lotto' do
    @numbers = (1..45).to_a.sample(6)
    erb :lotto
    
end

get "/welcome/:name" do
    "Welcome ! #{params['name']}"
end


get '/cube/:num' do
    input = "#{params['name']}"
   "#{params['num'].to_i**3}"
   "#{input}"
   
#   input=params[:num].to_i
#   result=input**3
#   "the result is #{result}"
    
end

#param이라는 hash안에 저장이 된다. 

#$ ruby app.rb -p $PORT -o $IP