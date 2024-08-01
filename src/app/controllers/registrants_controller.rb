# Project name: RoJ Individual Project 
# Description of project: Enhnacing the webinars registrants page of the RoJ application
# Filename: registrants_controller.rb
# Description: define an API endpoint that approves a registrant and declines with a reason 
# Last modified on: 4/8/24 
  

=begin
Project name: ACCR Webinar
Description: This project will keep track of the webinars and their respective speakers.
Filename: registrants_controller.rb
Description: Handles creation of registrants
Last modified on: April 22, 2023
=end
# class RegistrantsController < ApplicationController
#   before_action :set_registrant, only: %i[ show edit update destroy ]
#   skip_before_action :authenticate_user!, only: [:show, :index, :new, :create, :destroy, :update ]

#   # GET /registrants or /registrants.json
#   def index
#     @registrants = Registrant.all
#   end

#   # GET /registrants/1 or /registrants/1.json
#   def show
#   end

#   # GET /registrants/new
#   def new
#     @registrant = Registrant.new
#     @webinar = Webinar.find(params[:format])
#     @webinar.registrants.append(@registrant)
#     # @registrant.webinars.append
#     @webinar_name = @webinar.webinar_name
#   end

#   # GET /registrants/1/edit
#   def edit
#   end

#   # POST /registrants or /registrants.json
  

#   def charge
    
#   end
  
#   # PATCH/PUT /registrants/1 or /registrants/1.json
#   def update
#     respond_to do |format|
#       if @registrant.update(registrant_params)
#         if @registrant.job == 'Private Attorney' or @registrant.job == 'Conflict/Contract Counsel'
#           redirect_to new_charge_path(@registrant.id)
#           return
#         end
#         format.html { redirect_to registrant_url(@registrant), notice: "Registrant was successfully updated." }
#         format.json { render :show, status: :ok, location: @registrant }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @registrant.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /registrants/1 or /registrants/1.json
#   def destroy
#     @registrant.destroy

#     respond_to do |format|
#       format.html { redirect_to registrants_url, notice: "Registrant was successfully destroyed." }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_registrant
#       @registrant = Registrant.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def registrant_params
#       params.require(:registrant).permit(:first_name, :last_name, :email, :webinar, :county, :job, :listserv, :topics)
#     end
# end

class RegistrantsController < ApplicationController
  before_action :set_registrant, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:show, :index, :new, :create, :destroy, :update ]

  # GET /registrants or /registrants.json
  def index
    @registrants = Registrant.all
  end

  # GET /registrants/1 or /registrants/1.json
  def show
  end

  # GET /registrants/new
  def new
    @registrant = Registrant.new
    @webinar = Webinar.find(params[:format])
    @webinar.registrants.append(@registrant)
    # @registrant.webinars.append
    @webinar_name = @webinar.webinar_name
    puts "Does the routing go here?\n\n\n\n\n\n\n\n\n"
  end

  # GET /registrants/1/edit
  def edit
  end

  # POST /registrants or /registrants.json
  

  def charge
    
  end
  
  # PATCH/PUT /registrants/1 or /registrants/1.json
  def update
=begin The following code routes a user to the old payment system.
This code is left in just in case it is needed for some reason...
This code can be deleted if this old system is no longer in use.
if @registrant.job == 'Private Attorney' or @registrant.job == 'Conflict/Contract Counsel'
  redirect_to new_charge_path(@registrant.id)
  return
end
=end
    if registrant_params[:first_name].squish.empty?
      @registrant.errors.add(:first_name, "cannot be blank.")
    end
    if registrant_params[:last_name].squish.empty?
      @registrant.errors.add(:last_name, "cannot be blank.")
    end
    if registrant_params[:email].squish.empty?
      @registrant.errors.add(:email, "cannot be blank.")
    end
    if registrant_params[:county].squish.empty?
      @registrant.errors.add(:county, "cannot be blank.")
    end
    puts "\n\n\nRegistrant Params: #{registrant_params}\n\n\n"
    respond_to do |format|
      if @registrant.errors.none? && @registrant.update(registrant_params)
        format.html { redirect_to registrant_url(@registrant), notice: "Registrant was successfully updated." }
        format.json { render :show, status: :ok, location: @registrant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @registrant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrants/1 or /registrants/1.json
  def destroy
    @registrant.destroy

    respond_to do |format|
      format.html { redirect_to webinars_url, notice: "Registrant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /registrants/:id/approve
  # handles a POST request to set a registrant's approval stastus to true and responds with a success or error status 
  def approve
    @registrant = Registrant.find(params[:id])
    if @registrant.update(approved: true)
      render json: { status: 'success' }, status: :ok
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end
  

  # decline method 
  # To log parameters and update a registrant's status to declined with a reason 
  def decline
    puts "MY" 
    puts params  
    @registrant = Registrant.find(params[:id])
    if @registrant.update(declinedReason: params[:reason], approved: false)
      puts "testing here -  for decline reason"
      # Redirect or render as appropriate
      redirect_to declined_registrants_url( webinar_id: params[:webinar_id]), notice: 'Registrant was successfully declined.'
    else
      # Handle errors
      render :edit, alert: 'Unable to decline the registrant'
    end
  end
  




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registrant
      @registrant = Registrant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def registrant_params
      params.require(:registrant).permit(:first_name, :last_name, :email, :state, :webinar, :county, :job, :listserv, :topics, :cleID)
    end
end