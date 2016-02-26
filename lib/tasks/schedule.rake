task :Schedule =>:environment do
  order = Order.new
order.name = 's'
  order.no_of_sheets = '23232323'
  order.sheet_type = "pdf"
  order.from_date = '2016-02-08'.to_date
  order.to_date = '2016-02-08'.to_date
  order.user_id  = 3 
  order.save!
  Delayed::Job.enqueue SendEmailsJob.new(order)
end