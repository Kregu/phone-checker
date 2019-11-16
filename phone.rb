require 'yaml'

file_with_know_phones = './phones.yml'

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
  	File.open("phones.yml", "w") do |file|
  	  file.write @phones.to_yaml
    end
  end
end

@phones = load_file file_with_know_phones

loop do
	print ":"
	find_number = gets.chomp.downcase

	if find_number == 'n'
		add_new_phone_number
	elsif find_number == 'q'
		break
	end

	@phones.select do |phone, comment|
		if phone =~ /#{find_number}/i
			puts "Ahtung!!! #{phone} #{comment}"
		end
	end
end


