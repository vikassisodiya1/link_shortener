# 🔗 URL Shortener API (Rails 7 + JWT + Swagger)

A simple URL shortener service built with **Ruby on Rails 7**, featuring:

- Shortening long URLs into unique short codes  
- Redirecting short URLs back to original URLs  
- JWT-based authentication for API clients  
- API documentation with Swagger (Rswag)  
- RSpec request specs for API testing  

---

## 🚀 Features

- **Web interface**
  - Submit a long URL via form
  - Receive a shortened URL
  - Visit the short URL to be redirected

- **API (v1)**
  - `POST /api/v1/register` → Register a new user  
  - `POST /api/v1/login` → Login and receive a JWT token  
  - `POST /api/v1/links` → Create a short URL (requires token)  
  - `GET /:short_code` → Redirect to original URL  

- **Authentication**
  - Token-based using **JWT**  
  - Pass token in headers:
    ```http
    Authorization: Bearer <your_token>
    ```

- **Docs**
  - Swagger UI available at:  
    ```
    http://localhost:3000/api-docs
    ```

---

## 🛠 Tech Stack

- **Backend**: Ruby on Rails 7
- **Auth**: JWT
- **Database**: PostgreSQL (or SQLite for dev)
- **API Docs**: Rswag + Swagger UI
- **Testing**: RSpec + Rswag request specs

---

## ⚙️ Setup & Installation

1. **Clone repo**
   ```bash
   git clone https://github.com/yourname/url-shortener.git
   cd url-shortener
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup database**
   ```bash
   rails db:create db:migrate
   ```

4. **Environment variables**

   Create a `.env` file in the project root:

   ```env
   JWT_SECRET=your_secret_key
   ```

5. **Run server**
   ```bash
   rails s
   ```

6. **Access app**
   - Web form: `http://localhost:3000/`
   - Swagger docs: `http://localhost:3000/api-docs`

---

## 🔑 API Authentication

- Register or login to obtain a JWT token:
  ```bash
  curl -X POST http://localhost:3000/api/v1/login   -H "Content-Type: application/json"   -d '{"email":"user@example.com","password":"password123"}'
  ```

- Use the token in subsequent API requests:
  ```bash
  curl -X POST http://localhost:3000/api/v1/links   -H "Content-Type: application/json"   -H "Authorization: Bearer <your_token>"   -d '{"link":{"original_url":"https://example.com"}}'
  ```

---

## 🧪 Running Tests

Run RSpec tests including Swagger request specs:

```bash
bundle exec rspec
```

Generate Swagger docs:

```bash
rake rswag:specs:swaggerize
```

---

## 📂 Project Structure

```
app/
 ├── controllers/
 │    ├── api/v1/
 │    │     ├── auth_controller.rb
 │    │     ├── links_controller.rb
 │    │     └── base_controller.rb
 │    └── links_controller.rb
 ├── models/
 │    └── link.rb
 ├── helpers/
 └── views/
spec/
 ├── integration/ (Rswag specs)
 └── requests/   (RSpec request tests)
```

---

## ✅ Example Workflow

1. Register a new user via API or Rails console  
2. Login → get JWT token  
3. Create short link using API with token  
4. Use short link in browser → redirect to original URL  

---

## 📜 License

MIT License © 2025 Your Name
