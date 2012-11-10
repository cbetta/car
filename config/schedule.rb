set :output, {:error => 'log/whenever-err.log', :standard => 'log/whenever-stdout.log'}

every 1.minute do
  rake "location:load_current"
end

every 1.day, :at => "4 am" do
  rake "location:load_past"
end
