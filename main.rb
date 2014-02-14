require 'tk'
@root = TkRoot.new do
	title "Portal User Setup GUI"
	myicon = TkPhotoImage.new('file' => 'myicon.gif')
	iconphoto(myicon)
	minsize(700,600)
end


TkLabel.new(@root) do
   text 'Company:'
   grid('row'=>0, 'column'=>0, 'sticky' => 'e')
end


$company_entry = TkEntry.new(@root)
$company_entry.grid('row'=> 0, 'column'=> 1)


TkLabel.new(@root) do
   text 'Service-Now ID:'
   grid('row'=>1, 'column'=>0, 'sticky'=>'w')
end


$servicenow_entry = TkEntry.new(@root)
$servicenow_entry.grid('row'=> 1, 'column'=> 1)


TkLabel.new(@root) do
   text 'Add User:'
   grid('row'=>2, 'column'=>0,'sticky'=>'e')
end

$user_cells = Array.new

@button_add_user = TkButton.new(@root)  
@button_add_user.configure('text' => '+')  
@button_add_user.command { add_user_cell }  
@button_add_user.grid('row'=>2, 'column'=>1, 'padx'=>0, 'pady'=>0, 'sticky' => 'w')


TkLabel.new(@root) do
   text 'FirstName:'
   grid('row'=>4, 'column'=>1)
end
TkLabel.new(@root) do
   text 'LastName:'
   grid('row'=>4, 'column'=>2)
end
TkLabel.new(@root) do
   text 'E-Mail:'
   grid('row'=>4, 'column'=>3)
end


$support_type = TkVariable.new

cust_type_radio1 = TkRadioButton.new(@root) {
  text 'Support'
  variable $support_type
  value 'Support'
  anchor 'w'
  state 'normal'
  grid('row'=> 2, 'column'=>5)
}


cust_type_radio2 = TkRadioButton.new(@root) {
  text 'Managed Services'
  variable $support_type
  value 'MSS'
  anchor 'w'
  state 'active'
  grid('row'=> 2, 'column'=>4)
}


$Check_Box_Support = TkCheckButton.new(@root) do
  text "Support"
  relief "groove"
  height 2
  width 12
  onvalue 'support_perms'
  grid('row'=>3,'column'=>4)
end


$Check_Box_Threat_Detect = TkCheckButton.new(@root) do
  text "Threat Detect"
  relief "groove"
  height 2
  width 12
  onvalue 'threat_detect_perms'
  grid('row'=>3,'column'=>5,)
end


$Check_Box_Threat_Protect_NoFM = TkCheckButton.new(@root) do
  text "Threat Protect\n no FM"
  relief "groove"
  height 3
  width 12
  onvalue 'threat_protect_no_fm_perms'
  grid('row'=>4,'column'=>4)
end


$Check_Box_Threat_Protect = TkCheckButton.new(@root) do
  text "Threat Protect"
  relief "groove"
  height 2
  width 12
  onvalue 'threat_protect_perms'
  grid('row'=>4,'column'=>5)
end

@rowval = 5
@colval1 = 1
@colval2 = 2
@colval3 = 3

@count_cell_num = 0


def add_user_cell
	
  @entry1var = TkVariable.new
	@entry2var = TkVariable.new
	@entry2var = TkVariable.new



	@entry1 = TkEntry.new(@root)
	@entry1.textvariable = @entry1var 
	@entry1.grid('row'=> @rowval, 'column'=> @colval1, 'sticky'=> 'nsew')
	
	
	@entry2 = TkEntry.new(@root)
	@entry2.textvariable = @entry2var
	@entry2.grid('row'=> @rowval, 'column'=> @colval2, 'sticky'=> 'nsew')

	@entry3 = TkEntry.new(@root)
	@entry3.textvariable = @entry3var
	@entry3.grid('row'=> @rowval, 'column'=> @colval3, 'sticky'=> 'nsew')
	@rowval = @rowval + 5
	
  entry_array = [@entry1,@entry2,@entry3]
  $user_cells.push(entry_array)
  p $user_cells.inspect
  
end


def create_csv
	p "Creating CSV File to run"
	p $Check_Box_Support.variable.value
	p $Check_Box_Threat_Detect.variable.value

	File.open("#{$company_entry.value}_create.csv", 'w') { |file| 
		
    $count = 0
    $num = 3
    while $count < $num do
    $user_cells.each do |array_cell_val|
      array_cell_val.each do |cell_val|
			file.write(cell_val.value)
			file.write(",")
      $count +=1
    end
  end
end
		file.write($company_entry.value)
		file.write(",")
		file.write($servicenow_entry.value)
    file.write(",")
    if $Check_Box_Support.onvalue != nil then file.write("17") end
    file.write($support_type.value)
    file.write("\n")
	}	

  p $user_cells.inspect
end


TkButton.new do  
  text "Create"  
  command { create_csv }  
  grid('row'=>99, 'column'=>5, 'sticky' => 'se')  
end 

TkButton.new do  
  text "EXIT"  
  command { exit }  
  grid('row'=>100, 'column'=>5, 'sticky' => 'se')  
end 

add_user_cell

Tk.mainloop





