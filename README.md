## Task: News Application Development

### Objective
The objective of this task was to develop a mobile news application that fetches data from the Hacker News API. The application was required to provide users with access to "Top News" and "Latest News" categories, displaying a list of news items in each category. Additionally, users should be able to view detailed information about each news item.

### Problems and Solutions

#### Design
Before developing any application, it is essential to have a well-thought-out design. I designed a basic application that meets the requirements of displaying "Top News" and "Latest News" categories.

Here’s the Figma link: [Figma Design](https://www.figma.com/design/FnIxZfLBntTfRiVq8qb4sT/Untitled?node-id=0%3A1&t=Wcqqy8Kir6cCHBpE-1)

#### Creating the App
There are multiple frameworks and approaches for creating a mobile application, such as Flutter, React Native, or native development using Java. Being a Flutter developer, I chose Flutter to create this application.

### Approach to Creating the Application

#### Dependencies Used
To work with Flutter effectively, I included several dependencies in the project:

1. **flutter_screenutil**: This dependency is used to make the application responsive to any screen size.
2. **http**: This dependency is essential for fetching data from the internet or API sources.
3. **intl**: The Hacker News API provides timestamps in Unix format. This dependency helps convert Unix time to a human-readable format.
4. **url_launcher**: This is used to open news articles in an external browser.

### Application Structure

#### HomePage
The HomePage of the application is designed to fetch and display both "Top News" and "Latest News" categories.

1. **Fetching News Stories**:
   - Two methods are used to fetch top and latest stories from the Hacker News API.
   - Data is fetched using the http package and displayed using setState to update the UI.

2. **NewsPortalCard**:
   - A reusable widget to display individual news items, including title, author, date, and a clickable URL.

### Features

1. **Top News and Latest News Categories**:
   - The application provides separate sections for "Top News" and "Latest News" fetched from the Hacker News API.

2. **Detailed News Information**:
   - Users can view detailed information about each news item, including the author, publication date, and the article itself by clicking on the news card.

3. **Responsive Design**:
   - Utilized the `flutter_screenutil` package to ensure the application is responsive and looks good on various screen sizes and resolutions.

4. **Real-Time Data Fetching**:
   - The application fetches the latest data each time the user visits the HomePage or refreshes the content.

5. **External Article Viewing**:
   - By using the `url_launcher` package, users can open the news articles in their default web browser for a full read.

### Future Enhancements

1. **User Authentication**:
   - Implement user authentication to personalize the news feed based on user preferences.
   
2. **Offline Reading**:
   - Add functionality to save articles for offline reading.
   
3. **Push Notifications**:
   - Implement push notifications to alert users of breaking news.
   
4. **Enhanced Search**:
   - Add a search feature to allow users to find specific news articles quickly.

### Conclusion

This document outlines the design, approach, and implementation of the news application. The application effectively fetches and displays top and latest news stories from the Hacker News API, providing users with a seamless news reading experience. The choice of Flutter as the development framework ensures a responsive and performant application, and the use of various dependencies enhances the overall functionality.
