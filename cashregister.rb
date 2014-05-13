##prompt: What is the total amt due?

puts "What is the amount due?"
price = gets.chomp
price = price.to_f

##How much did the customer give?

puts "What is the amount tendered?"
payment = gets.chomp.to_f



## is this amount enought?

change = payment - price
change = "%.2f" % change
owed = price - payment
owed = "%.2f" % owed

if payment == price
  puts "Have a nice day!"
else
  if payment > price
    puts ''
    puts "===Thank You!==="
    puts "The total change due is $#{change}"
    puts ''
    time=Time.new
    puts time.strftime("%m/%d/%Y %H:%M%p")

    puts '================'

  else
    puts "WARNING: Customer still owes $#{owed}! Exiting..."
  end
end




