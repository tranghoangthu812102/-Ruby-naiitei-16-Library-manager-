namespace :update_deadline do
  desc "Daily update deadline"
  task run: :environment do
    requests = Request.all
    requests.each do |request|
      request.expired! if request.date_end.past? && !request.returned?
    end
  end
end
