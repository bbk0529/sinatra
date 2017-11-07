#block
#1. {}
#2. do~end

phone_book = {
    "John" => "2856123412",
    "Bk" => "1929382938",
    "Katie" => "23423412"
}

arr = ["bk", "katie","jackson"]

phone_book.each {|key| puts key}


#for multiple rows, do ~ end syntax should be good
arr.each do |name| 
    puts name
    puts "입니다"
    
end

def hey
        puts "hack"
        yield
    end

phone_book.each {puts "hahaha"}

