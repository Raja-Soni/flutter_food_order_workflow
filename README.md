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
<img width="426" height="872" alt="Main_Page" src="https://github.com/user-attachments/assets/34c43e46-8c42-4a19-9372-a0d5d2fcd0cf" />
<img width="421" height="870" alt="Menu_Items_page" src="https://github.com/user-attachments/assets/efdf746c-5395-4529-b97b-6678ffb9a023" />
![Cart_on_Menu_page](https://github.com/user-attachments/assets/fa38fbcf-d931-44c1-ae61-c3ceaae63ec0)
<img width="423" height="872" alt="Checkout_page" src="https://github.com/user-attachments/assets/94bd4ac5-dc88-44a5-a4eb-f2af22359db7" />
<img width="416" height="876" alt="Payment_method_selection" src="https://github.com/user-attachments/assets/508b2ccc-309d-43a2-9ed2-e592e8f5668a" />


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
