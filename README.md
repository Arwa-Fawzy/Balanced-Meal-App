# Balanced Meal Ordering App

This repository documents the development of a balanced meal ordering application built using FlutterFlow. The app helps users calculate their daily caloric needs based on personal attributes and enables them to build a custom meal plan by selecting ingredients from different food categories. The project was developed to explore low-code development practices, custom business logic handling, and backend integration using Firebase and external APIs.

![image](https://github.com/user-attachments/assets/4a5c494a-b9b7-4b25-8870-cfe23df1254b)


## Overview

The application guides users through four primary screens:

1. Welcome Screen
2. Personal Information Input
3. Meal Builder and Order Placement
4. Order Summary and API Submission

![image](https://github.com/user-attachments/assets/6960afc6-d152-4b5f-8ad4-66b77a39fdc6)
![image](https://github.com/user-attachments/assets/409dfb42-7047-4489-8c08-9d8d6ac779c7)
![image](https://github.com/user-attachments/assets/014ac837-d168-4137-9148-737d7021ee00)



Each screen interacts with user input, calculated data, and external or cloud-hosted resources to build a personalized experience.

---

## Application Flow and Features

### 1. Welcome Screen

- The entry point of the app containing a brief message.
- A button labeled "Start Order" that navigates the user to the input form screen.
- Stateless screen with navigation triggered via an action.

### 2. Personal Information Input Screen

- The user inputs the following data:
  - Gender (Male/Female)
  - Weight (in kilograms)
  - Height (in centimeters)
  - Age (in years)

- Upon form submission, a custom function calculates the user's Basal Metabolic Rate (BMR) using the following formulas:

  - **For Females**:  
    `BMR = 655.1 + (9.56 × weight) + (1.85 × height) - (4.67 × age)`

  - **For Males**:  
    `BMR = 666.47 + (13.75 × weight) + (5 × height) - (6.75 × age)`

- The result is stored in a local state variable for use in the following screen.

- All inputs are validated with appropriate form field validation constraints (e.g., non-negative numbers, mandatory fields).

![image](https://github.com/user-attachments/assets/cf5a6914-96c2-466f-b5f3-3ab915805d62)
![image](https://github.com/user-attachments/assets/82d8f8c4-91c6-49e4-a8fe-309aff897348)
![image](https://github.com/user-attachments/assets/2eb83c57-8321-4819-808a-937d84aa9a5a)



### 3. Meal Builder Screen

- The user sees their calculated calorie requirement.
- Ingredients are fetched dynamically from Firebase Firestore and displayed by category:
  - **Vegetables**
  - **Carbohydrates**
  - **Meats**

![image](https://github.com/user-attachments/assets/a15174f0-d4ec-4ec8-bc19-f73dbf38a811)

#### Firebase Integration Details

- Firebase Firestore is configured as the backend.
- Three top-level collections are defined in Firestore:
  - `vegetables`
  - `carbs`
  - `meats`

![image](https://github.com/user-attachments/assets/2a3eedce-caa6-4ea2-bdaa-d73a7a8297bb)

- Each collection stores documents representing individual ingredients with the following schema:
  ```json
  {
    "name": "Beef",
    "calories": 250,
    "price": 12,
    "image_url": "https://example.com/beef.jpg"
  }




