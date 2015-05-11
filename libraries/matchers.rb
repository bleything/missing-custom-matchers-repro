if defined? ChefSpec
  def do_something(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:something, :do, resource)
  end
end
