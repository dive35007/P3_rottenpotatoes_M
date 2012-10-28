# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    print movie
    steps %Q{
      Given I am on the RottenPotatoes home page
      And   I follow "Add new movie"
      Then  I should be on the Create New Movie page
      When  I fill in "Title" with "#{movie['title']}"
      And   I select "#{movie['rating']}" from "Rating"
      When  I select "#{movie['release_date']}" from "movie_release_date" date
      And   I press "Save Changes"
    }
#     And I select "#{movie[release_date(1i)]}" from "Released On"
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk 'No implementado'
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  flunk 'No implementado'
end
