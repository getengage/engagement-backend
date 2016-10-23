every :day, :at => '12:00am', :roles => [:app] do
  runner "Event::ScoresJob.perform_later"
end