require 'yaml/store'
require 'date'

file_with_know_phones = './phones.yml'
@store = YAML::Store.new(file_with_know_phones)

def load_file file_name
  begin
    YAML.load_file file_name
  rescue
    puts "Can't find 'phones.yml'"
    {}
  end
end

def add_new_phone_number
	puts "Enter phone (4+ numbers): "
	new_phone = gets.chomp.to_s
	puts "Enter comment: "
	new_phone_comments = gets.chomp.to_s

  if new_phone.length < 4
		puts "Wrong number format!!!"
	else
    @phones[new_phone] = new_phone_comments

	d = DateTime.now
	
    @store.transaction do
        @store[new_phone] = [new_phone_comments, d.strftime("%d/%m/%Y %H:%M")]
    end
  end
end

@phones = load_file file_with_know_phones

loop do
	print ":"
	find_number = gets.chomp.downcase

	if find_number == 'n'
        add_new_phone_number
        redo
	elsif find_number == 'q'
		break
	end

	@phones.select do |phone, record|
		if phone =~ /#{find_number}/i
			puts "Ahtung!!! #{phone} #{record[0]}, #{record[1]}"
		end
	end
end


