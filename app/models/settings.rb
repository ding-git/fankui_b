class Settings < Settingslogic
  source "#{Rails.root}/config/setting.yml"
  namespace Rails.env
end
