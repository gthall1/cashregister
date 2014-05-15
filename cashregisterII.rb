def total_amt(sales)
  total = 0
  sales.each do |price|
    total = total + price
  end
  total.to_f
  total = "%.2f" % total
end


puts "What is the sale price?"
subtotal = gets.chomp
sales = []



until subtotal == "done"
  sales << subtotal.to_f
  puts "Subtotal: $#{total_amt(sales)}"
  puts "What is the sale price?"
  subtotal = gets.chomp

end


price = total_amt(sales)
price = price.to_f
#price = "%.2f" % price

if subtotal == "done"
  puts ''
  puts "Here are your item prices:"
  puts ''
  sales.each do |price|
    puts  "$#{"%.2f" % price}"
  end
  puts ''
    puts "The total amount due is $#{total_amt(sales)}"
end


##code from part 1

#puts "What is the amount due?"
#price = gets.chomp


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




