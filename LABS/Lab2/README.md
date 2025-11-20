# ️ Flutter Meals App – TheMealDB API

A simple Flutter application that displays recipe categories, meals by category, and full meal details using **TheMealDB** API.

---

##  Features

### **Categories Screen**
- Loads meal categories from `categories.php`
- Shows image, name, and description
- Search bar for filtering
- Random recipe button (`random.php`)

### **Foods By Category Screen**
- Loads meals from `filter.php?c={category}`
- Grid layout (image + name)
- Local search + optional API search (`search.php?s={query}`)

### **Food Details Screen**
- Loads detailed recipe from `lookup.php?i={id}`
- Displays:
    - Image
    - Name
    - Ingredients
    - Instructions
    - YouTube link (if available)

---


##  API Endpoints Used

- `categories.php`
- `filter.php?c={category}`
- `search.php?s={query}`
- `lookup.php?i={id}`
- `random.php`
