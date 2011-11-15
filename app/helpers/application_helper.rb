module ApplicationHelper
  
  
  def present_slug(e)
    d = e.created_at
    present_path :year => d.year, :month => d.strftime("%m"), :day => d.strftime("%d"), :id => e.id
  end
  
end
