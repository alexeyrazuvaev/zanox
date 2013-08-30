require_relative '../lib/zanox.rb'

Zanox::API::Session.connect_id = 'your connect id'
Zanox::API::Session.secret_key = 'your secret key'

def show(items, *args)
  puts "\nFound items: "+items.size.to_s+"\n"
  items.each do |item|
    line = ""
    args.each do |arg|
      if(arg.is_a?(Symbol)) 
        if(item.respond_to?(arg))
          line.concat(item.method(arg).call)
        end
      elsif(arg.is_a?(String))
        line.concat(arg)
      end
    end
    puts line
  end
end

# PRODUCTS #
############

puts "\nPRODUCTS"

# find products by keywords
products = Zanox::Product.find('ipod')
show products, "Product ", :id, "\t\"", :name, "\" - ", :price, " ", :currency
# or find specific product by id
product_id = products[0].id
products = Zanox::Product.find(product_id)
show products, "Product ", :id, "\t\"", :name, "\" - ", :price, " ", :currency

# ADSPACES #
############

puts "\nADSPACES"

# find all your Adspaces
adspaces = Zanox::Adspace.find(:all)
show adspaces, "Adspace ", :id, "\t\"", :name, "\""

# or find specific Adspace by id
adspace_id = adspaces[0].id
adspaces = Zanox::Adspace.find(adspace_id)
show adspaces, "Adspace ", :id, "\t\"", :name, "\""

# PROGRAMS #
############

puts "\nPROGRAMS"

# find zanox programs by keywords
programs = Zanox::Program.find('amazon')
show programs, "Program ", :id, "\t\"", :name, "\""

# or find specific zanox programs by id
program_id = programs[0].id
programs = Zanox::Program.find(program_id)
show programs, "Program ", :id, "\t\"", :name, "\""

# or find programs that are registered with one of your Adspaces
programs = Zanox::ProgramApplication.find(:adspaceId => adspace_id)
show programs, "Program Application ", :id, "\t\"", :status, "\""

# SALES #
#########

puts "\nSALES"

# find a sale by date
date = "2010-03-02T00:00:00"
sales = Zanox::Sale.find(:date=>date, :dateType=>'trackingDate')
show sales, "Sale ", :id, " ", :commission, " EUR - ", :reviewState

# get zpar
#sales[0].gpps.gpp.each do |gpp|
#  puts gpp.xmlattr_id + " = " + gpp
#end

# MEDIASLOTS #
##############

puts "\nMEDIASLOTS"

# find all your MediaSlots
mediaslots = Zanox::MediaSlot.find(:all, :items=>99)
show mediaslots, "MediaSlot ", :id, " \"", :name, "\""
# or find a specific MediaSlot
mediaslot_id = mediaslots[0].id
mediaslots = Zanox::MediaSlot.find(mediaslot_id)
show mediaslots, "MediaSlot ", :id, " \"", :name, "\""
# or find Mediaslots by adspace id
mediaslots = Zanox::MediaSlot.find(:adspaceId=>adspace_id, :items=>99)
show mediaslots, "MediaSlot ", :id, " \"", :name, "\""
