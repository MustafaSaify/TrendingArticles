# TrendingArticles

A Simple app to fetch and display most populat articles from New York Times.


## Code Overview

The app consists of below modules

- Scenes:
    - Articles List - Fetches and displays the most popular articles.
    - Article Details - Display details of an article.

- Networking Module : 
    - Responsible for making network request.


## Architecture Design Pattern

The app is architected using the Clean Architecture VIP  (View Interactor Presenter). Its an extended version of VIPER with below strenghts:
  - Easy to maintain and fix bugs.
  - Enforces modularity to write shorter methods with a single responsibility.
  - Nice for decoupling class dependencies with established boundaries.
  - Extracts business logic from view controllers into interactors.
  - Nice to build reusable components with workers and service objects.
  - Encourages to write factored code from the start with fast and maintainable unit tests.
  - Applies to existing projects of any size.
  - Modular: Interfaces may be easy to change without changing the rest of the system due to using protocol conformant business logic.
  - Independent from the database.



## Testability

- Added unit tests with a code coverage of around 86%.
<img width="1169" alt="Screen Shot 2022-10-25 at 10 46 36 PM" src="https://user-images.githubusercontent.com/5484993/197856550-d97e23ec-764a-4696-8dce-b7c7849fd88b.png">



## How to run Tests
- Checkout the code.
- Open terminal and run bundle update to install fastlane and xcov.
- Run fastlane unit_tests to run all unit tests.

## How to generate code coverage
- Run fastlane xcov in terminal
- Check the coverage report under xcov_output folder.


## Future Enhancements:
- Move the api_key to gitsecret.
- An UI to allow the users to change the fetch articles duration (daily, weekly, monthly)
- Recreate UI using SwiftUI.
- Use async/await to make network calls.

## Known Issues:
- xcov (using fastlane) is failing to report code coverage.
- The link on ArticlesDetails page is not tapable.
