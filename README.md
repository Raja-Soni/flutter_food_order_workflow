# Local Food Ordering App

A simple **Flutter app** that allows users to order food from local restaurants, simulating a realistic food delivery workflow.

---

## 📱 App Description

This app demonstrates a complete **food ordering workflow**:

1. Browse a list of **restaurants**.
2. View the **menu** for a selected restaurant.
3. Add items to the **cart**.
4. Manage quantities or remove items in the cart.
5. Checkout and place the **order** with a chosen payment method and delivery address.

**Features:**

- Built using **Bloc architecture** for state management.  
- Realistic workflow with **CartBloc**, **MenuBloc**, **RestaurantBloc**, **CheckoutBloc**, and **AddressBloc**.  
- Proper **error handling** and validation.  
- Aesthetic and responsive UI using `google_fonts` and `page_transition`.  
- Includes **unit tests** for repository and Blocs using `bloc_test` and `mocktail`.

---

## 🖼 Screenshot
#Restaurants Page
<img width="426" height="872" alt="Main_Page" src="https://github.com/user-attachments/assets/34c43e46-8c42-4a19-9372-a0d5d2fcd0cf" />

#Menu Page
<img width="421" height="870" alt="Menu_Items_page" src="https://github.com/user-attachments/assets/efdf746c-5395-4529-b97b-6678ffb9a023" />

#Your Card on Menu Page
<img width="413" height="859" alt="Cart_on_Menu_page" src="https://github.com/user-attachments/assets/1561e51f-1352-4611-a987-3bc0eeb4d82e" />

#Address
<img width="418" height="865" alt="address" src="https://github.com/user-attachments/assets/3da9dae5-0249-448d-bf62-985751a5077e" />

#Full Image of Item
<img width="414" height="866" alt="full_image_of_item" src="https://github.com/user-attachments/assets/529f1ddd-3b35-44bf-96a8-bf429b7b39fa" />

#Checkout Page
<img width="423" height="872" alt="Checkout_page" src="https://github.com/user-attachments/assets/94bd4ac5-dc88-44a5-a4eb-f2af22359db7" />

#Payment Method Selection
<img width="416" height="876" alt="Payment_method_selection" src="https://github.com/user-attachments/assets/508b2ccc-309d-43a2-9ed2-e592e8f5668a" />

#Order Placed Confirmation
<img width="419" height="875" alt="Order_placed_confirmation" src="https://github.com/user-attachments/assets/ec87bc38-56bc-499f-8bff-bcd3b168501f" />


## 🛠 Dependencies

The app uses the following dependencies:

- **flutter**: SDK from Flutter
- **cupertino_icons**: ^1.0.8
- **equatable**: ^2.0.7
- **flutter_bloc**: ^9.1.1
- **page_transition**: ^2.2.1
- **google_fonts**: ^6.3.2
- **mocktail**: ^1.0.4
- **bloc_test**: ^10.0.0

---

## ⚡ Instructions to Run the App

1. **Clone the repository:**

```bash
git clone https://github.com/your-username/food_order_workflow.git
cd food_order_workflow

Install dependencies: flutter pub get

Run the app: flutter run
