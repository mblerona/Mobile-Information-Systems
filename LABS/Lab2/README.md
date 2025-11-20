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



## Task requirements
Да се имплементира апликација за прикажување на рецепти со користење на **API од TheMealDB**  
🔗 https://www.themealdb.com/api.php

---

##  Барања

###  Почетен екран – Листа од категории
- Прикажете листа на картички со сите категории на јадења
- Endpoint: `https://www.themealdb.com/api/json/v1/1/categories.php`
- Секоја картичка треба да содржи:
    - име на категорија
    - слика
    - краток опис
- Овозможете пребарување на категории

---

### ️ Екран со јадења по категорија
- При клик на категорија → прикажете сите јадења од таа категорија
- Endpoint:  
  `https://www.themealdb.com/api/json/v1/1/filter.php?c={category}`
- Прикажете ги јадењата во **grid layout** со:
    - слика
    - име
- Овозможете пребарување на јадења од избраната категорија
    - Endpoint (API search):  
      `https://www.themealdb.com/api/json/v1/1/search.php?s={query}`

---

###  Детален приказ на рецепт
- При клик на јадење → отворете екран со деталите за рецептот
- Endpoint:  
  `https://www.themealdb.com/api/json/v1/1/lookup.php?i={id}`
- Прикажете:
    - слика
    - име
    - инструкции
    - состојки
    - YouTube линк (ако постои)

---

###  Рандом рецепт на денот
- Додајте копче во AppBar за приказ на рандом рецепт
- Endpoint:  
  `https://www.themealdb.com/api/json/v1/1/random.php`
- Прикажете **целосен рецепт** со сите детали

---

###  Организација на проектот
Организирајте го кодот во одделни фолдери:
- `models`
- `screens`
- `widgets`
- `services`