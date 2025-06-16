# Flutter Web Portfolio

A fully responsive personal portfolio website built with Flutter Web featuring modern UI design, smooth animations, and mobile-first responsive layout.

## ✨ Features

### 🏠 Landing Page (Hero Section)
- **Profile Display**: Placeholder for profile picture with elegant circular design
- **Animated Text**: Typewriter effect showing different roles (Flutter Developer, Mobile App Developer, UI/UX Designer)
- **Call-to-Action Buttons**: "View My Work" and "Download CV" buttons
- **Social Media Links**: GitHub, LinkedIn, Twitter, and Email links
- **Gradient Background**: Beautiful gradient overlay with modern colors

### 👨‍💻 About Me Section
- **Personal Biography**: Professional story and background
- **Skills Showcase**: 
  - Interactive skill bars with percentage indicators
  - Frontend skills (Flutter, Dart, React, JavaScript)
  - Backend & Tools (Firebase, Node.js, Git, Figma)
- **Statistics Display**: Years of experience, projects completed, happy clients
- **Icon Integration**: FontAwesome icons for enhanced visual appeal

### 💼 Projects Section
- **Project Grid**: Responsive grid layout adapting to screen size
- **6 Sample Projects** included:
  - E-Commerce Mobile App
  - Weather Forecast App
  - Task Management System
  - Fitness Tracking App
  - Recipe Sharing Platform
  - Language Learning App
- **Project Cards Feature**:
  - Gradient backgrounds with unique colors for each project
  - Technology tags
  - GitHub and Live demo buttons
  - Hover effects and animations
  - Project descriptions and icons

### 📧 Contact Section
- **Contact Form** with validation:
  - Name field (required)
  - Email field (required, email validation)
  - Message field (required, minimum 10 characters)
  - Submit button with loading state
- **Contact Information Display**:
  - Email address with mailto link
  - Phone number with tel link
  - Location information
  - Social media links
- **Form Feedback**: Success/error messages
- **Beautiful Gradient Background**: Matching the overall design theme

### 🎨 Design Features
- **Fixed Navigation Bar**: 
  - Transparent when at top, solid background when scrolled
  - Smooth scroll-to-section functionality
  - Responsive mobile menu (hamburger menu for mobile)
  - Animated transitions
- **Responsive Design**: 
  - Mobile-first approach
  - Breakpoints for mobile, tablet, and desktop
  - Adaptive layouts and typography
- **Modern Typography**: Google Fonts (Poppins) integration
- **Smooth Animations**: 
  - Page transitions
  - Hover effects
  - Loading states
  - Typewriter text effects
- **Color Scheme**: Modern gradient colors with purple, blue, and pink tones

## 🛠 Tech Stack

### Core Framework
- **Flutter**: Latest stable version with Web support
- **Dart**: Programming language

### Key Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.2.1           # Typography
  responsive_framework: ^1.5.1    # Responsive design
  animated_text_kit: ^4.2.2      # Text animations
  font_awesome_flutter: ^10.7.0   # Icons
  url_launcher: ^6.2.5           # External links
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Web browser (Chrome recommended for development)
- Git

### Installation

1. **Clone the repository**
```bash
git clone <your-repo-url>
cd flutter-portfolio
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run on web**
```bash
flutter run -d chrome
```

4. **Build for production**
```bash
flutter build web
```

## 🎨 Customization Guide

### 1. Personal Information
Update your name, bio, skills, and contact information in the respective section files.

### 2. Projects
Replace the sample projects with your actual projects in `lib/sections/projects_section.dart`.

### 3. Colors & Branding
Modify the color scheme in `lib/main.dart` to match your personal brand.

---

**Built with ❤️ using Flutter Web**
