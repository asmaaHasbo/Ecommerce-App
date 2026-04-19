### E-Commerce Shopping App 🛍️
A modern Flutter e-commerce application with complete shopping functionality, featuring clean architecture, state management, and seamless API integration.

### app imgs
<img width="640" height="1280" alt="5992407190100184481" src="https://github.com/user-attachments/assets/39588c23-2fbc-4cac-bd3b-fc60bb1e9fdd" />

### 📱 Project Overview
A full-featured e-commerce mobile application built with Flutter, implementing modern development practices including Clean Architecture, BLoC pattern, and API integration. The app provides a smooth shopping experience with product browsing, cart management, and user authentication.

### ✨ Features
### 1-🚀 Splash Screen
Animated splash screen using flutter_native_splash


### 🔐 Authentication System
User registration with validation
API integration using Retrofit
State management with Cubit
Error handling with Freezed

### 🏠 Home Screen
Welcome header with personalized greeting
Smart search bar with voice search option
Brand selector with horizontal scrolling
Product grid with "New Arrival" section
"View All" navigation for expanded views
Favorite/wishlist toggle on products

### 🛒 Shopping Cart
Interactive cart management
Quantity adjustment controls (increment/decrement)
Real-time price calculation
Tax display and breakdown
Remove item functionality
Product image preview
Responsive card layout

### 📦 Product Details
High-quality product image gallery
Image carousel with thumbnail selection
Size selection guide
Detailed product description with "Read More"
Customer reviews section with ratings
Price breakdown (VAT, shipping, total)
"Add to Cart" functionality

### 💝 Wishlist
💝Save favorite products
Quick access to liked items
Empty state with helpful message

###  Wallet
Payment management
Transaction history
Balance display


### 🏗️ Architecture & Code Structure
Clean Architecture Layers
lib/
├── main.dart
├── screens/
│   ├── main_screen.dart          # Bottom navigation controller
│   ├── home_screen.dart          # Main shopping interface
│   ├── cart_screen.dart          # Shopping cart
│   ├── wishlist_screen.dart      # Saved items
│   └── wallet_screen.dart        # Payment management
├── widgets/
│   ├── custom_app_bar.dart       # Reusable app bar
│   ├── welcome_header.dart       # Home greeting
│   ├── search_bar_widget.dart    # Search functionality
│   ├── brand_selector.dart       # Brand filtering
│   ├── product_grid.dart         # Product display
│   ├── cart_item_widget.dart     # Cart item card
│   ├── product_image_widget.dart # Product images
│   └── quantity_control_widget.dart # Quantity buttons
├── models/
│   ├── product_model.dart        # Product data structure
│   ├── product_item_model.dart   # Cart item model
│   └── brand_model.dart          # Brand data
├── services/
│   ├── api_service.dart          # Retrofit API client
│   ├── dio_factory.dart          # Dio configuration
│   └── api_result.dart           # API response handling (Freezed)
├── repository/
│   └── auth_repository.dart      # Authentication logic
├── cubit/
│   ├── auth_cubit.dart           # Authentication state
│   └── auth_state.dart           # State definitions (Freezed)
├── constants/
│   ├── colors.dart               # App color palette
│   └── text_styles.dart          # Typography styles
└── utils/
    └── screen_utility.dart       # Responsive sizing helper
🔧 Technical Implementation

### State Management

BLoC/Cubit for business logic
Freezed for immutable state classes

### API Integration

Retrofit for type-safe API calls
Dio HTTP client with interceptors
Custom error handling with ApiResult
Repository pattern for data layer

### Responsive Design
flutter_screenutil for adaptive sizing

### 🎨 Customization
Color Scheme

Customize text styles

### 🎯 Requirements Achieved

✅ Clean architecture with separation of concerns
✅ Type-safe API integration with Retrofit
✅ Robust state management using Cubit
✅ Immutable state with Freezed
✅ Responsive design across all screen sizes
✅ Smooth animations and transitions
✅ Professional splash screen
✅ Complete authentication flow
✅ Interactive shopping cart
✅ Product browsing and filtering
✅ Error handling and loading states
✅ Reusable component architecture

