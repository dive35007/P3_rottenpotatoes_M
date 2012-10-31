Feature: Uso de session para recordar selecciones de filtrado y ordenación
 
  As an avid moviegoer
  So that I can quickly browse movies based on my preferences
  I want to see movies sorted by title or release date

Background: movies have been added to database
  
  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And I am on the RottenPotatoes home page

Scenario: sort movies alphabetically
  When I follow "Movie Title"
  Then I check the following ratings: "G", "R"
  Then I uncheck the following ratings: 'PG-13', "PG"
  And  I press "Refresh"
  Then I follow "More about Amelie"
  Then I follow "Back to movie list"
  Then I should see "Aladdin" before "When Harry Met Sally"
  Then I should see the following ratings are visible: "G", "R"
  Then I should see the following ratings are not visible: 'PG-13', "PG"

Scenario: sort movies in increasing order of release date
  When I follow "Release Date"
  Then I check the following ratings: "G", "R"
  Then I uncheck the following ratings: 'PG-13', "PG"
  And  I press "Refresh"
  Then I follow "More about Amelie"
  Then I follow "Back to movie list"
  Then I should see "The Terminator" before "Amelie"
  Then I should see the following ratings are visible: "G", "R"
  Then I should see the following ratings are not visible: 'PG-13', "PG"
  
Scenario: Use last session with no ratings selected
  When I uncheck the following ratings: 'PG', "G", "NC-17"
  And  I press "Refresh"
  When I uncheck the following ratings: "PG-13", "R"
  And  I press "Refresh"
  Then I should see the following ratings are visible: "PG-13", "R"

  
  
  
