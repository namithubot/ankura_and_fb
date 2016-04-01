require 'open-uri'
class AppRootController < ApplicationController
 def create
  auth = auth_hash
  ap auth

  #graph API
  @graph = Koala::Facebook::API.new(auth.credentials.token)

  #posting the cover pic
  image_flag=@graph.put_picture("app/assets/images/ruby.png", {:caption => "Ruby B)"})

  #fetching and layering the profile picture
  #usr_data = @graph.get_object('me')
  #image_prof = @graph.get_picture(usr_data['id'], type: :large)
  #overlay = Magick::Image.read("app/assets/images/delete.png").first
  #open('image.jpg', 'wb') do |f|
  #  f << open(image_prof).read
  #end
  #source = Magick::Image.read("image.jpg").first
  #width = source.columns
  #height = source.rows
  #overlay = overlay.resize_to_fill(width, height)
  #source.composite!(overlay, 0, 0, Magick::OverCompositeOp)
  #source.write("image.jpg")
  #image_flag = @graph.put_picture("image.jpg", {:caption => "Voila! :) www.ruby.org"})

  #post posting jobs
  @image_dat = image_flag['id'] 

  #to redirect to the post which is to be set as profile pic
  #@redirection_path = "http://www.facebook.com/"+@mage_dat

  #redirecting to "set-cover-pic"
  @redirection_path = "http://www.facebook.com/profile.php?preview_cover="+@image_dat
  
  #job done! back to facebook!
  redirect_to @redirection_path 
 end
 
 
 def destroy
  session[:user_id] = nil
  redirect_to root_url
 end

 protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
