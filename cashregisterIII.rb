require 'csv'
require 'pry'
csv_file = 'products.csv'

def csv_data(file)
  # Instantiate an empty array
  products_arr = []
  # Create a counts variable
  counts = 0

  # run thru each line of our csv file and creata an array called row
  CSV.foreach(file, headers: true) do |row|
    # Instantiate an empty hash at the beginning of each loop
    products_hash = {}
    # Increment our counts variable by 1 so that we can have a product key when cashier enters info for product
    counts += 1
    # Set the keys and corresponding values
    products_hash[:prod_key] = counts
    products_hash[:SKU] = row[0]
    products_hash[:name] = row[1]
    products_hash[:wholesale_price] = row[2].to_f
    products_hash[:retail_price] = row[3].to_f

    # Append each individual hash to our products_arr
    products_arr << products_hash

  end
  # Return products array
  products_arr
end


def product_menu(get_csv_data)
  intro = "Welcome to James' Coffee Emporium"
  barrier = "="*intro.length

  puts "#{barrier}\n#{intro}\n#{barrier}\n"

  get_csv_data.each do |prod|
    puts "#{prod[:prod_key]}) Add Item - $#{prod[:retail_price]} - #{prod[:name]} "
  end
    puts "4) Add Item - Complete Sale"
end

def transactions(user_trans)
  user_trans.each do |trans|
    puts "$ #{trans[:item_total]} - #{trans[:quantity]} #{trans[:name]}"
  end
end


def tendered(price)
  print "What is the amount tendered: "
  payment = gets.chomp
  payment = payment.to_f

  # Is this amount enough?
  change = payment - price
  change = "%.2f" % change
  owed = price- payment
  owed = "%.2f" % owed
  time = Time.now.strftime("%Y-%m-%d %H:%M")

  if payment == price
    print "Have a nice day!"
  else
    if payment > price
      print "\n===Thank You!===\n The total change due is $#{change}\n\n #{time}\n\n"
    else
      print "WARNING: Customer still owes $#{owed}! Exiting..."
    end
  end
end

# Variable for our csv_data file
products = csv_data(csv_file)

# Calls our product_menu method
product_menu(products)

# Define variables
input = 0
total_trans = 0

# Prompt cashier for item 'id'
puts "Make a selection:"
input = gets.chomp.to_i

# Instantiate an empty array to store hashes of each transaction.
all_trans = []
while input != 4
  # Subtracts input by 1 to grab the proper index in our 'products_arr'
  prod_chosen = input - 1
  # Instantiate an empty hash to store info on single item transactions
  transactions = {}
  # Prompt user for desired total
  puts "Please enter the quantity:"
  quantity = gets.chomp.to_i
  # Grab retail price
  price = products[prod_chosen][:retail_price]
  # Calculated Quantity
  item_total = price * quantity
  total_trans += item_total
  # Add cashier input to a hash 'transactions'
  transactions[:quantity] = quantity
  transactions[:item_total] = item_total
  transactions[:name] = products[prod_chosen][:name]

  # Append to CSV
  CSV.open("transactions_history.csv", 'a+', headers: true) do |row|
    row << [products[prod_chosen][:SKU], quantity]
  end

  puts "Subtotal: $#{item_total}\n"
  all_trans << transactions
  puts "Make another selection:"
  input = gets.chomp.to_i
  # input = prompt_cashier.to_i
end

puts "===Sale Complete==="
# Calls ours transactions method which returns all values for our transactions done by customer
transactions(all_trans)

puts "\nTotal: #{total_trans}"

#takes our total_trans variable, which is the resultant price of the purchase and runs it thru our 'tendered' method
tendered(total_trans)
