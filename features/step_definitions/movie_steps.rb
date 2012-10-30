# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    @movie = Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  first_position = page.body.index(e1)
  second_position = page.body.index(e2)
  first_position.should < second_position
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list = rating_list.gsub("'", "").gsub("\"", "")
  ratings = rating_list.split(/[\s,]+/)
  
  case uncheck
  when nil
    ratings.each do |rating|
      steps %Q{
        When I check "ratings_#{rating}"
      }
    end

  when 'un'
    ratings.each do |rating|
      steps %Q{
        When I uncheck "ratings_#{rating}"
      }
    end
  end
  
end

When /I should see the following ratings are (not )?visible: (.*)/ do |no, rating_list|
  rating_list = rating_list.gsub("'", "").gsub("\"", "")
  ratings = rating_list.split(/[\s,]+/)
  
  case no
    
  when nil
    ratings.each do |rating|
      result = false
      txt = "//table[@id='movies']/tbody//td[2]"
      page.all(:xpath, txt).each do |element|
        if rating == element.text
          result = true
        end
      end
      result.should be_true
    end

  when 'not '
    ratings.each do |rating|
      txt = "//table[@id='movies']/tbody//td[2]"
      page.all(:xpath, txt).each do |element|
        rating.should_not == element.text 
      end
    end
  end
  
end


Then /I should see all of the movies/ do
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  rows = page.all('tr').size
  rows.should == 11
end
