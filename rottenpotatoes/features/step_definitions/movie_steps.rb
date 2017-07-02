# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    movie_exists = Movie.where('title = :title').count
    if movie_exists > 0
      movie_exists.destroy
    end
      
    Movie.create(movie)  
  end
  #fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #fail "Unimplemented"

  regexp = /#{e1}.*#{e2}/m
  expect(page.body).to match(regexp)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #fail "Unimplemented"

  ratings = rating_list.split(',')
  ratings.each do |x|
    rating = x.strip.delete('\"')
    if uncheck.nil?
      check("ratings_" + rating)
    else
      uncheck("ratings_" + rating)
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  #fail "Unimplemented"

  if expect(page).to have_css("table#movies tr", :count => Movie.count+1)
    true
  else
    false
  end
end
