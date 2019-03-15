#name of our team - Implement SOMETHING
Feature: Add Records To Table
@DataStorage('AddRecordToTable.json')	
Background: 
	Given I navigate to test page
Scenario Outline: 01 - Enter valid values to the table
	Given I set values on form
		| Field         | Value    |
		| First Name    | Vasya    |
		| Last Name     | Markov   |
		| Date of birth | 04.08.96 |
		| Gender        | Male     |
	When I click [submit] the record
	Then fields displayed in the table
		| Field     | Value      |
		| Full name | Vasya Name |
		| Age       | 22         |
		| Sex       | M          |
Scenario Outline: 02 - Blanked values can't be entered
	Given I set values on form
		| Field         | Value            |
		| First Name    | <FirstNameValue> |
		| Last Name     | <LastNameValue>  |
		| Date of birth | <AgeValue>       |
		| Gender        | <Male>           |
		When I submit the form
		Then error field empty 
Examples: 
		| FirstNameValue | LastNameValue | AgeValue     | 
		| abc            | Blank         | YestedayDate |
		| Blank          | abc           | YestedayDate | 
		| abc            | abc           | Blank        |
Scenario Outline: 03 - Age can't be negative
	Given I set values on form
		| Field         | Value            |
		| First Name    | <FirstNameValue> |
		| Last Name     | <LastNameValue>  |
		| Date of birth | <AgeValue>       |
	When I submit the form
	Then error negative age entered
Examples: 
		| FirstNameValue | LastNameValue | AgeValue     |
		| abc            | Blank         | YestedayDate |
		| Blank          | abc           | YestedayDate |
		| abc            | abc           | Blank        |
		| abc            | abc           | TommorowData |
Scenario: 04 - Cancel button clear out all the field
	Given I set values on form
		| Field         | Value    |
		| First Name    | adss     |
		| Last Name     | abc      |
		| Date of birth | 12.12.93 |
	When I canceled the form
	Then all field is empty
		| Field         | Value |
		| First Name    | Blank |
		| Last Name     | Blank |
		| Date of birth | Blank |
		| Sex           | M     |
Scenario Outline: 05 - Duplicated input can't be entered
	Given I set values on form
		| Field         | Value    |
		| First Name    | Vasya    |
		| Last Name     | Markov   |
		| Date of birth | 04.08.96 |
		| Gender        | Male     |
	And I submit the form
	When I set value in form
		| Field         | Value            |
		| First Name    | <FirstNameValue> |
		| Last Name     | <LastNameValue>  |
		| Date of birth | <AgeValue>       |
	And I submit the form
	Then table has record
	| Full name        | Age             | Sex |
	| Vasya Markov     | 04.08.96        | M   |
	| <FirstNameValue> | <LastNameValue> | M   |
Examples: 
	| FirstName | LastName | DateOfBirth   | Age            |
	| Vasya     | Markov   | Today-2years  | CurrentYear -2 |
	| 213       | 312      | YesterdayDate | CurrentYear    |

Scenario: 06 - The hole role can't have duplicated data
