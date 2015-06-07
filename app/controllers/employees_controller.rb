require 'csv'

class EmployeesController < ApplicationController
 # before_action :set_listing, only: [:show, :edit, :update, :destroy]
 # before_filter :authenticate_user!, only: [:seller, :new, :create, :edit, :update, :destroy]
 #  before_filter  :check_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user! , :only => [:new, :edit, :create, :update, :destroy, :show, :getdata ]
  # GET /listings
  # GET /listings.json
def index

    @employee = Employee.where("employer = ?", current_user.id)


end

  # GET /listings/new
  def new
    @employee = Employee.new
  end

  # GET /listings/1/edit
  def edit
    @employee = Employee.find(params[:id])
  end

  # POST /listings
  # POST /listings.json
  def create
    @employee = Employee.new(employee_params)
    @employee.employer = current_user.id
    


    respond_to do |format|
      if @employee.save
        format.html { redirect_to employees_path, notice: 'New Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
        redirect_to :back
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    @employee = Employee.find(params[:id])
    
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def show
    @employee = Employee.find(params[:id])
    @tweets = Tweet.where("users = ?", @employee.id).order("created ASC").limit(50)
    @acc=0
    @tot=2
  end

  def getdata
    csv_text = File.read('/Users/antodoms/safe/public/file.csv')
    #csv = CSV.parse(csv_text, :headers => true)
    text=csv_text.split("\n")
    text.each do |row|
      a=Array.new
      cols=row.split(',')
      cols.each do |col|
          a.push(col.gsub(/ ?"(.+)" ?/,'\1'))
        end  
        #0“tweet”,1”score”,2”time”,3”handle”
       tweet  = a[0]
       score = a[1]
       time =  a[2]
       handle = a[3]
      user = Employee.select("id").where("handle = ?", handle)
      @tweet=Tweet.create( created: time, score: score, users: user, handle: handle, tweet: tweet)
      @tweet.save
    end
  end

  def employee_params
      params.require(:employee).permit(:handle, :name)
    end


  end