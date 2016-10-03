## TIL - Today I Learned

#### `config_for`

Convenience for loading `config/foo.yml` for the current Rails env. This is
an in-built feature which helps to set configurations based on the current Rails
env.

```
  # config/exception_notification.yml:
  production:
    url: http://127.0.0.1:8080
    namespace: my_app_production
  development:
    url: http://localhost:3001
    namespace: my_app_development

  # config/environments/production.rb
  Rails.application.configure do
    config.middleware.use ExceptionNotifier, config_for(:exception_notification)
  end
```
